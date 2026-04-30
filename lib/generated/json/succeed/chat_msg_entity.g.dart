import 'package:kellychat/generated/json/convert/json_convert_content.dart';
import 'package:kellychat/modules/home/chat/model/chat_msg_entity.dart';

ChatMsgEntity $ChatMsgEntityFromJson(Map<String, dynamic> json) {
  final ChatMsgEntity chatMsgEntity = ChatMsgEntity();
  final bool? hasMore = jsonConvert.convert<bool>(json['hasMore']);
  if (hasMore != null) {
    chatMsgEntity.hasMore = hasMore;
  }
  final List<ChatMsgList>? list = (json['list'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<ChatMsgList>(e) as ChatMsgList).toList();
  if (list != null) {
    chatMsgEntity.list = list;
  }
  return chatMsgEntity;
}

Map<String, dynamic> $ChatMsgEntityToJson(ChatMsgEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['hasMore'] = entity.hasMore;
  data['list'] = entity.list?.map((v) => v.toJson()).toList();
  return data;
}

extension ChatMsgEntityExtension on ChatMsgEntity {
  ChatMsgEntity copyWith({
    bool? hasMore,
    List<ChatMsgList>? list,
  }) {
    return ChatMsgEntity()
      ..hasMore = hasMore ?? this.hasMore
      ..list = list ?? this.list;
  }
}

ChatMsgList $ChatMsgListFromJson(Map<String, dynamic> json) {
  final ChatMsgList chatMsgList = ChatMsgList();
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    chatMsgList.type = type;
  }
  final int? messageId = jsonConvert.convert<int>(json['messageId']);
  if (messageId != null) {
    chatMsgList.messageId = messageId;
  }
  final int? fromUserId = jsonConvert.convert<int>(json['fromUserId']);
  if (fromUserId != null) {
    chatMsgList.fromUserId = fromUserId;
  }
  final String? fromNickname = jsonConvert.convert<String>(
      json['fromNickname']);
  if (fromNickname != null) {
    chatMsgList.fromNickname = fromNickname;
  }
  final String? fromAvatar = jsonConvert.convert<String>(json['fromAvatar']);
  if (fromAvatar != null) {
    chatMsgList.fromAvatar = fromAvatar;
  }
  final int? toUserId = jsonConvert.convert<int>(json['toUserId']);
  if (toUserId != null) {
    chatMsgList.toUserId = toUserId;
  }
  final int? contentType = jsonConvert.convert<int>(json['contentType']);
  if (contentType != null) {
    chatMsgList.contentType = contentType;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    chatMsgList.content = content;
  }
  final bool? isRead = jsonConvert.convert<bool>(json['isRead']);
  if (isRead != null) {
    chatMsgList.isRead = isRead;
  }
  final String? createdAt = jsonConvert.convert<String>(json['createdAt']);
  if (createdAt != null) {
    chatMsgList.createdAt = createdAt;
  }
  return chatMsgList;
}

Map<String, dynamic> $ChatMsgListToJson(ChatMsgList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['type'] = entity.type;
  data['messageId'] = entity.messageId;
  data['fromUserId'] = entity.fromUserId;
  data['fromNickname'] = entity.fromNickname;
  data['fromAvatar'] = entity.fromAvatar;
  data['toUserId'] = entity.toUserId;
  data['contentType'] = entity.contentType;
  data['content'] = entity.content;
  data['isRead'] = entity.isRead;
  data['createdAt'] = entity.createdAt;
  return data;
}

extension ChatMsgListExtension on ChatMsgList {
  ChatMsgList copyWith({
    int? type,
    int? messageId,
    int? fromUserId,
    String? fromNickname,
    String? fromAvatar,
    int? toUserId,
    int? contentType,
    String? content,
    bool? isRead,
    String? createdAt,
  }) {
    return ChatMsgList()
      ..type = type ?? this.type
      ..messageId = messageId ?? this.messageId
      ..fromUserId = fromUserId ?? this.fromUserId
      ..fromNickname = fromNickname ?? this.fromNickname
      ..fromAvatar = fromAvatar ?? this.fromAvatar
      ..toUserId = toUserId ?? this.toUserId
      ..contentType = contentType ?? this.contentType
      ..content = content ?? this.content
      ..isRead = isRead ?? this.isRead
      ..createdAt = createdAt ?? this.createdAt;
  }
}