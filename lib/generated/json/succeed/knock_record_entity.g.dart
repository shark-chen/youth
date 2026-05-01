import 'package:kellychat/generated/json/convert/json_convert_content.dart';
import 'package:kellychat/modules/home/message/model/knock_record_entity.dart';

KnockRecordEntity $KnockRecordEntityFromJson(Map<String, dynamic> json) {
  final KnockRecordEntity knockRecordEntity = KnockRecordEntity();
  final int? unreadCount = jsonConvert.convert<int>(json['unreadCount']);
  if (unreadCount != null) {
    knockRecordEntity.unreadCount = unreadCount;
  }
  final List<KnockRecordItems>? items = (json['items'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<KnockRecordItems>(e) as KnockRecordItems)
      .toList();
  if (items != null) {
    knockRecordEntity.items = items;
  }
  return knockRecordEntity;
}

Map<String, dynamic> $KnockRecordEntityToJson(KnockRecordEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['unreadCount'] = entity.unreadCount;
  data['items'] = entity.items?.map((v) => v.toJson()).toList();
  return data;
}

extension KnockRecordEntityExtension on KnockRecordEntity {
  KnockRecordEntity copyWith({
    int? unreadCount,
    List<KnockRecordItems>? items,
  }) {
    return KnockRecordEntity()
      ..unreadCount = unreadCount ?? this.unreadCount
      ..items = items ?? this.items;
  }
}

KnockRecordItems $KnockRecordItemsFromJson(Map<String, dynamic> json) {
  final KnockRecordItems knockRecordItems = KnockRecordItems();
  final int? knockId = jsonConvert.convert<int>(json['knockId']);
  if (knockId != null) {
    knockRecordItems.knockId = knockId;
  }
  final String? direction = jsonConvert.convert<String>(json['direction']);
  if (direction != null) {
    knockRecordItems.direction = direction;
  }
  final int? targetUserId = jsonConvert.convert<int>(json['targetUserId']);
  if (targetUserId != null) {
    knockRecordItems.targetUserId = targetUserId;
  }
  final String? targetNickname = jsonConvert.convert<String>(
      json['targetNickname']);
  if (targetNickname != null) {
    knockRecordItems.targetNickname = targetNickname;
  }
  final String? targetAvatar = jsonConvert.convert<String>(
      json['targetAvatar']);
  if (targetAvatar != null) {
    knockRecordItems.targetAvatar = targetAvatar;
  }
  final String? interactionDesc = jsonConvert.convert<String>(
      json['interactionDesc']);
  if (interactionDesc != null) {
    knockRecordItems.interactionDesc = interactionDesc;
  }
  final String? tagName = jsonConvert.convert<String>(json['tagName']);
  if (tagName != null) {
    knockRecordItems.tagName = tagName;
  }
  final String? timeAgo = jsonConvert.convert<String>(json['timeAgo']);
  if (timeAgo != null) {
    knockRecordItems.timeAgo = timeAgo;
  }
  final bool? isRead = jsonConvert.convert<bool>(json['isRead']);
  if (isRead != null) {
    knockRecordItems.isRead = isRead;
  }
  final String? createdAt = jsonConvert.convert<String>(json['createdAt']);
  if (createdAt != null) {
    knockRecordItems.createdAt = createdAt;
  }
  return knockRecordItems;
}

Map<String, dynamic> $KnockRecordItemsToJson(KnockRecordItems entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['knockId'] = entity.knockId;
  data['direction'] = entity.direction;
  data['targetUserId'] = entity.targetUserId;
  data['targetNickname'] = entity.targetNickname;
  data['targetAvatar'] = entity.targetAvatar;
  data['interactionDesc'] = entity.interactionDesc;
  data['tagName'] = entity.tagName;
  data['timeAgo'] = entity.timeAgo;
  data['isRead'] = entity.isRead;
  data['createdAt'] = entity.createdAt;
  return data;
}

extension KnockRecordItemsExtension on KnockRecordItems {
  KnockRecordItems copyWith({
    int? knockId,
    String? direction,
    int? targetUserId,
    String? targetNickname,
    String? targetAvatar,
    String? interactionDesc,
    String? tagName,
    String? timeAgo,
    bool? isRead,
    String? createdAt,
  }) {
    return KnockRecordItems()
      ..knockId = knockId ?? this.knockId
      ..direction = direction ?? this.direction
      ..targetUserId = targetUserId ?? this.targetUserId
      ..targetNickname = targetNickname ?? this.targetNickname
      ..targetAvatar = targetAvatar ?? this.targetAvatar
      ..interactionDesc = interactionDesc ?? this.interactionDesc
      ..tagName = tagName ?? this.tagName
      ..timeAgo = timeAgo ?? this.timeAgo
      ..isRead = isRead ?? this.isRead
      ..createdAt = createdAt ?? this.createdAt;
  }
}