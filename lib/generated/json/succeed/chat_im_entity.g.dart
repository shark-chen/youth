import 'package:kellychat/generated/json/convert/json_convert_content.dart';
import 'package:kellychat/modules/home/chat/model/chat_im_entity.dart';

ChatImEntity $ChatImEntityFromJson(Map<String, dynamic> json) {
  final ChatImEntity chatImEntity = ChatImEntity();
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    chatImEntity.type = type;
  }
  final int? messageId = jsonConvert.convert<int>(json['messageId']);
  if (messageId != null) {
    chatImEntity.messageId = messageId;
  }
  final String? fromUserId = jsonConvert.convert<String>(json['fromUserId']);
  if (fromUserId != null) {
    chatImEntity.fromUserId = fromUserId;
  }
  final String? fromNickname = jsonConvert.convert<String>(
      json['fromNickname']);
  if (fromNickname != null) {
    chatImEntity.fromNickname = fromNickname;
  }
  final String? fromAvatar = jsonConvert.convert<String>(json['fromAvatar']);
  if (fromAvatar != null) {
    chatImEntity.fromAvatar = fromAvatar;
  }
  final int? contentType = jsonConvert.convert<int>(json['contentType']);
  if (contentType != null) {
    chatImEntity.contentType = contentType;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    chatImEntity.content = content;
  }
  final String? createdAt = jsonConvert.convert<String>(json['createdAt']);
  if (createdAt != null) {
    chatImEntity.createdAt = createdAt;
  }
  return chatImEntity;
}

Map<String, dynamic> $ChatImEntityToJson(ChatImEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['type'] = entity.type;
  data['messageId'] = entity.messageId;
  data['fromUserId'] = entity.fromUserId;
  data['fromNickname'] = entity.fromNickname;
  data['fromAvatar'] = entity.fromAvatar;
  data['contentType'] = entity.contentType;
  data['content'] = entity.content;
  data['createdAt'] = entity.createdAt;
  return data;
}

extension ChatImEntityExtension on ChatImEntity {
  ChatImEntity copyWith({
    String? type,
    int? messageId,
    String? fromUserId,
    String? fromNickname,
    String? fromAvatar,
    int? contentType,
    String? content,
    String? createdAt,
  }) {
    return ChatImEntity()
      ..type = type ?? this.type
      ..messageId = messageId ?? this.messageId
      ..fromUserId = fromUserId ?? this.fromUserId
      ..fromNickname = fromNickname ?? this.fromNickname
      ..fromAvatar = fromAvatar ?? this.fromAvatar
      ..contentType = contentType ?? this.contentType
      ..content = content ?? this.content
      ..createdAt = createdAt ?? this.createdAt;
  }
}