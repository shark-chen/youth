import 'package:kellychat/generated/json/succeed/doing_present_hot_tag_entity.g.dart';
import 'dart:convert';
import 'package:kellychat/utils/extension/maps/maps.dart';
export 'package:kellychat/generated/json/succeed/doing_present_hot_tag_entity.g.dart';

class DoingPresentHotTagEntity {
  int? tagId;
  String? tagName;
  String? icon;

  DoingPresentHotTagEntity();

  factory DoingPresentHotTagEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $DoingPresentHotTagEntityFromJson(json);
    }
    return DoingPresentHotTagEntity();
  }

  Map<String, dynamic> toJson() => $DoingPresentHotTagEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
