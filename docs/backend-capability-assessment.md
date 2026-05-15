# 后端能力评估 — APP 实现状态

> 评估日期：2026/05/15
> 对应后端文档：`service/kellychat/docs`（敲一下 + 一起做需求）

---

## 一、已实现 ✅

| 功能 | 说明 |
|---|---|
| **发布/删除"正在做"状态** | `POST /api/status/doing` + `DELETE /api/status/doing/{statusId}` |
| **获取我的正在做（含伙伴）** | `GET /api/status/my-doing`，已接入 `togetherPartner` |
| **敲一下全流程** | 发送、收件箱、消息页展示、未读数 |
| **一起做基础流程** | 发起（`POST /api/together/create`）、加入（`POST /api/together/{id}/join`）、列表查询（`GET /api/together/my-list`） |
| **邀约系统** | 发送邀约（`POST /api/invitation/send`）、邀约码（`POST /api/invitation/generate-code`）、通过码接受 |
| **消息页头部卡片（显示伙伴）** | `MessageDoingHeaderView`，展示 `tagName` + `togetherPartner.nickname` |

---

## 二、本次已实现（2026-05-15）

### 2.1 一起做按钮状态管理

| 状态 | UI 表现 | 触发条件 |
|---|---|---|
| `available` | 绿色"一起做"，可点击 | 自己未连接，对方也未连接 |
| `disabled` | 灰色"一起做"，不可点击 | 自己已和其他人建立连接 |
| `connected` | 红色"取消"，可点击 | 自己和当前用户已建立连接 |

**涉及文件：**
- `lib/modules/home/doing/doing_list/view/doing_list_cell.dart` — `TogetherButtonStatus` 枚举 + `_buildTogetherButton()`
- `lib/modules/home/doing/doing_list/doing_list_controller.dart` — `togetherButtonStatusFor()` + `clickJoinTogether()` 判断逻辑
- `lib/modules/home/mine/user_info/user_info_controller.dart` — 用户详情页底部按钮状态计算

### 2.2 点击判断逻辑

- **已和对方连接** → 弹窗确认 → 删除正在做状态（TODO：后端缺少取消一起做API）
- **已和其他人连接** → 弹窗提示"你正在与xxx一起做，请取消后再试"
- **未连接** → 原有流程（发送邀约 / 直接加入）

**涉及文件：**
- `lib/modules/home/doing/doing_list/controller/doing_list_route_controller.dart` — `pushAlreadyConnectedDialog()`
- `lib/modules/home/mine/user_info/controller/user_info_route_controller.dart` — 同上

### 2.3 弹窗文案修复

- 去掉固定的"取消旧邀约，并建立新的一起做"文案
- 改为简洁的确认文案："确定向「xxx」发起「xxx」一起做邀约吗？"

### 2.4 数据同步

- `MyDoing` 单例新增 `configDoing()` 方法
- `MessageController.requestMyDoing()` 和 `DoingListController.requestMyDoing()` 获取结果后同步更新 `MyDoing().doing`

---

## 三、部分实现 ⚠️

| 功能 | 当前状态 | 缺失点 |
|---|---|---|
| **一起做确认弹窗** | 有弹窗，文案已简化 | 无法精确判断是否已有"待接受"邀约（缺少 `togetherList` 在 `DoingListController` 中的缓存） |
| **"对方是否已建立一起做"判断** | 列表项有 `togetherId` 字段 | 仅用于判断走"发送邀约"还是"直接加入"，`togetherId` 无法区分"等待中"和"已有伙伴" |

---

## 四、未实现 ❌（需补充开发）

| 后端文档要求 | 当前缺失 | 关键原因 |
|---|---|---|
| **对方详情页"一起做"按钮置灰**（对方已与他人连接） | 未实现 | 需要后端在 `DoingListList` 或用户详情中返回"对方是否已有伙伴"字段 |
| **敲一下实时推送** | IM长连接已初始化，但未看到敲一下/一起做的推送处理 | 可能需要后端配合推送事件，或前端轮询 |
| **标记敲一下已读** | 未实现 | 后端缺少 `POST /api/knock/{id}/read` 接口 |
| **拒绝/忽略邀约** | 未实现 | 后端缺少拒绝邀约接口 |

---

## 五、API 状态修正 🔴

### 后端已有、但 Flutter 端未封装的 API（本次已补充）

| 接口 | 后端路径 | 说明 |
|---|---|---|
| **取消邀约** | `DELETE /api/invitation/{invitationId}` | 发起方取消待处理邀约 |
| **处理邀约（接受/拒绝）** | `POST /api/invitation/{invitationId}/handle` | `action=accept/reject` |
| **邀约收件箱** | `GET /api/invitation/inbox` | 双向合并列表 + 未读数 |
| **收到的邀约** | `GET /api/invitation/received` | 24小时内收到的 |
| **发出的邀约** | `GET /api/invitation/sent` | 24小时内发出的 |

> 以上接口后端 `InvitationController` 已实现，但 `lib/network/net/entry/doing/doing.dart` 中未封装，本次已补充。

### 后端确实缺失的 API

1. **取消/退出一起做** — 没有 `DELETE /api/together/{id}` 或 `POST /api/together/{id}/cancel`
   - 当前临时方案：调用 `DELETE /api/status/doing/{statusId}`（删除正在做状态）
2. **标记敲一下已读** — `BeatItemEntity` 有 `isRead` 字段，但没有对应更新接口
3. **删除敲一下记录** — 没有对应API
4. **获取单个一起做详情** — 只有列表接口 `my-list`

### 后端字段建议补充

- `InvitationVO`（`GET /api/invitation/sent` 返回）建议增加 `toUserId` / `toNickname`，否则前端无法判断发出邀约的目标用户。当前已改用 `GET /api/invitation/inbox` 替代。

---

## 六、关键文件汇总

| 功能 | 文件 |
|---|---|
| 按钮状态枚举 | `lib/modules/home/doing/doing_list/view/doing_list_cell.dart` |
| 状态计算 + 点击逻辑 | `lib/modules/home/doing/doing_list/doing_list_controller.dart` |
| 弹窗路由 | `lib/modules/home/doing/doing_list/controller/doing_list_route_controller.dart` |
| 用户详情页按钮状态 | `lib/modules/home/mine/user_info/user_info_controller.dart` |
| 用户详情页弹窗 | `lib/modules/home/mine/user_info/controller/user_info_route_controller.dart` |
| 消息页头部卡片 | `lib/modules/home/message/view/message_doing_header_view.dart` |
| 伙伴数据模型 | `lib/modules/home/doing/model/doing_partner_entity.dart` |
| 我的正在做单例 | `lib/modules/user/user_center/my_doing/my_doing.dart` |

---

## 七、后续建议

### 短期可做（不依赖后端新接口）
- [x] 利用 `togetherPartner` 字段实现自身连接状态判断
- [x] 根据 `togetherPartner` 实现按钮的基础状态切换
- [x] 修复弹窗文案

### 需后端补充接口
- [ ] **取消/退出一起做** — 最大阻塞点，需要 `DELETE /api/together/{id}` 或类似接口
- [ ] **标记敲一下已读** — 需要 `POST /api/knock/{id}/read`
- [ ] **拒绝邀约** — 需要 `POST /api/invitation/reject` 或类似接口
- [ ] **对方"已与他人连接"字段** — 需要在 `DoingListList` 或用户详情接口中返回 `hasPartner` / `partnerId` 等字段
