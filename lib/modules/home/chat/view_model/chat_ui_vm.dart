import 'package:kellychat/base/base_bindings.dart';
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
            bubbleRadius: 12,
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
            bubbleRadius: 12,
            id: '${item.content}_${item.index}',
            image: ImageLookWidget(
              imgUrl: item.content ?? '',
              fit: BoxFit.fill,
              autoSize: true,
              enlargeLook: false,
              imgBorderRadius: BorderRadius.circular(12),
            ),
          );
        }
      default:
        {
          return SizedBox();
        }
    }
  }

  /// mark - 消息滚动
  ///
  /// 加载完历史消息后，滚动到底部
  void scheduleJumpToBottomAfterHistory() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      jumpListToBottom();
    });
  }

  /// 无动画滚动到底部
  void jumpListToBottom() {
    if (!listScrollController.hasClients) return;
    listScrollController.jumpTo(listScrollController.position.maxScrollExtent);
  }

  /// 有动画滚动到底部
  void animateToListToBottom() {
    if (!listScrollController.hasClients) return;
    listScrollController.animateTo(
      listScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }
}
