import 'package:youth/base/base_controller.dart';
import 'package:youth/generated/json/succeed/home_item_entity.g.dart';
import 'dart:convert';
import '../../../../utils/extension/maps/maps.dart';

class HallItemEntity {
  dynamic lang;
  String? name;
  String? description;
  String? logo;
  bool? needVip;
  String? pageName;

  /// 角标数量
  String? markNum;

  Map<String, String> params = {};

  /// 自定义字段- 默认logo
  String? placeholderLogo = "assets/image/common/logo_placeholder@3x.png";

  /// 同步cell增加高度
  double? edgeHeight;

  HallItemEntity();

  factory HallItemEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      var result = $HallItemEntityFromJson(json);
      if (Maps.isNotEmpty(json['params'])) {
        (json['params'] as Map).forEach((key, value) {
          if (value != null) {
            result.params.putIfAbsent(key, () => value.toString());
          }
        });
      }
      return result;
    }
    return HallItemEntity();
  }

  Map<String, dynamic> toJson() => $HallItemEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
