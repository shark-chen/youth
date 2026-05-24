import 'package:kellychat/base/base_stateless_widget.dart';

/// FileName: invite_record_cell
///
/// @Author 谌文
/// @Date 2026/3/12 23:26
///
/// @Description 邀约记录-cell
class InviteRecordCell extends BaseStatelessWidget {
  const InviteRecordCell({
    Key? key,
    this.headPortraitUrl,
    this.heroTag,
    this.name,
    this.inviteMatter,
    this.inviteStatusStr,
    this.time,
    this.userInfoTap,
  }) : super(key: key);

  /// 头像
  final String? headPortraitUrl;

  /// heroTag
  final String? heroTag;

  /// 用户名
  final String? name;

  /// 邀约事件
  final String? inviteMatter;

  /// 邀约状态
  final String? inviteStatusStr;

  /// 时间
  final String? time;

  /// 点击用户信息
  final VoidCallback? userInfoTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: userInfoTap,
      child: Container(
        padding: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
        color: ThemeColor.inputBgColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageLookWidget(
              imgUrl: headPortraitUrl ?? '',
              width: 42,
              height: 42,
              imgBorderRadius: BorderRadius.circular(24),
              heroTag: heroTag,
            ),
            SizedBox(width: 6),
            Expanded(
              flex: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 名称+时间
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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

                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: inviteMatter,
                          style: TextStyles(
                            fontSize: 12,
                            color: ThemeColor.white6Color,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(child: Container()),
            Text(
              inviteStatusStr ?? '',
              style: TextStyles(
                color: ThemeColor.white4Color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
