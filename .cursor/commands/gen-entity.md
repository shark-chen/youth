# skill使用说明 gen-entity sales_category lib/ MyCustomEntity
# sales_category 为 type（决定文件名与根类名）；out 为输出目录；name 可选，不传则根类为 {Type}Entity

name: gen-entity
description: Generate Dart entity from fixed JSON path

inputs:

- name: type
  description: entity type name（蛇形文件名 `{type}_entity.dart`，根类名 `Camel(type)Entity`）
  required: true

- name: out
  description: 输出目录：以 `lib/` 开头为仓库内完整路径；否则为相对 `lib/modules/home/` 的简写（如 `stock/commodity_info/model`）
  required: true

- name: name
  description: 自定义根实体类名（可选，须以 Entity 结尾或脚本会自动补 Entity）
  required: false

## lib/generated/jason.json5

- 脚本固定从此文件读取样例 JSON（支持注释、尾逗号等，见 `scripts/json_entity.py` 的 `load_json5_compatible`）。
- **根对象**即模型数据源；若根上存在与 **type** 同名的键且值为 object/array，则只截取该节点再生成。
- **嵌套 object** 或 **元素为 object 的数组** 会生成独立模型类，类名规则：**父类名去掉 `Entity` 后的前缀 + 子字段 key 的 PascalCase + `Entity`**。
    - 例：`type` = `boy_sku` → 根类 `BoySkuEntity`；其下字段 `kky` 为对象 → `BoySkuKkyEntity`；若 `BoySkuKkyEntity` 内再有对象字段 `foo` → `BoySkuKkyFooEntity`。
- 嵌套字段在 `toJson` 中会生成 `?.toJson()` / `map((v) => v.toJson())`，勿手改生成逻辑时可重新跑脚本覆盖 `.g.dart` 与实体骨架后再合并自定义代码。

## 命令执行

steps:

- run: |
  python3 scripts/json_entity.py \
  {{type}} \
  {{out}} \
  {{name}}
