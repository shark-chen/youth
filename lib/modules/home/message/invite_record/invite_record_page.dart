import 'package:youth/base/base_page.dart';

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
      body: ListView.builder(
        padding: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
        itemCount: 30,
        itemBuilder: (BuildContext context, int index) {
          return InviteRecordCell(
            userInfoTap: controller.pushUserInfoPage,
            name: '小米',
            inviteMatter: '真的想你哦',
            inviteStatusStr: '就是想拒绝你',
            time: '12点',
          );
        },
      ),
    );
  }
}
