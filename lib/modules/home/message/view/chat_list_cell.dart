import 'package:kellychat/base/base_stateless_widget.dart';

/// FileName: chat_list_cell
///
/// @Author 谌文
/// @Date 2026/3/10 23:19
///
/// @Description 消息列表- cell
class ChatListCell extends BaseStatelessWidget {
  const ChatListCell({
    Key? key,
    this.onTap,
    this.headPortraitUrl,
    this.name,
    this.msg,
    this.time,
  }) : super(key: key);

  /// 点击
  final VoidCallback? onTap;

  /// 头像
  final String? headPortraitUrl;

  /// 名称
  final String? name;

  /// 消息
  final String? msg;

  /// 时间
  final String? time;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 66,
        margin: EdgeInsets.only(left: 12, right: 12),
        padding: EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
        color: ThemeColor.inputBgColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// 头像
            ImageLookWidget(
              height: 42,
              width: 42,
              imgUrl: headPortraitUrl ?? '',
              imgBorderRadius: BorderRadius.circular(21),
            ),
            SizedBox(width: 12),

            /// 名称 + 时间 + 消息
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 名称 + 时间
                Row(
                  children: [
                    Text(
                      name ?? '',
                      style: TextStyles(
                        color: ThemeColor.whiteColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      time ?? '',
                      style: TextStyles(
                        color: ThemeColor.iconBlackColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                /// 消息
                Text(
                  msg ?? '',
                  style: TextStyles(
                    color: ThemeColor.iconBlackColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
