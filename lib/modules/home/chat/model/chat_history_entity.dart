import 'package:kellychat/generated/json/succeed/chat_history_entity.g.dart';
import 'package:kellychat/modules/user/user_center/user_center.dart';
import 'dart:convert';
import 'package:kellychat/utils/extension/maps/maps.dart';

import 'chat_im_entity.dart';
import 'chat_message_entity.dart';
export 'package:kellychat/generated/json/succeed/chat_history_entity.g.dart';

class ChatHistoryEntity {
  bool? hasMore;
  List<ChatHistoryList>? list;

  ChatHistoryEntity();

  factory ChatHistoryEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $ChatHistoryEntityFromJson(json);
    }
    return ChatHistoryEntity();
  }

  Map<String, dynamic> toJson() => $ChatHistoryEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

class ChatHistoryList {
  int? messageId;
  String? fromUserId;
  String? fromAvatar;
  String? toUserId;

  /// 消息类型：1-文本，2-图片
  int? contentType;
  String? content;
  bool? isRead;
  String? createdAt;
  String? avatar;

  /// 自定义字段
  /// 是否是发送者，
  bool isSender = false;

  /// 消息类型
  ChatMsgType chatMsgType = ChatMsgType.text;

  /// 位置索引
  String? index;

  ChatHistoryList();

  factory ChatHistoryList.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $ChatHistoryListFromJson(json);
    }
    return ChatHistoryList();
  }

  /// IM- 即时通讯- 转成页面数据
  factory ChatHistoryList.fromChatMessage(ChatImEntity item) {
    final result = ChatHistoryList();
    result.messageId = item.messageId;
    result.fromUserId = item.fromUserId;
    result.toUserId = (UserCenter().user?.id ?? 0).toString();
    result.contentType = item.contentType;
    result.content = item.content;
    result.isRead = true;
    result.createdAt = item.createdAt;
    result.avatar = item.fromAvatar;
    result.isSender = false;
    return result;
  }

  Map<String, dynamic> toJson() => $ChatHistoryListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

/// 聊天信息模式
enum ChatMsgType {
  /// 文本模式
  text,

  /// 图片模式
  photo,
}
