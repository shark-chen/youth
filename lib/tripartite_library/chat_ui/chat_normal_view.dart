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
    this.showPortrait = true,
    super.constraints,
    super.bubbleRadius,
    super.isSender,
    super.color = ThemeColor.inputBgColor,
    super.tail,
    super.sent,
    super.delivered,
    super.seen,
    super.textStyle = const TextStyle(
      fontSize: 14,
      color: Colors.white,
    ),
  }) : super(key: key);

  /// 是否展示头像
  final bool? showPortrait;

  @override
  Widget build(BuildContext context) {
    final bubble = super.build(context);
    final headerImage = showPortrait == true
        ? ImageLookWidget(
            imgUrl: 'imgUrl',
            height: 40,
            width: 40,
            imgBorderRadius: BorderRadius.circular(20),
          )
        : SizedBox(width: 40, height: 40);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          isSender == true ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: isSender == true
          ? [
              Expanded(child: bubble),
              headerImage,
            ]
          : [headerImage, Expanded(child: bubble)],
    );
  }
}
