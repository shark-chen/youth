import 'package:kellychat/generated/json/convert/json_convert_content.dart';
import 'package:kellychat/modules/home/mine/user_info/model/current_doing_state_entity.dart';

CurrentDoingStateEntity $CurrentDoingStateEntityFromJson(
    Map<String, dynamic> json) {
  final CurrentDoingStateEntity currentDoingStateEntity =
      CurrentDoingStateEntity();
  final bool? hasCurrentDoing =
      jsonConvert.convert<bool>(json['hasCurrentDoing']);
  if (hasCurrentDoing != null) {
    currentDoingStateEntity.hasCurrentDoing = hasCurrentDoing;
  }
  final int? statusId = jsonConvert.convert<int>(json['statusId']);
  if (statusId != null) {
    currentDoingStateEntity.statusId = statusId;
  }
  final int? tagId = jsonConvert.convert<int>(json['tagId']);
  if (tagId != null) {
    currentDoingStateEntity.tagId = tagId;
  }
  final String? tagName = jsonConvert.convert<String>(json['tagName']);
  if (tagName != null) {
    currentDoingStateEntity.tagName = tagName;
  }
  final bool? hasPendingInvitation =
      jsonConvert.convert<bool>(json['hasPendingInvitation']);
  if (hasPendingInvitation != null) {
    currentDoingStateEntity.hasPendingInvitation = hasPendingInvitation;
  }
  final bool? hasActiveTogether =
      jsonConvert.convert<bool>(json['hasActiveTogether']);
  if (hasActiveTogether != null) {
    currentDoingStateEntity.hasActiveTogether = hasActiveTogether;
  }
  final bool? canQuickInvite =
      jsonConvert.convert<bool>(json['canQuickInvite']);
  if (canQuickInvite != null) {
    currentDoingStateEntity.canQuickInvite = canQuickInvite;
  }
  final bool? canInviteTarget =
      jsonConvert.convert<bool>(json['canInviteTarget']);
  if (canInviteTarget != null) {
    currentDoingStateEntity.canInviteTarget = canInviteTarget;
  }
  final String? cannotInviteReason =
      jsonConvert.convert<String>(json['cannotInviteReason']);
  if (cannotInviteReason != null) {
    currentDoingStateEntity.cannotInviteReason = cannotInviteReason;
  }
  final int? pendingInvitationId =
      jsonConvert.convert<int>(json['pendingInvitationId']);
  if (pendingInvitationId != null) {
    currentDoingStateEntity.pendingInvitationId = pendingInvitationId;
  }
  final int? pendingInvitationToUserId =
      jsonConvert.convert<int>(json['pendingInvitationToUserId']);
  if (pendingInvitationToUserId != null) {
    currentDoingStateEntity.pendingInvitationToUserId =
        pendingInvitationToUserId;
  }
  final String? pendingInvitationToUserNickname =
      jsonConvert.convert<String>(json['pendingInvitationToUserNickname']);
  if (pendingInvitationToUserNickname != null) {
    currentDoingStateEntity.pendingInvitationToUserNickname =
        pendingInvitationToUserNickname;
  }
  return currentDoingStateEntity;
}

Map<String, dynamic> $CurrentDoiingStateEntityToJson(
    CurrentDoingStateEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['hasCurrentDoing'] = entity.hasCurrentDoing;
  data['statusId'] = entity.statusId;
  data['tagId'] = entity.tagId;
  data['tagName'] = entity.tagName;
  data['hasPendingInvitation'] = entity.hasPendingInvitation;
  data['hasActiveTogether'] = entity.hasActiveTogether;
  data['canQuickInvite'] = entity.canQuickInvite;
  data['cannotInviteReason'] = entity.cannotInviteReason;
  data['canInviteTarget'] = entity.canInviteTarget;
  data['pendingInvitationId'] = entity.pendingInvitationId;
  data['pendingInvitationToUserId'] = entity.pendingInvitationToUserId;
  data['pendingInvitationToUserNickname'] =
      entity.pendingInvitationToUserNickname;
  return data;
}

extension CurrentDoiingStateEntityExtension on CurrentDoingStateEntity {
  CurrentDoingStateEntity copyWith({
    bool? hasCurrentDoing,
    int? statusId,
    int? tagId,
    String? tagName,
    bool? hasPendingInvitation,
    bool? hasActiveTogether,
    bool? canQuickInvite,
    String? cannotInviteReason,
    bool? canInviteTarget,
    int? pendingInvitationId,
    String? pendingInvitationToUserNickname,
    int? pendingInvitationToUserId,
  }) {
    return CurrentDoingStateEntity()
      ..hasCurrentDoing = hasCurrentDoing ?? this.hasCurrentDoing
      ..statusId = statusId ?? this.statusId
      ..tagId = tagId ?? this.tagId
      ..tagName = tagName ?? this.tagName
      ..cannotInviteReason = cannotInviteReason ?? this.cannotInviteReason
      ..canInviteTarget = canInviteTarget ?? this.canInviteTarget
      ..hasPendingInvitation = hasPendingInvitation ?? this.hasPendingInvitation
      ..pendingInvitationId = pendingInvitationId ?? this.pendingInvitationId
      ..pendingInvitationToUserNickname = pendingInvitationToUserNickname ??
          this.pendingInvitationToUserNickname
      ..pendingInvitationToUserId =
          pendingInvitationToUserId ?? this.pendingInvitationToUserId
      ..hasActiveTogether = hasActiveTogether ?? this.hasActiveTogether
      ..canQuickInvite = canQuickInvite ?? this.canQuickInvite;
  }
}
