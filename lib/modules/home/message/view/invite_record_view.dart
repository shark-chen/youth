import 'package:kellychat/base/base_stateless_widget.dart';

/// FileName: invite_record_view
///
/// @Author 谌文
/// @Date 2026/3/11 00:00
///
/// @Description 邀约中的任务view
class InviteRecordWidget extends BaseStatelessWidget {
  const InviteRecordWidget({
    super.key,
    this.headPortraits,
    this.time,
    this.unreadCount,
    this.tap,
  });

  /// 头像数组
  final List<String>? headPortraits;

  /// 时间
  final String? time;

  /// 未读数量
  final String? unreadCount;

  /// 点击
  final VoidCallback? tap;

  @override
  Widget build(BuildContext context) {
    final hasAvatars = Lists.isNotEmpty(headPortraits);
    return GestureDetector(
      onTap: tap,
      child: Container(
        margin: const EdgeInsets.only(left: 4, right: 12, top: 12),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 11),
              padding: const EdgeInsets.fromLTRB(12, 36, 12, 12),
              decoration: BoxDecoration(
                color: ThemeColor.inputBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      time ?? '',
                      style: TextStyles(
                        color: ThemeColor.white6Color,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      hasAvatars
                          ? SizedBox(
                              width: 200,
                              height: 24,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: headPortraits?.length ?? 0,
                                itemBuilder: (context, index) {
                                  final url = headPortraits?[index] ?? '';
                                  return ImageLookWidget(
                                    imgUrl: url,
                                    height: 24,
                                    width: 24,
                                    heroTag:
                                        '${url}_invite_record_avatar_$index',
                                  );
                                },
                              ),
                            )
                          : Text(
                              '暂无消息',
                              style: TextStyles(color: ThemeColor.white6Color),
                            ),
                      Visibility(
                        visible: hasAvatars,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: ThemeColor.themeGreenColor
                                    .withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${unreadCount ?? ''}',
                                style: TextStyles(
                                  color: ThemeColor.themeGreenColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Transform.rotate(
                              angle: 3.14159,
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 16,
                                color: ThemeColor.whiteColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// 一起做邀约
            Positioned(
              left: 0,
              top: 0,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/image/common/message_knock@3x.png',
                        width: 52,
                        height: 52,
                      ),
                      Text(
                        '一起做邀约',
                        style: TextStyles(
                          fontWeight: FontWeight.w600,
                          color: ThemeColor.whiteColor,
                        ),
                      ),
                    ],
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
