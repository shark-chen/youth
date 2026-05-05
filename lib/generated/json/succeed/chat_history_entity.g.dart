import 'package:kellychat/generated/json/convert/json_convert_content.dart';
import 'package:kellychat/modules/home/chat/model/chat_history_entity.dart';

ChatHistoryEntity $ChatHistoryEntityFromJson(Map<String, dynamic> json) {
  final ChatHistoryEntity chatHistoryEntity = ChatHistoryEntity();
  final bool? hasMore = jsonConvert.convert<bool>(json['hasMore']);
  if (hasMore != null) {
    chatHistoryEntity.hasMore = hasMore;
  }
  final List<ChatHistoryList>? list = (json['list'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<ChatHistoryList>(e) as ChatHistoryList)
      .toList();
  if (list != null) {
    chatHistoryEntity.list = list;
  }
  return chatHistoryEntity;
}

Map<String, dynamic> $ChatHistoryEntityToJson(ChatHistoryEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['hasMore'] = entity.hasMore;
  data['list'] = entity.list?.map((v) => v.toJson()).toList();
  return data;
}

extension ChatHistoryEntityExtension on ChatHistoryEntity {
  ChatHistoryEntity copyWith({
    bool? hasMore,
    List<ChatHistoryList>? list,
  }) {
    return ChatHistoryEntity()
      ..hasMore = hasMore ?? this.hasMore
      ..list = list ?? this.list;
  }
}

ChatHistoryList $ChatHistoryListFromJson(Map<String, dynamic> json) {
  final ChatHistoryList chatHistoryList = ChatHistoryList();
  final int? messageId = jsonConvert.convert<int>(json['messageId']);
  if (messageId != null) {
    chatHistoryList.messageId = messageId;
  }
  final String? fromUserId = jsonConvert.convert<String>(json['fromUserId']);
  if (fromUserId != null) {
    chatHistoryList.fromUserId = fromUserId;
  }
  final String? fromAvatar = jsonConvert.convert<String>(json['fromAvatar']);
  if (fromAvatar != null) {
    chatHistoryList.fromAvatar = fromAvatar;
  }
  final String? toUserId = jsonConvert.convert<String>(json['toUserId']);
  if (toUserId != null) {
    chatHistoryList.toUserId = toUserId;
  }
  final int? contentType = jsonConvert.convert<int>(json['contentType']);
  if (contentType != null) {
    chatHistoryList.contentType = contentType;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    chatHistoryList.content = content;
  }
  final bool? isRead = jsonConvert.convert<bool>(json['isRead']);
  if (isRead != null) {
    chatHistoryList.isRead = isRead;
  }
  final String? createdAt = jsonConvert.convert<String>(json['createdAt']);
  if (createdAt != null) {
    chatHistoryList.createdAt = createdAt;
  }
  return chatHistoryList;
}

Map<String, dynamic> $ChatHistoryListToJson(ChatHistoryList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['messageId'] = entity.messageId;
  data['fromUserId'] = entity.fromUserId;
  data['fromAvatar'] = entity.fromAvatar;
  data['toUserId'] = entity.toUserId;
  data['contentType'] = entity.contentType;
  data['content'] = entity.content;
  data['isRead'] = entity.isRead;
  data['createdAt'] = entity.createdAt;
  return data;
}

extension ChatHistoryListExtension on ChatHistoryList {
  ChatHistoryList copyWith({
    int? messageId,
    String? fromUserId,
    String? fromAvatar,
    String? toUserId,
    int? contentType,
    String? content,
    bool? isRead,
    String? createdAt,
  }) {
    return ChatHistoryList()
      ..messageId = messageId ?? this.messageId
      ..fromUserId = fromUserId ?? this.fromUserId
      ..fromAvatar = fromAvatar ?? this.fromAvatar
      ..toUserId = toUserId ?? this.toUserId
      ..contentType = contentType ?? this.contentType
      ..content = content ?? this.content
      ..isRead = isRead ?? this.isRead
      ..createdAt = createdAt ?? this.createdAt;
  }
}
