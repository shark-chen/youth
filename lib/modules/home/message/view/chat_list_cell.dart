import 'package:youth/base/base_stateless_widget.dart';

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
        margin: EdgeInsets.only(left: 12, right: 12),
        padding: EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
        decoration: BoxDecoration(
          border: Border.all(color: ThemeColor.blueColor, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 头像
            ImageLookWidget(
              height: 40,
              width: 40,
              imgUrl: headPortraitUrl ?? '',
              imgBorderRadius: BorderRadius.circular(33),
            ),
            SizedBox(width: 8),

            /// 名称 + 时间 + 消息
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 名称 + 时间
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name ?? '',
                      style:
                          TextStyles(color: ThemeColor.whiteColor, fontSize: 18),
                    ),
                    Text(
                      time ?? '',
                      style: TextStyles(color: ThemeColor.whiteColor),
                    ),
                  ],
                ),

                /// 消息
                Text(
                  msg ?? '',
                  style: TextStyles(color: ThemeColor.whiteColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
