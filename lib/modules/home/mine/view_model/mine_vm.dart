import 'package:youth/base/base_vm.dart';

import '../user_info/model/user_info_entity.dart';

/// FileName: mine_vm
///
/// @Author 谌文
/// @Date 2026/4/12 20:49
///
/// @Description 个人中心-vm
class MineVM extends BaseVM {
  /// 当前登录用户资料（与资料页同源模型）
  UserInfoEntity? userProfile;

  @override
  void onInit() {
    super.onInit();
  }

  /// 当前登录用户资料（与资料页同源模型）
  void configUserProfile(UserInfoEntity? value) {
    userProfile = value;
  }
}
