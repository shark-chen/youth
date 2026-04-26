import 'dart:ffi';

import 'package:youth/base/base_page.dart';
import 'package:youth/utils/extension/lists/lists.dart';

import 'invite_record_controller.dart';
import 'view/invite_record_cell.dart';

/// FileName: invite_record_page
///
/// @Author 谌文
/// @Date 2026/3/12 23:09
///
/// @Description 邀约记录-页面-page
class InviteRecordPage extends BasePage<InviteRecordController> {
  const InviteRecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeColor.themeColor,
      appBar: AppBarKit.appBar(controller.title ?? '', elevation: 0.2),
      body: Obx(
        () => SafeArea(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(45),
            child: Lists.isNotEmpty(controller.vm.value.rows)
                ? ListView.builder(
                    padding: EdgeInsets.only(
                        left: 12, right: 12, top: 12, bottom: 12),
                    itemCount: controller.vm.value.rows.length,
                    itemBuilder: (BuildContext context, int index) {
                      final row = controller.vm.value.rows[index];
                      return InviteRecordCell(
                        userInfoTap: controller.pushUserInfoPage,
                        headPortraitUrl: row.initiatorAvatar,
                        name: row.initiatorNickname,
                        inviteMatter: row.completedAt,
                        inviteStatusStr: row.statusText,
                        time: row.completedAt,
                      );
                    },
                  )
                : Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 120),
                      child: Text(
                        '暂无消息',
                        style: TextStyles(color: ThemeColor.whiteColor),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
