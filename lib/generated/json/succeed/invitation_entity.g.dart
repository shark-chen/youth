import 'package:kellychat/generated/json/convert/json_convert_content.dart';
import 'package:kellychat/modules/home/doing/doing_list/model/invitation_entity.dart';

InvitationEntity $InvitationEntityFromJson(Map<String, dynamic> json) {
  final InvitationEntity invitationEntity = InvitationEntity();
  final int? invitationId = jsonConvert.convert<int>(json['invitationId']);
  if (invitationId != null) {
    invitationEntity.invitationId = invitationId;
  }
  final int? fromUserId = jsonConvert.convert<int>(json['fromUserId']);
  if (fromUserId != null) {
    invitationEntity.fromUserId = fromUserId;
  }
  final String? fromNickname = jsonConvert.convert<String>(json['fromNickname']);
  if (fromNickname != null) {
    invitationEntity.fromNickname = fromNickname;
  }
  final String? fromAvatar = jsonConvert.convert<String>(json['fromAvatar']);
  if (fromAvatar != null) {
    invitationEntity.fromAvatar = fromAvatar;
  }
  final int? invitationType = jsonConvert.convert<int>(json['invitationType']);
  if (invitationType != null) {
    invitationEntity.invitationType = invitationType;
  }
  final int? tagId = jsonConvert.convert<int>(json['tagId']);
  if (tagId != null) {
    invitationEntity.tagId = tagId;
  }
  final String? tagName = jsonConvert.convert<String>(json['tagName']);
  if (tagName != null) {
    invitationEntity.tagName = tagName;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    invitationEntity.message = message;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    invitationEntity.status = status;
  }
  final String? inviteCode = jsonConvert.convert<String>(json['inviteCode']);
  if (inviteCode != null) {
    invitationEntity.inviteCode = inviteCode;
  }
  final int? inviteChannel = jsonConvert.convert<int>(json['inviteChannel']);
  if (inviteChannel != null) {
    invitationEntity.inviteChannel = inviteChannel;
  }
  final String? createdAt = jsonConvert.convert<String>(json['createdAt']);
  if (createdAt != null) {
    invitationEntity.createdAt = createdAt;
  }
  final String? handledAt = jsonConvert.convert<String>(json['handledAt']);
  if (handledAt != null) {
    invitationEntity.handledAt = handledAt;
  }
  return invitationEntity;
}

Map<String, dynamic> $InvitationEntityToJson(InvitationEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['invitationId'] = entity.invitationId;
  data['fromUserId'] = entity.fromUserId;
  data['fromNickname'] = entity.fromNickname;
  data['fromAvatar'] = entity.fromAvatar;
  data['invitationType'] = entity.invitationType;
  data['tagId'] = entity.tagId;
  data['tagName'] = entity.tagName;
  data['message'] = entity.message;
  data['status'] = entity.status;
  data['inviteCode'] = entity.inviteCode;
  data['inviteChannel'] = entity.inviteChannel;
  data['createdAt'] = entity.createdAt;
  data['handledAt'] = entity.handledAt;
  return data;
}

extension InvitationEntityExtension on InvitationEntity {
  InvitationEntity copyWith({
    int? invitationId,
    int? fromUserId,
    String? fromNickname,
    String? fromAvatar,
    int? invitationType,
    int? tagId,
    String? tagName,
    String? message,
    int? status,
    String? inviteCode,
    int? inviteChannel,
    String? createdAt,
    String? handledAt,
  }) {
    return InvitationEntity()
      ..invitationId = invitationId ?? this.invitationId
      ..fromUserId = fromUserId ?? this.fromUserId
      ..fromNickname = fromNickname ?? this.fromNickname
      ..fromAvatar = fromAvatar ?? this.fromAvatar
      ..invitationType = invitationType ?? this.invitationType
      ..tagId = tagId ?? this.tagId
      ..tagName = tagName ?? this.tagName
      ..message = message ?? this.message
      ..status = status ?? this.status
      ..inviteCode = inviteCode ?? this.inviteCode
      ..inviteChannel = inviteChannel ?? this.inviteChannel
      ..createdAt = createdAt ?? this.createdAt
      ..handledAt = handledAt ?? this.handledAt;
  }
}
