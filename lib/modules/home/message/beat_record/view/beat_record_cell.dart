import 'package:kellychat/base/base_stateless_widget.dart';
import 'package:kellychat/tripartite_library/tripartite_library.dart';

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
    this.tagName,
    this.userInfoTap,
    this.chatTap,
  }) : super(key: key);

  /// 头像
  final String? headPortraitUrl;

  /// 用户名
  final String? name;

  /// 时间
  final String? time;

  /// 任务
  final String? tagName;

  /// 点击用户信息
  final VoidCallback? userInfoTap;

  /// 聊天点击
  final VoidCallback? chatTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: userInfoTap,
      child: Container(
        padding: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
        color: ThemeColor.inputBgColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageLookWidget(
              imgUrl: headPortraitUrl ?? '',
              width: 42,
              height: 42,
              imgBorderRadius: BorderRadius.circular(24),
            ),
            SizedBox(width: 6),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 名称+时间
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: (name ?? '') + ' ',
                        style: TextStyles(
                          color: ThemeColor.whiteColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: time,
                        style: TextStyles(
                          fontSize: 12,
                          color: ThemeColor.whiteColor.withOpacity(0.6),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),

                /// 我敲啦下
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '我敲了下她',
                        style: TextStyles(
                          fontSize: 12,
                          color: ThemeColor.whiteColor.withOpacity(0.6),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: ' [${tagName ?? ''}] 状态',
                        style: TextStyles(
                          fontSize: 12,
                          color: ThemeColor.themeGreenColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(child: Container()),
            GestureDetector(
              onTap: chatTap,
              child: Image.asset(
                'assets/image/common/message@3x.png',
                fit: BoxFit.fill,
                width: 24,
                height: 24,
                color: ThemeColor.themeGreenColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
