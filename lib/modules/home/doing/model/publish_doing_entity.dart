import 'package:kellychat/generated/json/succeed/publish_doing_entity.g.dart';
import 'dart:convert';
import 'package:kellychat/utils/extension/maps/maps.dart';
export 'package:kellychat/generated/json/succeed/publish_doing_entity.g.dart';

class PublishDoingEntity {
  int? statusId;
  int? tagId;
  String? tagName;
  String? startTime;

  PublishDoingEntity();

  factory PublishDoingEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $PublishDoingEntityFromJson(json);
    }
    return PublishDoingEntity();
  }

  Map<String, dynamic> toJson() => $PublishDoingEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
