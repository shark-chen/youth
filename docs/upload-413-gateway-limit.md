# 图片上传 HTTP 413 问题说明（供后端 / 运维排查）

> 文档目的：说明客户端上传头像/照片墙时出现的 **HTTP 413** 与后端 Java `validateImageFile`（5MB 限制）之间的关系，并提供可复现的验证步骤。  
> 客户端仓库：KellyChat（Flutter）  
> 相关接口：`POST /api/user/avatar`、`POST /api/user/photo`（multipart 字段名 `file`）

---

## 1. 现象摘要

| 场景 | 请求体大小 | 结果 |
|------|-----------|------|
| 相册原图直接上传 | 约 **1.27 MB** | **HTTP 413**（Dio `bad response`） |
| 客户端压缩后再上传 | **≤ 1 MB** | **成功** |
| 后端业务校验（代码） | 上限 **5 MB** | 与 1.27MB 即 413 **不一致** |

客户端日志示例（压缩前）：

```text
[MultipartFiles] fromFileWithMaxMb
  原文件: .../image_picker_....jpg (1.27 MB (1330809 B))
  上传文件: .../image_picker_....jpg (1.27 MB (1330809 B))
  上限: 4.0 MB
  是否压缩: false
  是否仍超限: false
```

说明：此前客户端压缩阈值为 4MB，**1.27MB 不会触发压缩**，原尺寸直传导致 413。

---

## 2. 结论（给后端）

1. **HTTP 413** 表示「请求体过大」，通常由 **Nginx / API 网关 / 负载均衡** 在请求到达 Spring 之前拒绝，**不是**业务层 `BusinessException`。
2. 后端 `validateImageFile` 限制为 **5MB**，超限时预期返回 **JSON 业务错误**（如「文件大小不能超过5MB」），**不应**返回 HTTP 413。
3. 结合「**1.27MB 失败、≤1MB 成功**」，当前环境的 **有效上传上限约在 1MB 附近**（与 Nginx 默认 `client_max_body_size 1m` 常见配置一致）。
4. **不能**在未查运维配置前断言「全网关固定 1MB」；需通过下文步骤在 **当前部署环境** 上实测确认。

客户端已临时将上传前压缩上限调整为 **1MB**（`AppConfig.uploadImageMaxSizeMb = 1.0`），作为绕过网关限制的兜底；**运维将网关与 Spring 上限对齐后，客户端可同步调大该常量**。

---

## 3. 请求链路示意

```text
Flutter App
    │  multipart POST /api/user/avatar 或 /api/user/photo
    ▼
[Nginx / Ingress / API 网关]  ← 若 body > client_max_body_size，在此返回 413
    ▼
[Spring Boot 应用]
    │  validateImageFile：空文件 / > 5MB → BusinessException（JSON）
    ▼
业务逻辑
```

---

## 4. 为何不是后端 5MB 校验导致？

| 对比项 | 网关 / 代理 413 | Spring `validateImageFile` |
|--------|-----------------|----------------------------|
| HTTP 状态码 | **413** Payload Too Large | 通常为 **200** + 业务 `code`，或 4xx/5xx + JSON |
| 触发大小（实测） | 约 **> 1MB** 即失败 | 代码写明 **> 5MB** |
| 响应体 | 常为 **HTML** 或 Nginx 默认页 | 多为 **JSON** + `message` 字段 |
| 1.27MB 上传 | **失败（413）** | 按代码应 **通过** 大小校验 |

---

## 5. 建议运维排查项（ definitive ）

请在 **入口 Nginx / Ingress / API 网关** 上确认（名称因环境而异）：

**Nginx 示例：**

```nginx
client_max_body_size;   # 查看当前值，常见默认为 1m
```

**Kubernetes Ingress 注解示例：**

```yaml
nginx.ingress.kubernetes.io/proxy-body-size: "1m"
```

**Spring Boot 应对照（证明应用层允许更大）：**

```properties
spring.servlet.multipart.max-file-size=5MB
spring.servlet.multipart.max-request-size=5MB
```

若网关为 **1m**、Spring 为 **5MB**，即可解释客户端现象。

**建议对齐方案（示例）：**

- 将网关 `client_max_body_size` / `proxy-body-size` 调整为 **≥ 5MB**（与 Java 校验一致），或
- 若网关必须保持 1MB，请将 Java `validateImageFile` 上限改为 **1MB** 并与产品确认，避免文档与真实能力不一致。

---

## 6. 可复现验证步骤

### 6.1 二分法测临界大小（推荐）

使用同一账号、同一接口，上传不同大小的测试文件，记录 HTTP 状态码：

| 测试文件大小 | 预期（当前环境推断） |
|-------------|---------------------|
| 800 KB | 200 |
| 900 KB | 200 |
| 1000 KB | 200 |
| 1100 KB | 可能 **413** |
| 1200 KB | **413** |
| 2 MB | **413** |

临界值落在 **~1MB** 附近，即可证明瓶颈在网关而非 Spring 5MB。

**生成测试文件：**

```bash
dd if=/dev/zero of=test_900k.bin bs=1024 count=900
dd if=/dev/zero of=test_1100k.bin bs=1024 count=1100
```

**curl 示例（请替换域名、Token）：**

```bash
curl -v -X POST "https://<你的域名>/api/user/avatar" \
  -H "Authorization: Bearer <token>" \
  -F "file=@test_1100k.bin;type=image/jpeg;filename=test.jpg"
```

### 6.2 查看 413 响应头与响应体

失败请求请记录：

- `HTTP/1.1 413` 状态行
- `Server` 响应头（如 `nginx` / `openresty`）
- 响应体前若干字节（HTML 错误页 vs JSON 业务错误）

若 `Server: nginx` 且响应体为 HTML，可认定 **413 来自网关层**。

### 6.3 对照：直连应用 vs 经域名（可选）

| 路径 | 同一 2MB 文件预期 |
|------|------------------|
| 经公网域名（走网关） | **413** |
| 直连 Spring 端口（绕过网关，仅测试环境） | 可能 200，或 JSON「超过5MB」，**非 413** |

---

## 7. 客户端侧已做调整

| 项 | 说明 |
|----|------|
| `AppConfig.uploadImageMaxSizeMb` | 设为 **1.0**（MB），上传前通过 `MultipartFiles.fromFileWithMaxMb` 压缩 |
| 涉及接口 | `POST /api/user/avatar`、`POST /api/user/photo` |
| 目的 | 在网关限制调整前，避免用户上传 1MB～4MB 图片时触发 413 |

网关上限调大后，请同步告知客户端，可将 `uploadImageMaxSizeMb` 调整为与后端一致（如 **4.5～5.0**）。

---

## 8. 附：发给运维的简短结论（可复制）

```text
【现象】
- 上传 multipart 到 /api/user/avatar（或 /api/user/photo），原图约 1.27MB → HTTP 413。
- 客户端压缩到 ≤1MB 后，同一接口、同一账号可成功。
- 后端代码校验为 5MB，与 1.27MB 即 413 不符。

【推断】
- 413 在到达 Spring 业务层之前产生，请求体大小上限约 1MB（与 Nginx 默认 client_max_body_size 1m 一致）。
- 非后端 validateImageFile(5MB) 触发。

【请运维确认】
1. 入口 Nginx/Ingress/API 网关的 client_max_body_size / proxy-body-size 当前值。
2. 413 响应的 Server 头与响应体是否来自 Nginx。
3. 若业务需支持更大图片，请将网关限制与 Spring multipart 上限对齐（建议均 ≥5MB）。
```

---

## 9. 参考

- [HTTP 413 Payload Too Large](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/413)
- Nginx：`client_max_body_size` 指令说明

---

*文档生成自客户端联调记录，如有环境差异（测试/预发/生产域名不同），请在对应环境重复 6.1 节测试。*
