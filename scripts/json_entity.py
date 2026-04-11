#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""从 lib/generated/jason.json5 生成 Dart Entity + .g.dart（youth 项目，对齐 jsonConvert 风格）。"""
import json
import os
import re
import sys

# 固定 JSON5 样例路径（与 BigSeller gen-entity 一致，文件名保留 jason 拼写）
JSON_BASE = "lib/generated/jason.json5"

PACKAGE = "youth"

class_map = {}


def camel(name):
    return "".join(word.capitalize() for word in re.split(r"_|-", name))


def snake(name):
    s = re.sub(r"(?<!^)(?=[A-Z])", "_", name).lower()
    return re.sub(r"[-\s]+", "_", s).strip("_")


def instance_var(class_name):
    """DoingListEntity -> doingListEntity"""
    return class_name[0].lower() + class_name[1:] if class_name else "entity"


def entity_prefix(parent_class_name):
    if parent_class_name.endswith("Entity"):
        return parent_class_name[:-6]
    return parent_class_name


def scalar_dart_type(v):
    if isinstance(v, bool):
        return "bool"
    if isinstance(v, int):
        return "int"
    if isinstance(v, float):
        return "double"
    return "String"


def dart_type(k, v, parent_class_name):
    if isinstance(v, bool):
        return "bool"
    if isinstance(v, int):
        return "int"
    if isinstance(v, float):
        return "double"
    if isinstance(v, dict):
        nested_prefix = entity_prefix(parent_class_name)
        cname = f"{nested_prefix}{camel(k)}Entity"
        parse_class(cname, v)
        return cname
    if isinstance(v, list):
        if len(v) > 0 and isinstance(v[0], dict):
            nested_prefix = entity_prefix(parent_class_name)
            cname = f"{nested_prefix}{camel(k)}Entity"
            parse_class(cname, v[0])
            return f"List<{cname}>"
        if len(v) > 0:
            return f"List<{scalar_dart_type(v[0])}>"
        return "List<dynamic>"
    return "String"


def from_json_field_lines(k, v, t, inst_name):
    """生成与 youth 现有 .g.dart 一致的 fromJson 赋值片段。"""
    lines = []
    if isinstance(v, dict):
        lines.append(f"  final {t}? {k} = jsonConvert.convert<{t}>(json['{k}']);")
        lines.append(f"  if ({k} != null) {inst_name}.{k} = {k};")
    elif isinstance(v, list):
        if len(v) > 0 and isinstance(v[0], dict):
            inner = t.replace("List<", "").replace(">", "")
            lines.append(
                f"  final List<{inner}>? {k} = (json['{k}'] as List<dynamic>?)"
                f"?.map((e) => jsonConvert.convert<{inner}>(e) as {inner}).toList();"
            )
            lines.append(f"  if ({k} != null) {inst_name}.{k} = {k};")
        elif len(v) > 0:
            inner = scalar_dart_type(v[0])
            lines.append(
                f"  final List<{inner}>? {k} = (json['{k}'] as List<dynamic>?)"
                f"?.map((e) => jsonConvert.convert<{inner}>(e) as {inner}).toList();"
            )
            lines.append(f"  if ({k} != null) {inst_name}.{k} = {k};")
        else:
            lines.append(
                f"  final List<dynamic>? {k} = (json['{k}'] as List<dynamic>?)?.toList();"
            )
            lines.append(f"  if ({k} != null) {inst_name}.{k} = {k};")
    else:
        lines.append(f"  final {t}? {k} = jsonConvert.convert<{t}>(json['{k}']);")
        lines.append(f"  if ({k} != null) {inst_name}.{k} = {k};")
    return lines


def to_json_field_lines(k, v, t):
    if isinstance(v, dict):
        return [f"  data['{k}'] = entity.{k}?.toJson();"]
    if isinstance(v, list) and len(v) > 0 and isinstance(v[0], dict):
        return [f"  data['{k}'] = entity.{k}?.map((v) => v.toJson()).toList();"]
    return [f"  data['{k}'] = entity.{k};"]


def parse_class(class_name, data):
    if class_name in class_map:
        return

    fields = []
    from_lines = []
    to_lines = []
    inst = instance_var(class_name)

    for k, v in data.items():
        t = dart_type(k, v, class_name)
        fields.append(f"  {t}? {k};")
        from_lines.extend(from_json_field_lines(k, v, t, inst))
        to_lines.extend(to_json_field_lines(k, v, t))

    class_map[class_name] = (fields, from_lines, to_lines, inst)


def gen_model_all(entity_file_base, output_dir, root_class_name):
    parts = []
    ordered = sorted(
        class_map.keys(),
        key=lambda c: (0 if c == root_class_name else 1, c),
    )
    for cname in ordered:
        fields, _, _, _ = class_map[cname]
        parts.append(
            f"""
class {cname} {{
{chr(10).join(fields)}

  {cname}();

  factory {cname}.fromJson(dynamic json) {{
    if (Maps.isNotEmpty(json)) {{
      return ${cname}FromJson(json);
    }}
    return {cname}();
  }}

  Map<String, dynamic> toJson() => ${cname}ToJson(this);

  @override
  String toString() {{
    return jsonEncode(this);
  }}
}}
"""
        )

    content = f"""import 'package:{PACKAGE}/generated/json/succeed/{entity_file_base}_entity.g.dart';
import 'dart:convert';
import 'package:{PACKAGE}/utils/extension/maps/maps.dart';
export 'package:{PACKAGE}/generated/json/succeed/{entity_file_base}_entity.g.dart';

{"".join(parts)}
"""

    os.makedirs(output_dir, exist_ok=True)
    file_path = os.path.join(output_dir, f"{entity_file_base}_entity.dart")
    with open(file_path, "w", encoding="utf-8") as f:
        f.write(content)
    print("Generated model:", file_path)


def gen_g_all(entity_file_base, model_import_path, gen_dir, root_class_name):
    parts = []
    ordered = sorted(
        class_map.keys(),
        key=lambda c: (0 if c == root_class_name else 1, c),
    )
    for cname in ordered:
        _, from_lines, to_lines, inst = class_map[cname]
        parts.append(
            f"""
{cname} ${cname}FromJson(Map<String, dynamic> json) {{
  final {cname} {inst} = {cname}();
{chr(10).join(from_lines)}
  return {inst};
}}

Map<String, dynamic> ${cname}ToJson({cname} entity) {{
  final Map<String, dynamic> data = <String, dynamic>{{}};
{chr(10).join(to_lines)}
  return data;
}}
"""
        )

    content = f"""import 'package:{PACKAGE}/generated/json/convert/json_convert_content.dart';
import '{model_import_path}';

{"".join(parts)}
"""

    os.makedirs(gen_dir, exist_ok=True)
    file_path = os.path.join(gen_dir, f"{entity_file_base}_entity.g.dart")
    with open(file_path, "w", encoding="utf-8") as f:
        f.write(content)
    print("Generated g.dart:", file_path)


def build(class_name, entity_file_base, data, output_dir, model_import_path, gen_dir):
    class_map.clear()
    parse_class(class_name, data)
    gen_model_all(entity_file_base, output_dir, class_name)
    gen_g_all(entity_file_base, model_import_path, gen_dir, class_name)


def load_json5_compatible(full_path):
    with open(full_path, "r", encoding="utf-8") as f:
        raw = f.read()
    raw = re.sub(r"//.*", "", raw)
    raw = re.sub(r"/\*.*?\*/", "", raw, flags=re.S)
    raw = re.sub(r",\s*([}\]])", r"\1", raw)
    return json.loads(raw)


def main():
    if len(sys.argv) < 3:
        print(
            "Usage: python3 scripts/json_entity.py <type> <out_dir> [name]",
            file=sys.stderr,
        )
        sys.exit(1)

    type_name = sys.argv[1]
    out_dir = sys.argv[2].replace("\\", "/").strip()
    if out_dir.startswith("lib/"):
        out_dir = os.path.normpath(out_dir)
    else:
        out_dir = os.path.normpath(os.path.join("lib", "modules", "home", out_dir))

    custom_name = sys.argv[3] if len(sys.argv) > 3 and sys.argv[3] else None

    full_path = JSON_BASE
    if not os.path.isfile(full_path):
        raise FileNotFoundError(f"JSON file not found: {full_path}")

    data = load_json5_compatible(full_path)

    if isinstance(data, dict) and type_name in data and isinstance(
        data[type_name], (dict, list)
    ):
        data = data[type_name]

    if isinstance(data, list):
        data = data[0] if len(data) > 0 else {}
    if not isinstance(data, dict):
        raise ValueError("Input JSON root (or type node) must be object or list<object>.")

    raw_class_name = custom_name if custom_name else f"{camel(type_name)}Entity"
    class_name = (
        raw_class_name if raw_class_name.endswith("Entity") else f"{raw_class_name}Entity"
    )
    entity_file_base = snake(type_name)

    model_path_for_pkg = out_dir[4:] if out_dir.startswith("lib/") else out_dir
    model_import_path = (
        f"package:{PACKAGE}/{model_path_for_pkg}/{entity_file_base}_entity.dart"
    )
    gen_dir = os.path.join("lib", "generated", "json", "succeed")

    build(class_name, entity_file_base, data, out_dir, model_import_path, gen_dir)

    print()
    print(">>> 下一步：在 lib/generated/json/convert/json_convert_content.dart 中注册新类型：")
    print("    1) import 实体 dart 文件")
    for i, cname in enumerate(sorted(class_map.keys()), start=2):
        print(f"    {i}) convertFuncMap: ({cname}).toString(): {cname}.fromJson,")
    n = len(class_map) + 2
    print(
        f"    {n}) 若存在 List<自定义模型> 的根级解析需求，在 _getListChildType 增加对应分支"
    )
    print()


if __name__ == "__main__":
    main()
