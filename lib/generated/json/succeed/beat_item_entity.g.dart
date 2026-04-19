import 'package:youth/generated/json/convert/json_convert_content.dart';
import 'package:youth/modules/home/message/beat_record/model/beat_item_entity.dart';

BeatItemEntity $BeatItemEntityFromJson(Map<String, dynamic> json) {
  final BeatItemEntity beatItemEntity = BeatItemEntity();
  final int? knockId = jsonConvert.convert<int>(json['knockId']);
  if (knockId != null) {
    beatItemEntity.knockId = knockId;
  }
  final int? fromUserId = jsonConvert.convert<int>(json['fromUserId']);
  if (fromUserId != null) {
    beatItemEntity.fromUserId = fromUserId;
  }
  final String? fromNickname = jsonConvert.convert<String>(
      json['fromNickname']);
  if (fromNickname != null) {
    beatItemEntity.fromNickname = fromNickname;
  }
  final String? fromAvatar = jsonConvert.convert<String>(json['fromAvatar']);
  if (fromAvatar != null) {
    beatItemEntity.fromAvatar = fromAvatar;
  }
  final String? tagName = jsonConvert.convert<String>(json['tagName']);
  if (tagName != null) {
    beatItemEntity.tagName = tagName;
  }
  final String? statusMessage = jsonConvert.convert<String>(
      json['statusMessage']);
  if (statusMessage != null) {
    beatItemEntity.statusMessage = statusMessage;
  }
  final bool? isRead = jsonConvert.convert<bool>(json['isRead']);
  if (isRead != null) {
    beatItemEntity.isRead = isRead;
  }
  final String? createdAt = jsonConvert.convert<String>(json['createdAt']);
  if (createdAt != null) {
    beatItemEntity.createdAt = createdAt;
  }
  return beatItemEntity;
}

Map<String, dynamic> $BeatItemEntityToJson(BeatItemEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['knockId'] = entity.knockId;
  data['fromUserId'] = entity.fromUserId;
  data['fromNickname'] = entity.fromNickname;
  data['fromAvatar'] = entity.fromAvatar;
  data['tagName'] = entity.tagName;
  data['statusMessage'] = entity.statusMessage;
  data['isRead'] = entity.isRead;
  data['createdAt'] = entity.createdAt;
  return data;
}

extension BeatItemEntityExtension on BeatItemEntity {
  BeatItemEntity copyWith({
    int? knockId,
    int? fromUserId,
    String? fromNickname,
    String? fromAvatar,
    String? tagName,
    String? statusMessage,
    bool? isRead,
    String? createdAt,
  }) {
    return BeatItemEntity()
      ..knockId = knockId ?? this.knockId
      ..fromUserId = fromUserId ?? this.fromUserId
      ..fromNickname = fromNickname ?? this.fromNickname
      ..fromAvatar = fromAvatar ?? this.fromAvatar
      ..tagName = tagName ?? this.tagName
      ..statusMessage = statusMessage ?? this.statusMessage
      ..isRead = isRead ?? this.isRead
      ..createdAt = createdAt ?? this.createdAt;
  }
}