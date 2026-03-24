import 'package:youth/base/base_stateless_widget.dart';

/// FileName: beat_record_cell
///
/// @Author 谌文
/// @Date 2026/3/17 23:49
///
/// @Description 敲一下记录-cell
class BeatRecordCell extends BaseStatelessWidget {
  const BeatRecordCell({
    Key? key,
    this.headPortraitUrl,
    this.name,
    this.time,
    this.userInfoTap,
    this.chatTap,
  }) : super(key: key);

  /// 头像
  final String? headPortraitUrl;

  /// 用户名
  final String? name;

  /// 时间
  final String? time;

  /// 点击用户信息
  final VoidCallback? userInfoTap;

  /// 聊天点击
  final VoidCallback? chatTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: userInfoTap,
      child: Container(
        padding: EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: ThemeColor.whiteColor, width: 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageLookWidget(imgUrl: headPortraitUrl ?? ''),
            SizedBox(width: 6),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name ?? '',
                  style: TextStyles(
                    color: ThemeColor.whiteColor,
                  ),
                ),
                Text(
                  '他敲了我',
                  style: TextStyles(
                    color: ThemeColor.whiteColor,
                  ),
                ),
              ],
            ),
            Expanded(child: Container()),
            Text(
              time ?? '',
              style: TextStyles(
                color: ThemeColor.whiteColor,
              ),
            ),
            SizedBox(width: 5),
            Icon(Icons.chat)
          ],
        ),
      ),
    );

  }
}
