import 'package:kellychat/generated/json/succeed/invitation_item_entity.g.dart';
import 'dart:convert';
import 'package:kellychat/utils/extension/maps/maps.dart';
export 'package:kellychat/generated/json/succeed/invitation_item_entity.g.dart';

/// 邀约收件箱单条记录（对应后端 InvitationItemVO）
class InvitationItemEntity {
  int? invitationId;
  String? direction;
  int? targetUserId;
  String? targetNickname;
  String? targetAvatar;
  String? interactionDesc;
  String? tagName;
  String? message;
  int? status;
  String? statusText;
  String? displayTime;

  InvitationItemEntity();

  factory InvitationItemEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $InvitationItemEntityFromJson(json);
    }
    return InvitationItemEntity();
  }

  Map<String, dynamic> toJson() => $InvitationItemEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
