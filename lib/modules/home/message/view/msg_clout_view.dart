import 'package:youth/base/base_stateless_widget.dart';

/// FileName: msg_clout_view
///
/// @Author 谌文
/// @Date 2026/3/12 00:00
///
/// @Description 消息-敲一下-view
class MsgCloutWidget extends BaseStatelessWidget {
  const MsgCloutWidget({
    Key? key,
    this.headPortraitUrl,
    this.cloutNum,
    this.name,
    this.time,
    this.onTap,
  }) : super(key: key);

  /// 头像
  final String? headPortraitUrl;

  /// 敲一下数量
  final String? cloutNum;

  /// 名称
  final String? name;

  /// 时间
  final String? time;

  /// 点击
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: ThemeColor.blueColor, width: 1),
          borderRadius: BorderRadius.circular(6),
        ),
        margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
        padding: EdgeInsets.only(left: 6, right: 6, bottom: 6, top: 3),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.cloud),
                Text(
                  '敲一下',
                  style: TextStyles(
                    color: ThemeColor.blueColor,
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  padding: EdgeInsets.only(left: 6, right: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ThemeColor.blueColor.withOpacity(0.1),
                    border: Border.all(color: ThemeColor.whiteColor, width: 1),
                  ),
                  child: Text(
                    cloutNum ?? '',
                    style: TextStyles(
                      color: ThemeColor.whiteColor,
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                ImageLookWidget(
                  imgUrl: 'imgUrl',
                  imgBorderRadius: BorderRadius.circular(30),
                ),
                SizedBox(width: 6),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name ?? '',
                      style: TextStyles(color: ThemeColor.whiteColor),
                    ),
                    Text(
                      time ?? '',
                      style: TextStyles(color: ThemeColor.whiteColor),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                Icon(
                  Icons.arrow_back_ios,
                  color: ThemeColor.whiteColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
