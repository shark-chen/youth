# KellyChat Universal Links / App Links 配置说明

> 更新日期：2026-05-31  
> 包名 / Bundle ID：`com.onemayy.kelly.chat`  
> 深度链接域名：`https://api.onemayy.com`  
> 路径前缀：`/app`（仅此前缀唤起 App，不影响官网与业务 API）

---

## 1. 深度链接格式

### 1.1 规则

| 项 | 值 |
|---|---|
| Scheme | `https` |
| Host | `api.onemayy.com` |
| 路径前缀 | `/app` |
| 完整形态 | `https://api.onemayy.com/app/{业务路径}?{query}` |

### 1.2 示例（路由尚未接入，仅为约定格式）

```
https://api.onemayy.com/app/chat?userId=123
https://api.onemayy.com/app/invite?code=ABC123
https://api.onemayy.com/app/doing?id=456
```

### 1.3 不会唤起 App 的 URL（仍走浏览器 / 官网 / API）

```
https://api.onemayy.com/                    ← 官网首页
https://api.onemayy.com/web/...             ← 官网页面
https://api.onemayy.com/user/info           ← 业务 API
```

---

## 2. App 端配置状态

### 2.1 已完成（仓库内）

| 平台 | 文件 | 内容 |
|---|---|---|
| iOS | `ios/Runner/Runner.entitlements` | Associated Domains：`applinks:api.onemayy.com` |
| iOS | `ios/Runner.xcodeproj/project.pbxproj` | Debug / Release / Profile 均已绑定 `Runner.entitlements` |
| Android | `android/app/src/main/AndroidManifest.xml` | `autoVerify=true`，host=`api.onemayy.com`，`pathPrefix=/app` |

服务端验证文件模板（供运维部署）：

```
scripts/universal-links/.well-known/apple-app-site-association
scripts/universal-links/.well-known/assetlinks.json
```

**运维部署与验收文档（可直接转发）：** [`docs/universal-links-deploy-ops.md`](universal-links-deploy-ops.md)

**常见问题问答汇总：** [`docs/universal-links-faq.md`](universal-links-faq.md)

### 2.2 App 仍需人工完成

#### Apple Developer（iOS）

1. 登录 [Apple Developer](https://developer.apple.com/account) → **Identifiers** → 选择 App ID `com.onemayy.kelly.chat`
2. 勾选 Capability：**Associated Domains**
3. 保存后，在 Xcode 重新编译 / 让 Automatic Signing 刷新描述文件
4. **卸载旧包、重新安装**后再测 Universal Links（iOS 会缓存 AASA）

#### 签名与指纹（Android）

`scripts/universal-links/.well-known/assetlinks.json` 已填入本项目 keystore 的 **SHA256** 指纹：

| 用途 | SHA256 |
|------|--------|
| Release（`android/keystore/my-release-key.jks`） | `1C:2B:E9:1B:0E:8E:B0:BF:34:84:9E:9F:BB:D1:D0:7F:78:A0:42:AE:67:E9:FF:AA:C9:E9:55:B3:6C:AB:6C:CA` |
| Debug（本机默认 debug.keystore） | `9A:A4:12:4F:85:0A:D3:98:7F:B6:55:DA:F7:BA:57:D8:5A:E7:53:AE:DC:5D:98:4A:4A:32:A8:8E:53:D9:B2:EE` |

> **注意：** `assetlinks.json` 只认 **SHA256**，不能用 MD5 / SHA-1。  
> 若上架 Google Play 且启用 **Play App Signing**，用户安装的 APK 由 Google 重签名，还需把 Play 控制台 → **设置 → 应用完整性 → 应用签名密钥证书** 的 SHA256 追加进 `sha256_cert_fingerprints`（与本地 upload keystore 可能不同）。

重新导出指纹：

```bash
# Debug 包
keytool -list -v \
  -keystore ~/.android/debug.keystore \
  -alias androiddebugkey \
  -storepass android -keypass android

# Release 包（本项目）
keytool -list -v \
  -keystore android/keystore/my-release-key.jks \
  -alias my-key
```

#### Flutter 路由（后续迭代，当前未做）

原生层已声明可接收 `/app/*` 链接，但 **Dart 侧尚未监听与跳转**。后续需要：

1. 添加依赖（推荐 [`app_links`](https://pub.dev/packages/app_links)）
2. 在 `main.dart` 或 Splash 完成后初始化链接监听
3. 解析 `Uri.path` / `queryParameters`，映射到 `Routes.*`

当前行为：链接能唤起 App，但只会进入默认启动流程（Splash → Home），不会按路径跳转。

---

## 3. 后端 / 运维配置

> **运维专用文档（部署步骤、Nginx 示例、验收命令、检查清单）：** [`universal-links-deploy-ops.md`](universal-links-deploy-ops.md)

### 3.1 必须部署的两个文件

在 `api.onemayy.com` 上提供以下 **HTTPS 公开 URL**（不可鉴权、不可 301/302 跳转）：

| 平台 | URL |
|---|---|
| iOS | `https://api.onemayy.com/.well-known/apple-app-site-association` |
| Android | `https://api.onemayy.com/.well-known/assetlinks.json` |

也可同时支持根路径（iOS 备选）：

```
https://api.onemayy.com/apple-app-site-association
```

### 3.2 apple-app-site-association（iOS）

内容见仓库模板 `scripts/universal-links/.well-known/apple-app-site-association`：

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

| 字段 | 说明 |
|---|---|
| `WBVUAXSHB4` | Apple Team ID（与 Xcode `DEVELOPMENT_TEAM` 一致） |
| `paths` | 仅 `/app` 及子路径交给 App，其余 URL 不受影响 |

**响应要求：**

- HTTP 状态码 `200`
- `Content-Type: application/json`（无后缀文件也建议用此类型）
- 响应体为 JSON，**不要**加额外 HTML 包装
- 网关 / WAF **勿拦截** `/.well-known/*`

### 3.3 assetlinks.json（Android）

内容见仓库模板 `scripts/universal-links/.well-known/assetlinks.json`：

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

将 `sha256_cert_fingerprints` 替换为实际 debug / release 签名指纹（**已填入，见 [`universal-links-deploy-ops.md`](universal-links-deploy-ops.md)**）。

**响应要求：**

- HTTP `200`，`Content-Type: application/json`
- 不可跳转

### 3.4 后端业务（可选，建议）

`/app/*` 路径目前仅用于 **唤起 App**，后端可以不实现对应 HTTP 接口；未装 App 的用户点击链接可能看到 404，可按需做降级：

| 方案 | 说明 |
|---|---|
| 302 到应用商店 | 检测 User-Agent，非 App 内打开时跳转 App Store / 应用宝 |
| 简单 H5 落地页 | 展示「在 App 中打开」按钮 + 下载链接 |
| 302 到官网 | 引导用户访问 PC / 移动官网 |

注意：**验证文件本身**（`/.well-known/*`）绝不能 302。

### 3.5 Nginx 配置示例

```nginx
location /.well-known/apple-app-site-association {
    default_type application/json;
    alias /var/www/universal-links/apple-app-site-association;
}

location /.well-known/assetlinks.json {
    default_type application/json;
    alias /var/www/universal-links/assetlinks.json;
}
```

---

## 4. 验证清单

### 4.1 服务端

```bash
# iOS 验证文件可访问
curl -I https://api.onemayy.com/.well-known/apple-app-site-association

# Android 验证文件可访问
curl -I https://api.onemayy.com/.well-known/assetlinks.json

# 查看 JSON 内容
curl https://api.onemayy.com/.well-known/apple-app-site-association
curl https://api.onemayy.com/.well-known/assetlinks.json
```

在线工具（iOS）：[Apple App Search Validation Tool](https://search.developer.apple.com/appsearch-validation-tool/)

### 4.2 Android 真机 / 模拟器

```bash
adb shell am start -a android.intent.action.VIEW \
  -d "https://api.onemayy.com/app/chat?userId=1" \
  com.onemayy.kelly.chat
```

系统设置 → 应用 → KellyChat → **默认打开链接**，应显示 `api.onemayy.com` 已验证。

### 4.3 iOS 真机

1. 确认 AASA 已部署且 App 已重装
2. 在 **备忘录 / 短信** 中粘贴链接（不要直接在 Safari 地址栏输入）：
   ```
   https://api.onemayy.com/app/chat?userId=1
   ```
3. 点击链接，应唤起 KellyChat

### 4.4 不应唤起 App 的对照测试

在站外点击以下链接，应仍打开浏览器 / 官网，**不**进 App：

```
https://api.onemayy.com/
https://api.onemayy.com/web/sendImg/about.htm
```

---

## 5. 常见问题

| 现象 | 可能原因 |
|---|---|
| iOS 链接仍打开 Safari | AASA 未生效；Team ID 错误；需卸载重装 App；链接在 Safari 地址栏直接输入（部分场景不触发 UL） |
| Android 弹出「浏览器 / App 选择」 | `assetlinks.json` 指纹与安装包签名不一致；`autoVerify` 验证失败 |
| 整站都被 App 抢走 | `paths` 误配为 `*`；应仅保留 `/app/*` |
| PC 官网打不开 | Universal Links **不影响 PC**；若 PC 异常，与 UL 配置无关，查 DNS / 服务本身 |

---

## 6. 相关仓库文件索引

```
ios/Runner/Runner.entitlements
ios/Runner.xcodeproj/project.pbxproj
android/app/src/main/AndroidManifest.xml
scripts/universal-links/.well-known/apple-app-site-association
scripts/universal-links/.well-known/assetlinks.json
docs/universal-links.md                    ← App 侧总览
docs/universal-links-deploy-ops.md         ← 运维部署与验收（可转发）
```

---

## 7. 后续 App 路由接入参考（待实现）

路径约定与 GetX 路由映射示例：

| 深度链接路径 | 目标路由（示例） |
|---|---|
| `/app/chat?userId=` | `Routes.chatPage` |
| `/app/invite?code=` | 邀请页（待定） |
| `/app/doing?id=` | `Routes.doingPage` |

实现时建议在 Splash 鉴权完成后再消费 pending link，避免未登录跳转失败。
