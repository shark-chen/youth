# KellyChat Universal Links / App Links — 问答汇总

> 整理自研发联调过程中的常见问题。  
> 更新日期：2026-05-31  
> 相关文档：[`universal-links.md`](universal-links.md)（总览）、[`universal-links-deploy-ops.md`](universal-links-deploy-ops.md)（运维部署）

---

## Q1：怎么给 iOS 和 Android 都配置 Universal Links？

**A：** 分三层配置：

| 层级 | iOS | Android |
|------|-----|---------|
| 原生 | `Runner.entitlements` 添加 Associated Domains | `AndroidManifest.xml` 添加 `intent-filter` + `autoVerify` |
| 服务端 | 部署 `apple-app-site-association` | 部署 `assetlinks.json` |
| Flutter（后续） | 监听链接并映射 GetX 路由 | 同上 |

KellyChat 当前 **原生 + 服务端模板** 已就绪；**Flutter 路由跳转尚未接入**。

---

## Q2：业务接口域名是 `https://api.onemayy.com`，可以用它做深度链接吗？

**A：可以。**

Universal Links / App Links 只要求是你控制的 **HTTPS 域名**，不要求单独建子域。KellyChat 已使用：

- 域名：`api.onemayy.com`
- 路径前缀：`/app`（避免与 API、官网冲突）

示例：

```
https://api.onemayy.com/app/chat?userId=123
```

---

## Q3：`api.onemayy.com` 也是 PC 官网域名，Safari 是不是打不开官网了，会直接打开 App？

**A：不会整站都被 App 抢走。**

Universal Links **不是**「这个域名在 Safari 里永远打不开」，而是只有 **AASA / App Links 里声明过的路径** 在特定场景下才会唤起 App。

| 场景 | 行为 |
|------|------|
| PC 浏览器访问 | **不受影响**，Universal Links 只作用于 iOS / Android |
| 手机 Safari 地址栏输入 URL | 一般仍打开网页 |
| 微信 / 短信里点链接 | 若路径被 App 认领且已装 App → 可能唤起 App |
| 官网、API 普通路径 | **不受影响**（未在认领列表中） |

**关键：** 不要用 `paths: ["*"]` 认领整站。KellyChat 仅认领：

```
/app
/app/*
```

因此以下 URL **不会**被 App 抢走：

```
https://api.onemayy.com/
https://api.onemayy.com/web/...
https://api.onemayy.com/user/...
```

---

## Q4：现在的深度链接格式是什么？App 还要配什么？后端还要配什么？

**A：**

### 深度链接格式

```
https://api.onemayy.com/app/{业务路径}?{query}
```

### App 端（仓库内已完成）

| 平台 | 文件 | 内容 |
|------|------|------|
| iOS | `ios/Runner/Runner.entitlements` | `applinks:api.onemayy.com` |
| Android | `android/app/src/main/AndroidManifest.xml` | `host=api.onemayy.com`，`pathPrefix=/app` |

### App 端（仍需人工完成）

1. **Apple Developer**：App ID 开启 Associated Domains，重新签名安装
2. **Android**：若上架 Google Play 且启用 Play App Signing，可能需追加 Play 应用签名 SHA256
3. **Flutter 路由**（后续）：加 `app_links`、监听链接、映射 `Routes.*`

### 后端 / 运维

部署 2 个验证文件到 `api.onemayy.com`：

| 文件 | URL |
|------|-----|
| `apple-app-site-association` | `https://api.onemayy.com/.well-known/apple-app-site-association` |
| `assetlinks.json` | `https://api.onemayy.com/.well-known/assetlinks.json` |

模板路径：

```
scripts/universal-links/.well-known/apple-app-site-association
scripts/universal-links/.well-known/assetlinks.json
```

详细部署步骤见 [`universal-links-deploy-ops.md`](universal-links-deploy-ops.md)。

---

## Q5：是不是把 `scripts/universal-links/.well-known/` 下两个文件交给运维部署就行？

**A：对。**

| 本地文件 | 部署后 URL |
|---------|-----------|
| `apple-app-site-association` | `https://api.onemayy.com/.well-known/apple-app-site-association` |
| `assetlinks.json` | `https://api.onemayy.com/.well-known/assetlinks.json` |

要求：**HTTPS、200、Content-Type: application/json、不可 302、不可鉴权拦截**。

---

## Q6：提供了 MD5 / SHA-1 指纹，怎么配置 `assetlinks.json`？

**A：**

| 你提供的 | 能否写入配置文件 |
|---------|----------------|
| iOS MD5 | **不需要** — iOS 只看 AASA（Team ID + Bundle ID） |
| SHA-1 | **不能** — Google 只认 **SHA256** |

KellyChat 已从项目 keystore 导出 SHA256 并写入 `assetlinks.json`：

| 签名 | SHA256 |
|------|--------|
| Release | `1C:2B:E9:1B:0E:8E:B0:BF:34:84:9E:9F:BB:D1:D0:7F:78:A0:42:AE:67:E9:FF:AA:C9:E9:55:B3:6C:AB:6C:CA` |
| Debug | `9A:A4:12:4F:85:0A:D3:98:7F:B6:55:DA:F7:BA:57:D8:5A:E7:53:AE:DC:5D:98:4A:4A:32:A8:8E:53:D9:B2:EE` |

若上架 Google Play 且启用 Play App Signing，还需把 Play 控制台 **应用签名密钥证书** 的 SHA256 **追加**到数组中（与本地 upload keystore 可能不同）。

---

## Q7：iOS 是不是完全配置好了？

**A：分两层理解。**

### 代码仓库里（iOS 原生）— 已配好

| 项 | 状态 |
|---|---|
| `Runner.entitlements` → `applinks:api.onemayy.com` | 已完成 |
| `project.pbxproj` 绑定 entitlements | 已完成 |
| `AppDelegate.swift` | 标准写法，够用 |
| AASA 文件内容 | 已准备好 |

### 端到端生效 — 还差这些

| 项 | 负责方 |
|---|---|
| Apple Developer 开启 Associated Domains | 研发 / 账号管理员 |
| 运维部署 AASA 到 `api.onemayy.com` | 运维 |
| Flutter 路由监听（链接唤起后跳转页面） | 研发（后续） |
| 卸载重装 App 后真机验证 | 研发 |

**结论：Xcode 工程配置已完成；Universal Links 真正生效还需 Apple 后台 + 服务端 AASA + 真机验证。**

---

## 附录：关键参数速查

| 参数 | 值 |
|------|-----|
| Bundle ID / 包名 | `com.onemayy.kelly.chat` |
| Apple Team ID | `WBVUAXSHB4` |
| 深度链接域名 | `api.onemayy.com` |
| 路径前缀 | `/app` |
| iOS appID（AASA） | `WBVUAXSHB4.com.onemayy.kelly.chat` |
