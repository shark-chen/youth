import 'package:flutter/material.dart';
import 'package:kellychat/utils/utils/theme_color.dart';

/// FileName: chat_input_bar
///
/// @Author 谌文
/// @Date 2026/3/17 23:56
///
/// @Description 聊天底部输入区：胶囊输入框 + 右侧圆形「+」
class ChatInputBar extends StatefulWidget {
  const ChatInputBar({
    super.key,
    required this.onSend,
    this.onAttach,
  });

  /// 键盘发送 / 提交时回调（已 trim，空串不会触发）
  final ValueChanged<String> onSend;

  /// 点击「+」
  final VoidCallback? onAttach;

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  static final Color _fieldFill = ThemeColor.doingListCellBgColor;
  static const Color _pageBg = ThemeColor.themeColor;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submit() {
    final t = _controller.text.trim();
    if (t.isEmpty) return;
    widget.onSend(t);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _pageBg,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                minLines: 1,
                maxLines: 4,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.25,
                ),
                cursorColor: ThemeColor.themeGreenColor,
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: _fieldFill,
                  hintText: '请输入...',
                  hintStyle: const TextStyle(
                    color: ThemeColor.secondaryTextColor,
                    fontSize: 15,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(999),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(999),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(999),
                    borderSide: BorderSide(
                      color: ThemeColor.themeGreenColor.withOpacity(0.45),
                      width: 1,
                    ),
                  ),
                ),
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _submit(),
              ),
            ),
            const SizedBox(width: 10),
            Material(
              color: _fieldFill,
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: widget.onAttach ?? () {},
                customBorder: const CircleBorder(),
                child: const SizedBox(
                  width: 48,
                  height: 48,
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.white70,
                      size: 26,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
