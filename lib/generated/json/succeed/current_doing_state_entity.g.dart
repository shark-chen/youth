import 'package:kellychat/generated/json/convert/json_convert_content.dart';
import 'package:kellychat/modules/home/mine/user_info/model/current_doing_state_entity.dart';

CurrentDoingStateEntity $CurrentDoiingStateEntityFromJson(
    Map<String, dynamic> json) {
  final CurrentDoingStateEntity currentDoiingStateEntity = CurrentDoingStateEntity();
  final bool? hasCurrentDoing = jsonConvert.convert<bool>(
      json['hasCurrentDoing']);
  if (hasCurrentDoing != null) {
    currentDoiingStateEntity.hasCurrentDoing = hasCurrentDoing;
  }
  final int? statusId = jsonConvert.convert<int>(json['statusId']);
  if (statusId != null) {
    currentDoiingStateEntity.statusId = statusId;
  }
  final int? tagId = jsonConvert.convert<int>(json['tagId']);
  if (tagId != null) {
    currentDoiingStateEntity.tagId = tagId;
  }
  final String? tagName = jsonConvert.convert<String>(json['tagName']);
  if (tagName != null) {
    currentDoiingStateEntity.tagName = tagName;
  }
  final bool? hasPendingInvitation = jsonConvert.convert<bool>(
      json['hasPendingInvitation']);
  if (hasPendingInvitation != null) {
    currentDoiingStateEntity.hasPendingInvitation = hasPendingInvitation;
  }
  final bool? hasActiveTogether = jsonConvert.convert<bool>(
      json['hasActiveTogether']);
  if (hasActiveTogether != null) {
    currentDoiingStateEntity.hasActiveTogether = hasActiveTogether;
  }
  final bool? canQuickInvite = jsonConvert.convert<bool>(
      json['canQuickInvite']);
  if (canQuickInvite != null) {
    currentDoiingStateEntity.canQuickInvite = canQuickInvite;
  }
  return currentDoiingStateEntity;
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
  }) {
    return CurrentDoingStateEntity()
      ..hasCurrentDoing = hasCurrentDoing ?? this.hasCurrentDoing
      ..statusId = statusId ?? this.statusId
      ..tagId = tagId ?? this.tagId
      ..tagName = tagName ?? this.tagName
      ..hasPendingInvitation = hasPendingInvitation ?? this.hasPendingInvitation
      ..hasActiveTogether = hasActiveTogether ?? this.hasActiveTogether
      ..canQuickInvite = canQuickInvite ?? this.canQuickInvite;
  }
}