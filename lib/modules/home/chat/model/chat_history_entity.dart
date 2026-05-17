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

  /// 时间标记
  String? timeTag;

  /// 客户端消息 ID（乐观发送 / IM 回执匹配，非历史接口字段）
  String? clientMsgId;

  /// 发送状态（仅己方发送消息）
  ChatMsgSendStatus sendStatus = ChatMsgSendStatus.none;

  /// 发送失败原因（展示 / Toast）
  String? sendFailReason;

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
    result.clientMsgId = item.clientMsgId;
    result.sendStatus = sendStatusFromIm(item.status);
    return result;
  }

  static ChatMsgSendStatus sendStatusFromIm(String? status) {
    switch (status?.toLowerCase()) {
      case 'sent':
        return ChatMsgSendStatus.sent;
      case 'failed':
        return ChatMsgSendStatus.failed;
      case 'sending':
        return ChatMsgSendStatus.sending;
      case 'received':
        return ChatMsgSendStatus.none;
      default:
        return ChatMsgSendStatus.none;
    }
  }

  Map<String, dynamic> toJson() => $ChatHistoryListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

/// 己方消息发送状态
enum ChatMsgSendStatus {
  none,
  sending,
  sent,
  failed,
}

/// 聊天信息模式
enum ChatMsgType {
  /// 文本模式
  text,

  /// 图片模式
  photo,
}
