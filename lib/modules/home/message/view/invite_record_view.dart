import 'package:flutter/material.dart';
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
    this.tap,
  });

  /// 头像数组
  final List<String>? headPortraits;

  /// 时间
  final String? time;

  /// 点击
  final VoidCallback? tap;

  static const String _inviteIconAsset =
      'assets/image/common/message_invite@3x.png';

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
              margin: const EdgeInsets.only(top: 4, left: 8),
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
                                '${headPortraits?.length ?? 0}',
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
            Positioned(
              left: 0,
              top: 0,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 30,
                      top: 2,
                      bottom: 2,
                      right: 12,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFFBA63FF),
                          Color(0xFFD7A7FF),
                        ],
                      ),
                    ),
                    child: Text(
                      '一起做邀约',
                      style: TextStyles(
                        fontWeight: FontWeight.w600,
                        color: ThemeColor.themeColor,
                      ),
                    ),
                  ),
                  Image.asset(
                    _inviteIconAsset,
                    width: 34,
                    height: 32,
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
