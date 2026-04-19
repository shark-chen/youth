import 'package:youth/generated/json/convert/json_convert_content.dart';
import 'package:youth/modules/home/message/model/message_person_list_entity.dart';

MessagePersonListEntity $MessagePersonListEntityFromJson(
    Map<String, dynamic> json) {
  final MessagePersonListEntity messagePersonListEntity = MessagePersonListEntity();
  final int? conversationId = jsonConvert.convert<int>(json['conversationId']);
  if (conversationId != null) {
    messagePersonListEntity.conversationId = conversationId;
  }
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    messagePersonListEntity.userId = userId;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    messagePersonListEntity.nickname = nickname;
  }
  final String? avatar = jsonConvert.convert<String>(json['avatar']);
  if (avatar != null) {
    messagePersonListEntity.avatar = avatar;
  }
  final String? lastMessage = jsonConvert.convert<String>(json['lastMessage']);
  if (lastMessage != null) {
    messagePersonListEntity.lastMessage = lastMessage;
  }
  final String? lastMessageTime = jsonConvert.convert<String>(
      json['lastMessageTime']);
  if (lastMessageTime != null) {
    messagePersonListEntity.lastMessageTime = lastMessageTime;
  }
  final int? unreadCount = jsonConvert.convert<int>(json['unreadCount']);
  if (unreadCount != null) {
    messagePersonListEntity.unreadCount = unreadCount;
  }
  final String? lastMessageTimeRaw = jsonConvert.convert<String>(
      json['lastMessageTimeRaw']);
  if (lastMessageTimeRaw != null) {
    messagePersonListEntity.lastMessageTimeRaw = lastMessageTimeRaw;
  }
  return messagePersonListEntity;
}

Map<String, dynamic> $MessagePersonListEntityToJson(
    MessagePersonListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['conversationId'] = entity.conversationId;
  data['userId'] = entity.userId;
  data['nickname'] = entity.nickname;
  data['avatar'] = entity.avatar;
  data['lastMessage'] = entity.lastMessage;
  data['lastMessageTime'] = entity.lastMessageTime;
  data['unreadCount'] = entity.unreadCount;
  data['lastMessageTimeRaw'] = entity.lastMessageTimeRaw;
  return data;
}

extension MessagePersonListEntityExtension on MessagePersonListEntity {
  MessagePersonListEntity copyWith({
    int? conversationId,
    int? userId,
    String? nickname,
    String? avatar,
    String? lastMessage,
    String? lastMessageTime,
    int? unreadCount,
    String? lastMessageTimeRaw,
  }) {
    return MessagePersonListEntity()
      ..conversationId = conversationId ?? this.conversationId
      ..userId = userId ?? this.userId
      ..nickname = nickname ?? this.nickname
      ..avatar = avatar ?? this.avatar
      ..lastMessage = lastMessage ?? this.lastMessage
      ..lastMessageTime = lastMessageTime ?? this.lastMessageTime
      ..unreadCount = unreadCount ?? this.unreadCount
      ..lastMessageTimeRaw = lastMessageTimeRaw ?? this.lastMessageTimeRaw;
  }
}