# AGENTS.md — Youth（Kelly）Flutter 项目指南

供 AI Agent 快速理解本仓库架构与约定；改代码前请对照本文与**同模块相邻文件**风格。更细的协作流程见 **`.cursor/rules/youth-flutter.mdc`** 与 **`.cursor/skills/`**。

---

## 1. 概览

- **包名**：`youth`（`pubspec.yaml`）。
- **技术栈**：Flutter + **GetX**（路由、Binding、Controller、`Rx` / `.obs`）；网络 **Dio** 封装在 **`lib/network/`**；主题色 **`ThemeColor`**（`lib/utils/utils/theme_color.dart`）。

---

## 2. 目录速查

| 路径 | 职责 |
|------|------|
| `lib/main.dart` / `lib/app.dart` | 入口与 `GetMaterialApp`、路由 |
| `lib/modules/` | 业务模块（如 `home/`、`login/`、`user/`） |
| `lib/modules/routes/` | `app_pages.dart` + `part` **`app_routes.dart`**（`Routes`、`GetPage`） |
| `lib/base/` | `BaseController`、`BaseBindings`、`BasePage` 等；大量 export 减少重复 import |
| `lib/network/` | `Net` / `NetMixin`、`DioNet`、拦截器 |
| `lib/widget/` | 通用组件 |
| `lib/config/environment_config/` | `AppConfig`、环境切换 |
| `lib/generated/` | `locales.g.dart`、`json/` 生成物；**慎手改** |
| `docs/gen-entity.md` | 实体生成与 `json_convert_content` 注册说明 |
| `docs/任务计划技术文档说明.md` | 多阶段任务与 `task-plan.md` 用法 |
| `docs/发现即记录技术文档说明.md` | `agent-backlog.md` 发现即记录 |
| `docs/会话交接技术文档说明.md` | 会话交接与 `session-handoff.md` |
| `.cursor/commands/gen-entity.md` | 生成实体命令说明 |

---

### UI 组件

- **优先复用** `lib/widget/` 下已有组件与模式；新增通用 UI 应收敛到 `widget/` 或模块内 `view/`，避免在单页堆超大 `build`。
- **颜色与字体**：优先使用 **`ThemeColor`**（`lib/utils/utils/theme_color.dart`）中已有色值与 `TextStyle`，避免在业务页硬编码大量重复 `Color(0xFF…)`（除非已有局部惯例）。
- **组件索引与 Cursor Skills**：目录级说明与人读索引见 **`lib/widget/README.md`**；弹窗、底部弹层、输入等细化用法与 Agent 清单见 **`.cursor/skills/`** 下 **`widget-*`**（如 `widget-alert`、`widget-bottom-alert`）。改动 `lib/widget/` 某子目录时，优先对照同名前缀的 `SKILL.md`，无需在本文重复罗列全部技能文件名。

### 错误处理与日志


## 3. 新功能约定

1. **模块结构**：常见 **`*_page.dart` + `*_controller.dart` + `*_binding.dart`**，必要时 **`view_model/`**。
2. **路由**：在 **`app_routes.dart`** 增加常量，在 **`app_pages.dart`** 注册 **`GetPage`** + **Binding**。
3. **网络**：在对应 **`NetMixin`** 入口类（如 `User`、`Doing`）增加方法；URL 放 **`AppConfig`**；勿绕过拦截器另起裸 Dio。
4. **模型**：优先 **`scripts/json_entity.py` + `lib/generated/jason.json5`**（见 `docs/gen-entity.md`），并在 **`json_convert_content.dart`** 注册类型。
5. **UI**：颜色优先 **`ThemeColor`**；列表/滚动注意 **`Column` 在 `SingleChildScrollView` 内须 `mainAxisSize: MainAxisSize.min`**；`Obx` 与 `ScrollView` 嵌套时优先 **`Obx` 包在外层**并配合 **`SizedBox.expand`**（见资料页踩坑总结）。
7. **范围**：只改任务相关文件；不做无关大重构或擅自升级依赖。

---

## 4. 协作与上下文（本机文件）

多阶段任务、收工交接等约定见 **`.cursor/rules/youth-flutter.mdc`**：

- **`.cursor/task-plan.md`**（gitignore）：阶段勾选，防「过早宣告完成」。
- **`.cursor/agent-backlog.md`**（gitignore）：发现即记录，追加一行一条。
- **`.cursor/session-handoff.md`**（gitignore）：会话交接落盘。

模板在 **`.cursor/*.template.md`**；命令在 **`.cursor/commands/`**。  
设计背景与迁移说明见 **`docs/`** 下上述三篇技术说明。

---

*与团队内部规范冲突时，以团队规范为准。*
