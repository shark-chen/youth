import 'package:youth/base/base_controller.dart';

import 'view_model/user_info_vm.dart';

/// FileName: user_info_controller
///
/// @Author 谌文
/// @Date 2026/3/16 22:51
///
/// @Description 用户信息模块-controller
class UserInfoController extends BaseController {
  /// vm
  Rx<UserInfoVM> vm = UserInfoVM().obs;

  @override
  void onInit() async {
    super.onInit();
    title = '用户信息';
  }
}
