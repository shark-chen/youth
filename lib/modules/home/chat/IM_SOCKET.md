# IM Socket 技术说明（KellyChat）

本文档描述 Youth Flutter 端即时通讯（IM）的 **SockJS + STOMP** 协议约定与项目内封装方式，便于后续维护与排查。

## 协议选型与依据

- **后端测试页**：`service/kellychat/tools/websocket-test.html`
- **协议栈**：SockJS + STOMP（并非裸 WebSocket）
- **鉴权方式**：握手 URL query 携带 JWT token（`?token=...`）

## 连接信息

- **Endpoint**：`/ws/chat`
- **完整 URL**：`http(s)://<apiHost>/ws/chat?token=<jwt>`
  - Flutter 端使用 `AppConfig.apiHost` 作为 `<apiHost>`
  - 通过 `AppConfig.buildImSockJsUrl(...)` 拼接

相关代码：
- `lib/config/environment_config/app_config.dart`
  - `AppConfig.imWsPath`（默认 `/ws/chat`）
  - `AppConfig.buildImSockJsUrl(token: ...)`

## STOMP 订阅与发送

### 订阅（接收）

- **消息队列**：`/user/queue/messages`
- **错误队列**：`/user/queue/errors`

### 发送（客户端 -> 服务端）

- **destination**：`/app/chat.send`
- **body(JSON)**：

```json
{
  "toUserId": 102,
  "contentType": 1,
  "content": "hello"
}
```

## 推送消息体字段（服务端 -> 客户端）

服务端推送示例（后端构造 Map）：

- `type`：固定 `"CHAT"`
- `messageId`：消息 id（用于去重）
- `fromUserId`
- `fromNickname`
- `fromAvatar`
- `contentType`：1=文本，2=图片（与测试页一致）
- `content`
- `createdAt`

说明：
- `createdAt` 可能是 `String`、时间戳或 `DateTime` 字符串，Flutter 端展示使用兼容解析。
- 历史消息接口返回的字段可能额外带 `toUserId`（用于会话过滤），Flutter 实体已兼容该字段。

## Flutter 端封装结构

### 依赖

- `stomp_dart_client: ^2.0.0`（**pub.dev**，不再使用仓库内 `packages/` 路径 fork）
  - 与当前工程 `web_socket_channel` 等约束对齐；IM 握手/升级问题以后端与网关配置为主。

### 连接层：`StompImClient`

- 文件：`lib/network/im/stomp_im_client.dart`
- 能力：
  - SockJS + STOMP 连接（url = `buildImSockJsUrl`）
  - 自动订阅 `/user/queue/messages`、`/user/queue/errors`
  - `sendChatMessage(...)` 发送到 `/app/chat.send`
  - 断线自动重连（指数退避，最大 30 秒）

### 服务层：`ImService`（全局）

- 文件：`lib/network/im/im_service.dart`
- 类型：`GetxService`
- 能力：
  - `connectIfNeeded()`：自动从 `Global.getAccessToken` 取 token 连接（无 token 则跳过）
  - 对外暴露 `stateStream/messageStream/errorStream`
  - 对外提供 `sendChatMessage(...)`

注册位置：
- `lib/modules/home/home/home_binding.dart`
  - `Get.put<ImService>(ImService(), permanent: true);`

### 消息模型：`ChatMessageEntity`

- 文件：`lib/modules/home/chat/model/chat_message_entity.dart`
- 字段对齐推送结构：`type/messageId/fromUserId/.../createdAt`
- 内置：
  - `createdAtText`：用于 UI 展示的宽松兼容格式化

### Chat 页面接入

#### Controller

- 文件：`lib/modules/home/chat/chat_controller.dart`
- 行为：
  - 进入页面时调用 `ImService.connectIfNeeded()`
  - 若拿到 `toUserId`，先调用历史接口：
    - `GET /api/message/history/{userId}`（代码见 `controller/chat_request_controller.dart`）
  - 订阅 `ImService.messageStream`：
    - 仅处理 `type == CHAT`
    - 按 `messageId` 去重
    - 基于 `fromUserId/toUserId` 做会话过滤（只保留与当前对话相关的消息）

`toUserId` 获取规则：
- 优先从 `Get.parameters['userId']`
- 其次从 `Get.arguments['userId']` 或 `Get.arguments['toUserId']`

#### Page

- 文件：`lib/modules/home/chat/chat_page.dart`
- 行为：
  - `Obx` 监听 `controller.messages` 渲染列表
  - 输入框发送调用 `controller.sendText(text)`，最终走 `/app/chat.send`

## 排查要点

- **连不上**：
  - 确认 `AppConfig.apiHost` 与后端一致（dev/prod/test 环境）
  - 确认 `AppConfig.imWsPath` 是否为后端真实 endpoint（默认 `/ws/chat`）
  - 确认 token 是否非空且有效（`Global.getAccessToken`）
- **收不到消息**：
  - 后端是否确实推送到 `/user/queue/messages`
  - 推送 `type` 是否为 `"CHAT"`（Flutter 端会过滤非 CHAT）
  - 当前页面是否正确传入 `toUserId`（否则会话过滤可能不匹配）
- **重复消息**：
  - Flutter 端按 `messageId` 去重；若服务端未提供 `messageId`，需要改为其他去重策略（如 hash）

