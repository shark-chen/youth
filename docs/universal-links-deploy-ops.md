# KellyChat 深度链接 — 运维部署说明

> **用途：** 在 `api.onemayy.com` 部署 iOS / Android 深度链接（Universal Links / App Links）验证文件。  
> **更新日期：** 2026-05-31  
> **App 包名：** `com.onemayy.kelly.chat`  
> **域名：** `api.onemayy.com`（与 PC 官网、业务 API 同域；仅 `/app/*` 路径关联 App，不影响其他路径）

---

## 一、需要部署的文件（共 2 个）

研发侧已准备好，位于代码仓库：

```
scripts/universal-links/.well-known/apple-app-site-association
scripts/universal-links/.well-known/assetlinks.json
```

部署后须能通过 HTTPS 公开访问：

| 序号 | 本地文件 | 线上 URL |
|:---:|---------|----------|
| 1 | `apple-app-site-association` | `https://api.onemayy.com/.well-known/apple-app-site-association` |
| 2 | `assetlinks.json` | `https://api.onemayy.com/.well-known/assetlinks.json` |

---

## 二、文件完整内容

可直接复制以下内容创建文件（**内容与仓库模板一致，已填好参数，无需再改**）。

### 2.1 apple-app-site-association（iOS）

文件名：`apple-app-site-association`（**无后缀**）

```json
{
  "applinks": {
    "apps": [],
    "details": [
      {
        "appID": "WBVUAXSHB4.com.onemayy.kelly.chat",
        "paths": ["/app", "/app/*"]
      }
    ]
  }
}
```

说明：

- 仅路径 `/app` 及 `/app/*` 会关联 KellyChat App
- 官网首页、API 接口等其它路径**不受影响**

### 2.2 assetlinks.json（Android）

文件名：`assetlinks.json`

```json
[
  {
    "relation": ["delegate_permission/common.handle_all_urls"],
    "target": {
      "namespace": "android_app",
      "package_name": "com.onemayy.kelly.chat",
      "sha256_cert_fingerprints": [
        "1C:2B:E9:1B:0E:8E:B0:BF:34:84:9E:9F:BB:D1:D0:7F:78:A0:42:AE:67:E9:FF:AA:C9:E9:55:B3:6C:AB:6C:CA",
        "9A:A4:12:4F:85:0A:D3:98:7F:B6:55:DA:F7:BA:57:D8:5A:E7:53:AE:DC:5D:98:4A:4A:32:A8:8E:53:D9:B2:EE"
      ]
    }
  }
]
```

说明：

- 第一条为 **Release 签名** SHA256
- 第二条为 **Debug 签名** SHA256（供研发调试 App Links 验证）
- 若后续上架 Google Play 且启用 Play App Signing，研发会提供 Play 应用签名证书的 SHA256，需**追加**到 `sha256_cert_fingerprints` 数组，勿删除已有条目

---

## 三、部署硬性要求（必须全部满足）

| # | 要求 | 说明 |
|---|------|------|
| 1 | HTTPS | 必须 `https://`，不可 HTTP |
| 2 | 状态码 200 | 两个 URL 均返回 HTTP 200 |
| 3 | 禁止跳转 | 访问上述 URL **不得** 301 / 302 跳转到其它地址 |
| 4 | Content-Type | 响应头为 `application/json` |
| 5 | 公开访问 | **不可**要求登录、Token、Cookie 鉴权 |
| 6 | 网关放行 | WAF / 防火墙 / API 网关 **勿拦截** `/.well-known/*` |
| 7 | 响应体纯净 | 返回 JSON 正文，不要包 HTML 页面 |

---

## 四、部署方法

### 方法 A：Nginx 静态文件（推荐）

**1. 上传文件到服务器**

```bash
# 示例目录，可按实际规范调整
sudo mkdir -p /var/www/kellychat-universal-links/.well-known

# 将两个文件放到该目录
# /var/www/kellychat-universal-links/.well-known/apple-app-site-association
# /var/www/kellychat-universal-links/.well-known/assetlinks.json
```

**2. Nginx 配置**

在 `api.onemayy.com` 的 server 块中加入：

```nginx
location = /.well-known/apple-app-site-association {
    default_type application/json;
    alias /var/www/kellychat-universal-links/.well-known/apple-app-site-association;
    add_header Cache-Control "public, max-age=3600";
}

location = /.well-known/assetlinks.json {
    default_type application/json;
    alias /var/www/kellychat-universal-links/.well-known/assetlinks.json;
    add_header Cache-Control "public, max-age=3600";
}
```

**3. 检查并重载**

```bash
sudo nginx -t
sudo nginx -s reload
```

> 若 `api.onemayy.com` 已有统一反向代理到后端 Java / Node 等服务，请在网关层**优先匹配**上述 `/.well-known/` 路径走静态文件，避免被业务服务 404 或鉴权拦截。

---

### 方法 B：对象存储 + CDN

适用：域名已接 CDN（阿里云 OSS、腾讯云 COS、AWS S3 等）。

1. 上传两个文件到 Bucket，路径保持 `.well-known/...`
2. 绑定域名 `api.onemayy.com` 或配置 CDN 回源规则
3. 在 CDN 控制台为这两个文件设置：
   - 响应 `Content-Type: application/json`
   - **关闭** 强制 HTTPS 跳转链（源站已是 HTTPS 即可）
   - 确保不会 302 到登录页

---

### 方法 C：Spring Boot / 后端内嵌（不推荐，仅作备选）

若必须在应用内提供，可增加不受鉴权拦截的静态资源映射，例如：

```java
// 示例：Spring MVC 映射，需确保 Security 放行 /.well-known/**
registry.addResourceHandler("/.well-known/**")
        .addResourceLocations("classpath:/well-known/");
```

将两个文件放在 `src/main/resources/well-known/` 下，并配置 Security 白名单：

```
/.well-known/apple-app-site-association
/.well-known/assetlinks.json
```

---

## 五、部署后验证

### 5.1 基础连通性（运维必做）

在任意可访问外网的机器执行：

```bash
# 1. 检查 HTTP 状态码与 Content-Type（iOS）
curl -sS -D - -o /dev/null https://api.onemayy.com/.well-known/apple-app-site-association

# 2. 检查 HTTP 状态码与 Content-Type（Android）
curl -sS -D - -o /dev/null https://api.onemayy.com/.well-known/assetlinks.json
```

**期望结果：**

```
HTTP/2 200
content-type: application/json
```

**不合格示例：**

| 现象 | 问题 |
|------|------|
| `HTTP/1.1 301` / `302` | 存在跳转，需修正 |
| `HTTP/1.1 401` / `403` | 被鉴权拦截，需加白名单 |
| `HTTP/1.1 404` | 文件未部署或路径错误 |
| `content-type: text/html` | 返回了错误页而非 JSON |

---

### 5.2 检查响应内容

```bash
# iOS 文件内容
curl -sS https://api.onemayy.com/.well-known/apple-app-site-association | python3 -m json.tool

# Android 文件内容
curl -sS https://api.onemayy.com/.well-known/assetlinks.json | python3 -m json.tool
```

**期望：**

- 输出合法 JSON，无 HTML 杂质
- `appID` 为 `WBVUAXSHB4.com.onemayy.kelly.chat`
- `package_name` 为 `com.onemayy.kelly.chat`
- `paths` 含 `"/app"` 和 `"/app/*"`

---

### 5.3 检查是否被重定向

```bash
curl -sS -I -L --max-redirs 0 https://api.onemayy.com/.well-known/apple-app-site-association
curl -sS -I -L --max-redirs 0 https://api.onemayy.com/.well-known/assetlinks.json
```

**期望：** 首条响应即为 `200`，中间无 `Location:` 跳转头。

---

### 5.4 iOS 在线验证（可选，建议研发联调时使用）

Apple 官方验证工具：

https://search.developer.apple.com/appsearch-validation-tool/

输入域名：`api.onemayy.com`，检查 AASA 文件是否被 Apple 正确解析。

---

### 5.5 Android 域名验证（可选）

Google 文档说明：Android 安装 App 后会自动请求 `assetlinks.json` 做 `autoVerify`。

运维侧只需保证 **5.1 ~ 5.3** 通过；App 安装后可在 Android 手机：

**设置 → 应用 → KellyChat → 默认打开链接**

查看 `api.onemayy.com` 是否显示 **已验证**。

---

### 5.6 验证清单（运维签字用）

| 检查项 | 命令 / 方式 | 通过 □ |
|--------|------------|:------:|
| iOS 文件 HTTP 200 | `curl -I .../apple-app-site-association` | |
| Android 文件 HTTP 200 | `curl -I .../assetlinks.json` | |
| Content-Type 为 application/json | 见响应头 | |
| 无 301/302 跳转 | `curl -I --max-redirs 0` | |
| JSON 内容正确 | `curl \| python3 -m json.tool` | |
| 无登录鉴权拦截 | 浏览器无痕模式直接访问 URL | |
| WAF 已放行 `/.well-known/*` | 安全策略确认 | |

---

## 六、常见问题排查

| 现象 | 排查方向 |
|------|----------|
| 404 | 文件路径不对；Nginx `location` 未生效；被后端路由覆盖 |
| 401 / 403 | API 网关 / Spring Security 未放行；WAF 规则拦截 |
| 302 到登录页 | 全站强制鉴权；需单独为 `/.well-known/*` 配置白名单 |
| Content-Type 为 text/plain | Nginx 加 `default_type application/json;` |
| iOS 仍不唤起 App | 多为 App 侧或 Apple 缓存问题；**服务端只需保证 AASA 可访问** |
| Android 提示选择浏览器打开 | `assetlinks.json` 不可访问，或 SHA256 指纹与安装包签名不匹配（联系研发） |

---

## 七、与业务路径的关系

| URL 示例 | 行为 |
|----------|------|
| `https://api.onemayy.com/` | 正常官网，**不**关联 App |
| `https://api.onemayy.com/web/...` | 正常官网，**不**关联 App |
| `https://api.onemayy.com/user/...` | 正常 API，**不**关联 App |
| `https://api.onemayy.com/app/chat?userId=123` | 关联 KellyChat App（已安装则唤起 App） |

`/app/*` 路径的 HTTP 业务接口**非必须**；未装 App 的用户访问可能 404，后续可由研发决定是否做 H5 落地页。**本次运维只需部署上述 2 个验证文件。**

---

## 八、联系人

| 事项 | 对接 |
|------|------|
| 文件内容变更、SHA256 指纹追加 | 研发团队 |
| 域名 / Nginx / CDN / WAF 配置 | 运维团队 |
| App 侧联调、真机测试 | 研发团队 |

---

## 附录：快速复制命令（部署完成后一键验收）

```bash
DOMAIN="api.onemayy.com"

echo "=== iOS AASA ==="
curl -sS -w "\nHTTP_CODE:%{http_code}\n" \
  "https://${DOMAIN}/.well-known/apple-app-site-association" | tail -5

echo ""
echo "=== Android assetlinks ==="
curl -sS -w "\nHTTP_CODE:%{http_code}\n" \
  "https://${DOMAIN}/.well-known/assetlinks.json" | tail -5

echo ""
echo "=== Redirect check (expect 200, no Location header) ==="
curl -sS -I --max-redirs 0 \
  "https://${DOMAIN}/.well-known/apple-app-site-association" | head -10
curl -sS -I --max-redirs 0 \
  "https://${DOMAIN}/.well-known/assetlinks.json" | head -10
```

全部通过后，通知研发团队进行 App 真机联调。
