import 'package:kellychat/generated/json/succeed/invite_friend_entity.g.dart';
import 'dart:convert';
import 'package:kellychat/utils/extension/maps/maps.dart';
export 'package:kellychat/generated/json/succeed/invite_friend_entity.g.dart';

class InviteFriendEntity {
  String? inviteCode;
  String? link;
  String? wechat;
  String? command;

  InviteFriendEntity();

  factory InviteFriendEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $InviteFriendEntityFromJson(json);
    }
    return InviteFriendEntity();
  }

  Map<String, dynamic> toJson() => $InviteFriendEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
