import 'package:kellychat/generated/json/succeed/doing_hot_tags_entity.g.dart';
import 'dart:convert';
import 'package:kellychat/utils/extension/maps/maps.dart';
export 'package:kellychat/generated/json/succeed/doing_hot_tags_entity.g.dart';

class DoingHotTagsEntity {
  int? tagId;
  String? tagName;
  int? userCount;

  /// 自定义字段
  String? icon;

  DoingHotTagsEntity();

  factory DoingHotTagsEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $DoingHotTagsEntityFromJson(json);
    }
    return DoingHotTagsEntity();
  }

  Map<String, dynamic> toJson() => $DoingHotTagsEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
