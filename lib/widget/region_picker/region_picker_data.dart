import 'dart:convert';

/// 省市区 JSON 对应的数据结构（解析用，与 UI 分离）
///
/// [parseRegionProvincesJson] 支持：
/// - **数组**（推荐）：`assets/data/china_regions.json`，由 `dart run tool/gen_china_regions.dart` 自 modood 数据生成并含港澳台补充；
/// - **对象**（modood `pca`）：`{ "广东省": { "深圳市": ["南山区", ...] }, ... }`。
class RegionProvince {
  RegionProvince({required this.name, required this.cities});

  final String name;
  final List<RegionCity> cities;

  factory RegionProvince.fromJson(Map<String, dynamic> json) {
    return RegionProvince(
      name: json['name'] as String,
      cities: (json['cities'] as List<dynamic>)
          .map((e) => RegionCity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class RegionCity {
  RegionCity({required this.name, required this.districts});

  final String name;
  final List<String> districts;

  factory RegionCity.fromJson(Map<String, dynamic> json) {
    return RegionCity(
      name: json['name'] as String,
      districts: (json['districts'] as List<dynamic>).map((e) => '$e').toList(),
    );
  }
}

/// 从 JSON 字符串解析为省列表
List<RegionProvince> parseRegionProvincesJson(String jsonString) {
  final decoded = jsonDecode(jsonString);
  if (decoded is List) {
    return decoded
        .map((e) => RegionProvince.fromJson(e as Map<String, dynamic>))
        .toList();
  }
  if (decoded is Map<String, dynamic>) {
    return _parseModoodPcaMap(decoded);
  }
  throw FormatException('省市区 JSON 根节点须为数组或 modood pca 对象');
}

List<RegionProvince> _parseModoodPcaMap(Map<String, dynamic> root) {
  final out = <RegionProvince>[];
  for (final pe in root.entries) {
    final pName = pe.key;
    final cVal = pe.value;
    if (cVal is! Map<String, dynamic>) continue;
    final cities = <RegionCity>[];
    for (final ce in cVal.entries) {
      final dVal = ce.value;
      if (dVal is! List) continue;
      cities.add(RegionCity(
        name: ce.key,
        districts: dVal.map((x) => '$x').toList(),
      ));
    }
    out.add(RegionProvince(name: pName, cities: cities));
  }
  return out;
}
