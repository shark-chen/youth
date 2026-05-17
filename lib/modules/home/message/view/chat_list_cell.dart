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
    this.showTopRadius = false,
    this.showBottomRadius = false,
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

  /// 是否展示上圆角（12）
  final bool showTopRadius;

  /// 是否展示下圆角（12）
  final bool showBottomRadius;

  BorderRadius _cellBorderRadius() {
    const r = Radius.circular(12);
    return BorderRadius.only(
      topLeft: showTopRadius ? r : Radius.zero,
      topRight: showTopRadius ? r : Radius.zero,
      bottomLeft: showBottomRadius ? r : Radius.zero,
      bottomRight: showBottomRadius ? r : Radius.zero,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 66,
        margin: EdgeInsets.only(left: 12, right: 12),
        padding: EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: ThemeColor.inputBgColor,
          borderRadius: _cellBorderRadius(),
        ),
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
              heroTag: '${headPortraitUrl ?? ''}_chat_list_${name}',
              enlargeLook: false,
            ),
            SizedBox(width: 12),

            /// 名称 + 时间 + 消息
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 名称 + 时间
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles(
                            color: ThemeColor.whiteColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles(
                      color: ThemeColor.iconBlackColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
