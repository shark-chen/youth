import 'package:kellychat/tripartite_library/chat_ui/chat_image_view.dart';
import 'package:kellychat/tripartite_library/chat_ui/chat_normal_view.dart';
import 'package:kellychat/utils/utils/theme_color.dart';
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
  Widget buildChatMsgUI(
    ChatHistoryList item, {
    VoidCallback? onAvatarTap,
    VoidCallback? onRetry,
  }) {
    Widget bubble;
    switch (item.chatMsgType) {
      /// 文本消息
      case ChatMsgType.text:
        {
          bubble = ChatBaseWidget(
            bubbleRadius: 12,
            text: item.content ?? '',
            isSender: item.isSender,
            avatar: item.avatar,
            onAvatarTap: onAvatarTap,
            tail: true,
          );
        }
        break;

      /// 图片
      case ChatMsgType.photo:
        {
          bubble = ChatImageWidget(
            bubbleRadius: 12,
            id: '${item.content}_${item.index}',
            isSender: item.isSender,
            avatar: item.avatar,
            onAvatarTap: onAvatarTap,
            image: ImageLookWidget(
              imgUrl: item.content ?? '',
              fit: BoxFit.fill,
              autoSize: true,
              enlargeLook: false,
              imgBorderRadius: BorderRadius.circular(12),
              heroTag: '${item.content ?? ''}_${item.index}_chat_bubble',
            ),
          );
        }
        break;
      default:
        {
          return const SizedBox();
        }
    }
    if (item.isSender) {
      bubble = _wrapSenderStatus(item, bubble, onRetry);
    }
    return _chatBubbleWithOptionalTimeTag(item, bubble);
  }

  Widget _wrapSenderStatus(
    ChatHistoryList item,
    Widget bubble,
    VoidCallback? onRetry,
  ) {
    switch (item.sendStatus) {
      case ChatMsgSendStatus.sending:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 6, bottom: 12),
              child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
            Flexible(child: bubble),
          ],
        );
      case ChatMsgSendStatus.failed:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: onRetry,
              behavior: HitTestBehavior.opaque,
              child: const Padding(
                padding: EdgeInsets.only(right: 6, bottom: 12),
                child: Icon(
                  Icons.error_outline,
                  color: Colors.redAccent,
                  size: 22,
                ),
              ),
            ),
            Flexible(child: bubble),
          ],
        );
      default:
        return bubble;
    }
  }

  Widget _chatBubbleWithOptionalTimeTag(ChatHistoryList item, Widget bubble) {
    final tag = item.timeTag;
    if (tag == null || tag.isEmpty) return bubble;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              tag,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                color: ThemeColor.secondaryTextColor,
              ),
            ),
          ),
        ),
        bubble,
      ],
    );
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
