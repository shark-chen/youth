import 'package:kellychat/generated/json/convert/json_convert_content.dart';
import 'package:kellychat/modules/home/doing/doing_list/model/invitation_inbox_entity.dart';
import 'package:kellychat/modules/home/doing/doing_list/model/invitation_item_entity.dart';

InvitationInboxEntity $InvitationInboxEntityFromJson(
    Map<String, dynamic> json) {
  final InvitationInboxEntity invitationInboxEntity = InvitationInboxEntity();
  final int? unreadCount = jsonConvert.convert<int>(json['unreadCount']);
  if (unreadCount != null) {
    invitationInboxEntity.unreadCount = unreadCount;
  }
  final List<InvitationItemEntity>? items = (json['items'] as List<dynamic>?)
      ?.map((e) =>
          jsonConvert.convert<InvitationItemEntity>(e) as InvitationItemEntity)
      .toList();
  if (items != null) {
    invitationInboxEntity.items = items;
  }
  return invitationInboxEntity;
}

Map<String, dynamic> $InvitationInboxEntityToJson(
    InvitationInboxEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['unreadCount'] = entity.unreadCount;
  data['items'] = entity.items?.map((v) => v.toJson()).toList();
  return data;
}

extension InvitationInboxEntityExtension on InvitationInboxEntity {
  InvitationInboxEntity copyWith({
    int? unreadCount,
    List<InvitationItemEntity>? items,
  }) {
    return InvitationInboxEntity()
      ..unreadCount = unreadCount ?? this.unreadCount
      ..items = items ?? this.items;
  }
}
