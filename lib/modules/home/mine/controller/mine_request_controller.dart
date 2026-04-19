import 'package:youth/network/net/entry/user/user.dart';
import '../mine_controller.dart';
import '../user_info/model/user_info_entity.dart';
import 'package:youth/base/base_controller.dart';

/// FileName: mine_request_controller
///
/// @Author 谌文
/// @Date 2026/4/18 10:32
///
/// @Description 我的-tab 控制器
extension MineRequestController on MineController {
  /// 退出登录 · POST /api/auth/logout
  Future<bool> requestAuthLogout() async {
    EasyLoading.show();
    final response = await Net.value<User>().requestAuthLogout<dynamic>();
    EasyLoading.dismiss();
    if (response.success) {
      return true;
    }
    EasyLoading.showToast(response.msg ?? '');
    return false;
  }

  /// mark - request
  ///
  /// 拉取个人资料（头像、昵称等）
  Future<void> refreshProfile() async {
    final response = await Net.value<User>().cache<UserInfoEntity>((value) {
      /// 当前登录用户资料（与资料页同源模型）
      vm.value.configUserProfile(value);
      vm.refresh();
    }).requestUserInfo<UserInfoEntity>();
    if (response.succeed) {
      /// 当前登录用户资料（与资料页同源模型）
      vm.value.configUserProfile(response.value);
      vm.refresh();
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }
}
