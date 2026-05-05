import 'package:kellychat/tripartite_library/chat_ui/chat_image_view.dart';
import 'package:kellychat/tripartite_library/chat_ui/chat_normal_view.dart';
import 'package:kellychat/widget/image_look/image_look.dart';
import '../model/chat_history_entity.dart';
import 'chat_vm.dart';
import 'package:flutter/material.dart';

/// FileName: chat_ui_vm
///
/// @Author 谌文
/// @Date 2026/5/4 23:24
///
/// @Description 聊天-处理消息-vm
extension ChatUIVM on ChatVM {
  /// 构建聊天信息- UI
  Widget buildChatMsgUI(ChatHistoryList item) {
    switch (item.chatMsgType) {
      /// 文本消息
      case ChatMsgType.text:
        {
          return ChatBaseWidget(
            text: item.content ?? '',
            isSender: item.isSender,
            avatar: item.avatar,
            tail: true,
          );
        }

      /// 图片
      case ChatMsgType.photo:
        {
          return ChatImageWidget(
            id: '${item.avatar}_${item.index}',
            image: ImageLookWidget(
              imgUrl: item.content ?? '',
              width: 150,
              height: 170,
              enlargeLook: false,
              imgBorderRadius: BorderRadius.circular(32),
            ),
          );
        }
      default:
        {
          return SizedBox();
        }
    }
  }
}
