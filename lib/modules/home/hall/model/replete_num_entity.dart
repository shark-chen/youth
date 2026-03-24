import 'package:youth/generated/json/succeed/replete_num_entity.g.dart';
import 'dart:convert';
import '../../../../utils/extension/maps/maps.dart';

class RepleteNumEntity {
  /// 待认领 数量
  int? movingPlanCount;

  /// 待补货/移货 数量
  int? repletePlanCount;

  RepleteNumEntity();

  factory RepleteNumEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $RepleteNumEntityFromJson(json);
    }
    return RepleteNumEntity();
  }

  Map<String, dynamic> toJson() => $RepleteNumEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
