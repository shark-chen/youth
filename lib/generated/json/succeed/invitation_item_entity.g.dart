import 'package:kellychat/generated/json/convert/json_convert_content.dart';
import 'package:kellychat/modules/home/doing/doing_list/model/invitation_item_entity.dart';

InvitationItemEntity $InvitationItemEntityFromJson(Map<String, dynamic> json) {
  final InvitationItemEntity invitationItemEntity = InvitationItemEntity();
  final int? invitationId = jsonConvert.convert<int>(json['invitationId']);
  if (invitationId != null) {
    invitationItemEntity.invitationId = invitationId;
  }
  final String? direction = jsonConvert.convert<String>(json['direction']);
  if (direction != null) {
    invitationItemEntity.direction = direction;
  }
  final String? targetUserId = jsonConvert.convert<String>(json['targetUserId']);
  if (targetUserId != null) {
    invitationItemEntity.targetUserId = targetUserId;
  }
  final String? targetNickname = jsonConvert.convert<String>(json['targetNickname']);
  if (targetNickname != null) {
    invitationItemEntity.targetNickname = targetNickname;
  }
  final String? targetAvatar = jsonConvert.convert<String>(json['targetAvatar']);
  if (targetAvatar != null) {
    invitationItemEntity.targetAvatar = targetAvatar;
  }
  final String? interactionDesc = jsonConvert.convert<String>(json['interactionDesc']);
  if (interactionDesc != null) {
    invitationItemEntity.interactionDesc = interactionDesc;
  }
  final String? tagName = jsonConvert.convert<String>(json['tagName']);
  if (tagName != null) {
    invitationItemEntity.tagName = tagName;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    invitationItemEntity.message = message;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    invitationItemEntity.status = status;
  }
  final String? statusText = jsonConvert.convert<String>(json['statusText']);
  if (statusText != null) {
    invitationItemEntity.statusText = statusText;
  }
  final String? displayTime = jsonConvert.convert<String>(json['displayTime']);
  if (displayTime != null) {
    invitationItemEntity.displayTime = displayTime;
  }
  return invitationItemEntity;
}

Map<String, dynamic> $InvitationItemEntityToJson(InvitationItemEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['invitationId'] = entity.invitationId;
  data['direction'] = entity.direction;
  data['targetUserId'] = entity.targetUserId;
  data['targetNickname'] = entity.targetNickname;
  data['targetAvatar'] = entity.targetAvatar;
  data['interactionDesc'] = entity.interactionDesc;
  data['tagName'] = entity.tagName;
  data['message'] = entity.message;
  data['status'] = entity.status;
  data['statusText'] = entity.statusText;
  data['displayTime'] = entity.displayTime;
  return data;
}

extension InvitationItemEntityExtension on InvitationItemEntity {
  InvitationItemEntity copyWith({
    int? invitationId,
    String? direction,
    String? targetUserId,
    String? targetNickname,
    String? targetAvatar,
    String? interactionDesc,
    String? tagName,
    String? message,
    int? status,
    String? statusText,
    String? displayTime,
  }) {
    return InvitationItemEntity()
      ..invitationId = invitationId ?? this.invitationId
      ..direction = direction ?? this.direction
      ..targetUserId = targetUserId ?? this.targetUserId
      ..targetNickname = targetNickname ?? this.targetNickname
      ..targetAvatar = targetAvatar ?? this.targetAvatar
      ..interactionDesc = interactionDesc ?? this.interactionDesc
      ..tagName = tagName ?? this.tagName
      ..message = message ?? this.message
      ..status = status ?? this.status
      ..statusText = statusText ?? this.statusText
      ..displayTime = displayTime ?? this.displayTime;
  }
}
