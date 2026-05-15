import 'package:kellychat/generated/json/succeed/invitation_inbox_entity.g.dart';
import 'dart:convert';
import 'package:kellychat/utils/extension/maps/maps.dart';
export 'package:kellychat/generated/json/succeed/invitation_inbox_entity.g.dart';
import 'invitation_item_entity.dart';

/// 邀约收件箱（对应后端 InvitationInboxVO）
class InvitationInboxEntity {
  int? unreadCount;
  List<InvitationItemEntity>? items;

  InvitationInboxEntity();

  factory InvitationInboxEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $InvitationInboxEntityFromJson(json);
    }
    return InvitationInboxEntity();
  }

  Map<String, dynamic> toJson() => $InvitationInboxEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
