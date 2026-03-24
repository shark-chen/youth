import 'package:youth/generated/json/succeed/msg_entity.g.dart';
import 'dart:convert';
import '../../../../utils/extension/maps/maps.dart';

class MsgEntity {
  int? code;
  int? data;
  String? message;
  bool? success;
  int? timestamp;

  MsgEntity();

  factory MsgEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $MsgEntityFromJson(json);
    }
    return MsgEntity();
  }

  Map<String, dynamic> toJson() => $MsgEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
