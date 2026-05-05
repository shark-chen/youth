import 'dart:ffi';

import 'package:kellychat/modules/user/user_center/user_center.dart';
import '../model/chat_history_entity.dart';
import 'chat_vm.dart';

/// FileName: chat_msg_vm
///
/// @Author 谌文
/// @Date 2026/5/4 23:17
///
/// @Description 聊天-处理消息-vm
extension ChatMsgVM on ChatVM {
  /// 处理消息
  List<ChatHistoryList> handleChatMsg(List<ChatHistoryList> values) {
    final myId = (UserCenter().user?.id ?? 0).toString();
    for (var value in values) {
      final from = value.fromUserId ?? 0;
      value.isSender = from == myId && myId != 0;
      if(value.isSender) {
        value.avatar = UserCenter().user?.avatar;
      } else {
        value.avatar = value.fromAvatar ?? chatParam.avatar;
      }

      /// 消息类型：1-文本，2-图片
      switch (value.contentType) {
        case 1:
          {
            value.chatMsgType = ChatMsgType.text;
          }
          break;
        case 2:
          {
            value.chatMsgType = ChatMsgType.photo;
          }
          break;
      }
    }
    return values;
  }

  /// IM - 发送消息，构建UI模型
  ChatHistoryList buildIMSendMsgUIModel({
    required int contentType,
    required String content,
  }) {
    final result = ChatHistoryList();
    result.fromUserId = (UserCenter().user?.id ?? 0).toString();
    result.toUserId = chatParam.userId;
    result.contentType = contentType;
    result.content = content;
    // result.createdAt = item.createdAt;
    // result.avatar = item.fromAvatar;
    result.isSender = true;
    return result;
  }
}
