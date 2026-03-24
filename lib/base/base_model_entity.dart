import 'dart:convert';
import 'package:youth/generated/json/succeed/base_model_entity.g.dart';
import '../utils/extension/maps/maps.dart';

class BaseModelEntity {
  int? code;
  int? errorType;
  String? msg;
  String? platformMsg;
  String? defaultMsg;
  dynamic data;
  dynamic detail;
  bool? success;

  BaseModelEntity();

  factory BaseModelEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $BaseModelEntityFromJson(json);
    }
    return BaseModelEntity();
  }

  Map<String, dynamic> toJson() => $BaseModelEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

