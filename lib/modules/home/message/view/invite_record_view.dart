import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:youth/base/base_controller.dart';
import 'package:youth/base/base_page.dart';
import 'package:youth/base/base_stateless_widget.dart';
import 'package:youth/modules/modules.dart';
import 'package:youth/widget/bottom_dialog/bottom_dialog.dart';

/// FileName: invite_record_view
///
/// @Author 谌文
/// @Date 2026/3/11 00:00
///
/// @Description 邀约中的任务view
class InviteRecordWidget extends BaseStatelessWidget {
  const InviteRecordWidget({
    Key? key,
    this.headPortraits,
    this.time,
    this.tap,
  }) : super(key: key);

  /// 头像数组
  final List<String>? headPortraits;

  /// 时间
  final String? time;

  /// 点击
  final VoidCallback? tap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        margin: EdgeInsets.only(left: 4, right: 12, top: 17),
        // padding: EdgeInsets.only(bottom: 12),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 4, left: 8),
              padding:
                  EdgeInsets.only(top: 12, bottom: 12, right: 12, left: 12),
              decoration: BoxDecoration(
                color: ThemeColor.inputBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  /// 时间
                  Text(
                    time ?? '',
                    style: TextStyles(color: ThemeColor.whiteColor),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// 列表
                      SizedBox(
                        width: 200,
                        height: 24,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: headPortraits?.length ?? 10,
                          itemBuilder: (BuildContext context, int index) {
                            return ImageLookWidget(
                              imgUrl: 'dsad',
                              height: 24,
                              width: 24,
                            );
                          },
                        ),
                      ),

                      Row(
                        children: [
                          /// 数量
                          Container(
                            padding: EdgeInsets.only(
                              left: 8,
                              right: 8,
                              top: 2,
                              bottom: 2,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  ThemeColor.themeGreenColor.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${headPortraits?.length ?? 0}',
                              style: TextStyles(
                                  color: ThemeColor.themeGreenColor,
                                  fontSize: 12),
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.arrow_back_ios,
                            size: 16,
                            color: ThemeColor.whiteColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// 一起做邀约
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 30,
                    top: 2,
                    bottom: 2,
                    right: 12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
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
                Transform.rotate(
                  angle: -20 * pi / 180, // ⭐ 向左旋转30度（负数）
                  child: Image.asset(
                    'assets/image/common/look_someone@3x.png',
                    width: 34,
                    height: 32,
                    color: ThemeColor.themeGreenColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
