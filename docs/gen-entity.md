# gen-entity 技术说明（youth）

本文说明 Cursor 命令 **`gen-entity`**（`.cursor/commands/gen-entity.md`）与脚本 **`scripts/json_entity.py`** 的职责、生成物约定及与工程网络层 **`jsonConvert`** 的衔接方式。

---

## 1. 目标

根据 **`lib/generated/jason.json5`** 中的样例 JSON，自动生成：

| 输出 | 路径 |
|------|------|
| 实体与嵌套类定义 | `{out}/{type}_entity.dart` |
| `fromJson` / `toJson` 实现 | `lib/generated/json/succeed/{type}_entity.g.dart` |

生成风格与现有模块（如 `DoingListEntity`、`DoingHotTagsEntity`）一致：标量与子对象使用 **`jsonConvert.convert<T>`**，对象列表使用 **`json['x'] as List<dynamic>?` + `map` + `jsonConvert.convert<Inner>`**。

---

## 2. 执行方式

在**项目根目录**（存在 `pubspec.yaml`）执行：

```bash
python3 scripts/json_entity.py <type> <out> [name]
```

### 2.1 `type`（必填）

- 蛇形命名，例如 `doing_list`、`sample_widget`。
- 生成文件名：`{type}_entity.dart` / `{type}_entity.g.dart`。
- 默认根类名：`DoingList` + `Entity` → **`DoingListEntity`**（将 `type` 按 `_`/`-` 分词后 PascalCase）。

### 2.2 `out`（必填）

- **完整路径**：以 `lib/` 开头，例如 `lib/modules/home/doing/doing_list/model`。
- **简写路径**：不以 `lib/` 开头时，相对 **`lib/modules/home/`** 拼接，例如 `doing/doing_list/model` → `lib/modules/home/doing/doing_list/model`。

### 2.3 `name`（可选）

- 自定义**根实体**类名，例如 `MyCustomEntity`；若未以 `Entity` 结尾，脚本会补后缀。
- 仅影响根类名；**文件名仍由 `type` 决定**。

---

## 3. 数据源：`jason.json5`

- 路径固定：**`lib/generated/jason.json5`**（文件名与 BigSeller 侧习惯一致，保留 `jason` 拼写）。
- 支持：
  - `//` 行注释
  - `/* */` 块注释
  - 对象/数组**尾逗号**（会先被剥离再 `json.loads`）

### 3.1 按 `type` 截取子树（可选）

若根 JSON 为对象，且存在与 **type** 同名的键，且值为 **object 或 array**，则只使用该键对应内容作为模型数据源。

示例：根为 `{ "doing_list": { ... } }`，且命令 `type` 为 `doing_list`，则只对 `{ ... }` 生成。

### 3.2 根为数组

若截取后（或根）为数组，则取 **第一个元素** 作为对象结构；空数组则按空对象处理（字段为空）。

---

## 4. 嵌套类命名规则

与 BigSeller 文档一致：

- 父类名去掉末尾 **`Entity`** 得到前缀，再拼接子字段 key 的 **PascalCase** + **`Entity`**。
- 例：`type = boy_sku` → 根类 `BoySkuEntity`；字段 `kky` 为对象 → `BoySkuKkyEntity`；其内 `foo` 为对象 → `BoySkuKkyFooEntity`。

**所有**嵌套类与根类写在**同一个** `{type}_entity.dart` 中；`.g.dart` 中为每个类生成 `$XxxFromJson` / `$XxxToJson`。

---

## 5. 类型推断（简要）

| JSON | Dart |
|------|------|
| `true`/`false` | `bool` |
| 整数 | `int` |
| 浮点 | `double` |
| 字符串 | `String` |
| 对象 | 独立 `XxxEntity`，字段类型为该类 |
| 非空数组且首元素为对象 | `List<InnerEntity>` |
| 非空数组且首元素为标量 | `List<bool|int|double|String>` |
| 空数组 | `List<dynamic>`（`fromJson` 侧按 `List<dynamic>?` 原样 toList） |

---

## 6. 生成后必须手动完成：`json_convert_content.dart`

脚本**不会**自动修改 **`lib/generated/json/convert/json_convert_content.dart`**（避免误改已有机代码）。每个新生成的类都需要注册，否则运行期 `jsonConvert.convert<YourEntity>(...)` 会 **`UnimplementedError`**。

### 6.1 `import`

在文件顶部增加实体文件的 package import，例如：

```dart
import 'package:youth/modules/home/hall/model/sample_widget_entity.dart';
```

### 6.2 `convertFuncMap`

为**每一个**生成出来的类（含嵌套类）增加一项：

```dart
(SampleWidgetEntity).toString(): SampleWidgetEntity.fromJson,
(SampleWidgetMetaEntity).toString(): SampleWidgetMetaEntity.fromJson,
```

### 6.3 `_getListChildType`（按需）

若业务通过 **`JsonConvert.fromJsonAsT<M>`** 且 `M` 为 **`List<某 Entity>`**，需在 `_getListChildType` 中增加与现有 `DoingListList` 类似的分支；仅使用 `fromJson`/`convert` 单对象解析时，可暂不添加。

---

## 7. 重新生成与合并策略

- 再次执行脚本会**覆盖** `{type}_entity.dart` 与 `{type}_entity.g.dart`。
- 若你在实体文件中增加了**手工字段或方法**，重新生成前请备份或用版本管理合并。
- **不要**在 `.g.dart` 中手写业务逻辑；自定义逻辑放在 `{type}_entity.dart` 或独立 extension 文件中。

---

## 8. 与 Cursor 的对应关系

- 命令说明：**`.cursor/commands/gen-entity.md`**
- 实现脚本：**`scripts/json_entity.py`**
- 在 Cursor 聊天中可 @ 上述文件，让助手按相同参数执行或补充注册代码。

---

## 9. 自检命令

```bash
cd /path/to/youth
python3 scripts/json_entity.py sample_widget lib/modules/home/hall/model
dart analyze lib/modules/home/hall/model/sample_widget_entity.dart lib/generated/json/succeed/sample_widget_entity.g.dart
```

（若尚未注册 `json_convert_content`，分析可能通过；运行期解析才会报错，请完成第 6 节。）
