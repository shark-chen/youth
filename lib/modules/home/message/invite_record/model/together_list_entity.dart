import 'package:kellychat/generated/json/succeed/together_list_entity.g.dart';
import 'dart:convert';
import 'package:kellychat/utils/extension/maps/maps.dart';
export 'package:kellychat/generated/json/succeed/together_list_entity.g.dart';

class TogetherListEntity {
  int? togetherId;
  int? initiatorId;
  String? initiatorNickname;
  String? initiatorAvatar;
  int? participantId;
  String? participantNickname;
  String? participantAvatar;
  int? tagId;
  String? tagName;
  int? status;
  String? statusText;
  String? createdAt;
  String? completedAt;

  TogetherListEntity();

  factory TogetherListEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $TogetherListEntityFromJson(json);
    }
    return TogetherListEntity();
  }

  Map<String, dynamic> toJson() => $TogetherListEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
