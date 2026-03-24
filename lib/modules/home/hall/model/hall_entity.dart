import 'dart:convert';
import '../../../../generated/json/succeed/hall_entity.g.dart';
import '../../../../utils/extension/maps/maps.dart';
import 'hall_item_entity.dart';

/// FileName hall_entity
///
/// @Author 谌文
/// @Date 2023/9/20 09:35
///
/// @Description 首页数据模型
class HallEntity {
  /// 标题
  String? title;

  /// items
  List<HallItemEntity>? items;

  HallEntity();

  factory HallEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $HallEntityFromJson(json);
    }
    return HallEntity();
  }

  Map<String, dynamic> toJson() => $HallEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
