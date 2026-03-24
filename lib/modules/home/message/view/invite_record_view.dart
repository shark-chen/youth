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
        decoration: BoxDecoration(
          border: Border.all(color: ThemeColor.blueColor, width: 1),
          borderRadius: BorderRadius.circular(6),
        ),
        margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
        padding: EdgeInsets.only(left: 6, right: 6, bottom: 6, top: 3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '一起做， 邀约',
                  style: TextStyles(
                    color: ThemeColor.blueColor,
                  ),
                ),

                /// 列表
                SizedBox(
                  width: 200,
                  height: 30,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: headPortraits?.length ?? 10,
                    itemBuilder: (BuildContext context, int index) {
                      return ImageLookWidget(
                        imgUrl: '',
                        height: 30,
                        width: 30,
                      );
                    },
                  ),
                ),

                /// 数量
                Container(
                  child: Text(
                    '${headPortraits?.length ?? 0}',
                    style: TextStyles(
                      color: ThemeColor.whiteColor,
                    ),
                  ),
                ),

                Icon(Icons.more),
              ],
            ),

            /// 时间
            Text(
              time ?? '',
              style: TextStyles(color: ThemeColor.whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}
