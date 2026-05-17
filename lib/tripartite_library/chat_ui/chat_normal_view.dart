import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:kellychat/base/base_stateless_widget.dart';

/// FileName: chat_base_widget
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
    this.avatar,
    this.onAvatarTap,
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

  /// 头像地址
  final String? avatar;

  /// 头像点击（跳转个人详情，无 userId 时不传）
  final VoidCallback? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    final bubble = super.build(context);
    final canTapAvatar = onAvatarTap != null;
    Widget headerImage = true == showPortrait
        ? ImageLookWidget(
            imgUrl: avatar ?? '',
            height: 40,
            width: 40,
            imgBorderRadius: BorderRadius.circular(20),
            heroTag: '${avatar ?? ''}_chat_normal',
            enlargeLook: !canTapAvatar,
          )
        : SizedBox(width: 40, height: 40);
    if (canTapAvatar) {
      headerImage = GestureDetector(
        onTap: onAvatarTap,
        behavior: HitTestBehavior.opaque,
        child: headerImage,
      );
    }
    return Padding(
      padding: EdgeInsets.only(
        left: isSender == true ? 0 : 12,
        right: isSender == true ? 12 : 0,
        top: 6,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isSender == true ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: isSender == true
            ? [
                Expanded(child: bubble),
                headerImage,
              ]
            : [headerImage, Expanded(child: bubble)],
      ),
    );
  }
}
