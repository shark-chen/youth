import 'package:kellychat/generated/json/succeed/invitation_entity.g.dart';
import 'dart:convert';
import 'package:kellychat/utils/extension/maps/maps.dart';
export 'package:kellychat/generated/json/succeed/invitation_entity.g.dart';

/// 邀约实体（对应后端 InvitationVO）
class InvitationEntity {
  int? invitationId;
  int? fromUserId;
  String? fromNickname;
  String? fromAvatar;
  int? invitationType;
  int? tagId;
  String? tagName;
  String? message;
  int? status;
  String? inviteCode;
  int? inviteChannel;
  String? createdAt;
  String? handledAt;

  InvitationEntity();

  factory InvitationEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $InvitationEntityFromJson(json);
    }
    return InvitationEntity();
  }

  Map<String, dynamic> toJson() => $InvitationEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
