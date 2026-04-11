import 'package:youth/base/base_vm.dart';
import '../model/user_info_entity.dart';

/// FileName: user_info_vm
///
/// @Author 谌文
/// @Date 2026/3/16 23:04
///
/// @Description 用户信息模块-vm
class UserInfoVM extends BaseVM {
  /// 人信息数据
  UserInfoEntity? userInfo;

  /// 用户ID，无ID表示本人，有则是其他人
  int? userId;

  @override
  void onInit() {
    super.onInit();
  }

  /// 配置个人信息数据
  void configUserInfo(UserInfoEntity? value) {
    userInfo = value;
  }
}
