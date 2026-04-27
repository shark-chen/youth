import 'package:kellychat/base/base_controller.dart';

import 'controller/invite_record_request_controller.dart';
export 'controller/invite_record_request_controller.dart';
import 'view_model/invite_record_vm.dart';

/// FileName: invite_record_controller
///
/// @Author 谌文
/// @Date 2026/3/12 23:09
///
/// @Description 邀约记录-controller
class InviteRecordController extends BaseController {
  /// vm
  Rx<InviteRecordVM> vm = InviteRecordVM().obs;

  @override
  void onInit() async {
    super.onInit();
    title = '邀约';
    requestTogetherMyList();
  }

  /// push - 跳转到用户信息页面-page
  Future pushUserInfoPage() async {
    await Get.toNamed(Routes.userInfoPage);
  }
}
