import 'package:youth/generated/json/convert/json_convert_content.dart';
import 'package:youth/modules/home/message/invite_record/model/together_list_entity.dart';

TogetherListEntity $TogetherListEntityFromJson(Map<String, dynamic> json) {
  final TogetherListEntity togetherListEntity = TogetherListEntity();
  final int? togetherId = jsonConvert.convert<int>(json['togetherId']);
  if (togetherId != null) {
    togetherListEntity.togetherId = togetherId;
  }
  final int? initiatorId = jsonConvert.convert<int>(json['initiatorId']);
  if (initiatorId != null) {
    togetherListEntity.initiatorId = initiatorId;
  }
  final String? initiatorNickname = jsonConvert.convert<String>(
      json['initiatorNickname']);
  if (initiatorNickname != null) {
    togetherListEntity.initiatorNickname = initiatorNickname;
  }
  final String? initiatorAvatar = jsonConvert.convert<String>(
      json['initiatorAvatar']);
  if (initiatorAvatar != null) {
    togetherListEntity.initiatorAvatar = initiatorAvatar;
  }
  final int? participantId = jsonConvert.convert<int>(json['participantId']);
  if (participantId != null) {
    togetherListEntity.participantId = participantId;
  }
  final String? participantNickname = jsonConvert.convert<String>(
      json['participantNickname']);
  if (participantNickname != null) {
    togetherListEntity.participantNickname = participantNickname;
  }
  final String? participantAvatar = jsonConvert.convert<String>(
      json['participantAvatar']);
  if (participantAvatar != null) {
    togetherListEntity.participantAvatar = participantAvatar;
  }
  final int? tagId = jsonConvert.convert<int>(json['tagId']);
  if (tagId != null) {
    togetherListEntity.tagId = tagId;
  }
  final String? tagName = jsonConvert.convert<String>(json['tagName']);
  if (tagName != null) {
    togetherListEntity.tagName = tagName;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    togetherListEntity.status = status;
  }
  final String? statusText = jsonConvert.convert<String>(json['statusText']);
  if (statusText != null) {
    togetherListEntity.statusText = statusText;
  }
  final String? createdAt = jsonConvert.convert<String>(json['createdAt']);
  if (createdAt != null) {
    togetherListEntity.createdAt = createdAt;
  }
  final String? completedAt = jsonConvert.convert<String>(json['completedAt']);
  if (completedAt != null) {
    togetherListEntity.completedAt = completedAt;
  }
  return togetherListEntity;
}

Map<String, dynamic> $TogetherListEntityToJson(TogetherListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['togetherId'] = entity.togetherId;
  data['initiatorId'] = entity.initiatorId;
  data['initiatorNickname'] = entity.initiatorNickname;
  data['initiatorAvatar'] = entity.initiatorAvatar;
  data['participantId'] = entity.participantId;
  data['participantNickname'] = entity.participantNickname;
  data['participantAvatar'] = entity.participantAvatar;
  data['tagId'] = entity.tagId;
  data['tagName'] = entity.tagName;
  data['status'] = entity.status;
  data['statusText'] = entity.statusText;
  data['createdAt'] = entity.createdAt;
  data['completedAt'] = entity.completedAt;
  return data;
}

extension TogetherListEntityExtension on TogetherListEntity {
  TogetherListEntity copyWith({
    int? togetherId,
    int? initiatorId,
    String? initiatorNickname,
    String? initiatorAvatar,
    int? participantId,
    String? participantNickname,
    String? participantAvatar,
    int? tagId,
    String? tagName,
    int? status,
    String? statusText,
    String? createdAt,
    String? completedAt,
  }) {
    return TogetherListEntity()
      ..togetherId = togetherId ?? this.togetherId
      ..initiatorId = initiatorId ?? this.initiatorId
      ..initiatorNickname = initiatorNickname ?? this.initiatorNickname
      ..initiatorAvatar = initiatorAvatar ?? this.initiatorAvatar
      ..participantId = participantId ?? this.participantId
      ..participantNickname = participantNickname ?? this.participantNickname
      ..participantAvatar = participantAvatar ?? this.participantAvatar
      ..tagId = tagId ?? this.tagId
      ..tagName = tagName ?? this.tagName
      ..status = status ?? this.status
      ..statusText = statusText ?? this.statusText
      ..createdAt = createdAt ?? this.createdAt
      ..completedAt = completedAt ?? this.completedAt;
  }
}