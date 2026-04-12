---
name: youth-flutter-conventions
description: >-
  Youth 项目 Flutter/GetX 约定：路由、网络、ThemeColor、实体生成与布局注意点。
  在新增页面、接口、模型或改 UI 样式时使用。
---

# Youth Flutter 项目约定

## 何时使用

- 新增 **页面 / 路由 / Controller / Binding**
- 新增 **HTTP 接口** 或 **JSON 实体**
- 调整 **主题色、列表、滚动、Obx** 布局

## 必读索引

- 仓库根目录 **`AGENTS.md`**（目录表与流程索引）
- 实体生成：**`docs/gen-entity.md`**、**`.cursor/commands/gen-entity.md`**
- 规则：**`.cursor/rules/youth-flutter.mdc`**（alwaysApply）

## 实现要点

### 路由与模块

1. **`lib/modules/routes/app_routes.dart`**：增加 `Routes.xxx` 常量。
2. **`lib/modules/routes/app_pages.dart`**：注册 `GetPage(name: ..., page: ..., binding: ...)`。
3. 模块内典型文件：`*_page.dart`（常继承 `BasePage`）、`*_controller.dart`（`BaseController`）、`*_binding.dart`（`BaseBindings` + `Get.lazyPut` / `Get.put`）。

### 网络

1. URL 集中在 **`lib/config/environment_config/app_config.dart`**。
2. 请求方法放在对应 **`NetMixin`** 类（如 **`User`**、**`Doing`**），通过 **`Net.value<T>()`** 调用。
3. 不要绕过现有拦截器新建裸 **`Dio`**。

### 模型

1. 编辑 **`lib/generated/jason.json5`** 后运行：`python3 scripts/json_entity.py <type> <out> [Name]`。
2. 在 **`lib/generated/json/convert/json_convert_content.dart`** 注册 **`convertFuncMap`** 与列表分支（见 `docs/gen-entity.md`）。

### UI

1. 颜色优先 **`ThemeColor`**（`lib/utils/utils/theme_color.dart`）。
2. **`SingleChildScrollView` + `Column`**：`Column` 必须 **`mainAxisSize: MainAxisSize.min`**。
3. **`Obx` + `SingleChildScrollView`**：优先 **`Obx` 在外层**，子级 **`SizedBox.expand` + `SingleChildScrollView`**，避免 GetX 包装层在无限高约束下 **`size: MISSING`**。

### 文案

- 优先 **`LocaleKeys` / `generated/locales.g.dart`**，避免大面积硬编码中文。

## 范围

- 只改任务相关文件；不擅自升级依赖或全库格式化。
