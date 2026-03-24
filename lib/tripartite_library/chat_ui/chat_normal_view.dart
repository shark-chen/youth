import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:youth/base/base_stateless_widget.dart';

/// FileName: chat_base
///
/// @Author 谌文
/// @Date 2026/3/21 12:16
///
/// @Description basic chat bubble type 基本的聊天气泡类型
class ChatBaseWidget extends BubbleNormal {
  ChatBaseWidget({
    Key? key,
    required super.text,
    super.constraints,
    super.bubbleRadius,
    super.isSender,
    super.color,
    super.tail,
    super.sent,
    super.delivered,
    super.seen,
    super.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bubble = super.build(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          isSender == true ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: isSender == true
          ? [Expanded(child: bubble), ImageLookWidget(imgUrl: 'imgUrl')]
          : [ImageLookWidget(imgUrl: 'imgUrl'), Expanded(child: bubble)],
    );
  }
}
