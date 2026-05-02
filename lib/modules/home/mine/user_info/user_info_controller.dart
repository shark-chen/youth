import 'package:kellychat/base/base_controller.dart';
import 'package:kellychat/network/net/entry/user/user.dart';
import 'model/user_info_entity.dart';
import 'view_model/user_info_vm.dart';
export 'controller/user_info_route_controller.dart';
export 'controller/user_info_request_controller.dart';
import 'controller/user_info_request_controller.dart';

/// FileName: user_info_controller
///
/// @Author 谌文
/// @Date 2026/3/16 22:51
///
/// @Description 用户信息模块-controller
class UserInfoController extends BaseController {
  UserInfoController({String? userId}) {
    vm.value.userId = userId;
  }

  /// vm
  Rx<UserInfoVM> vm = UserInfoVM().obs;

  @override
  void onInit() async {
    super.onInit();
    final userId = vm.value.userId;
    if (userId != null) {
      /// request -他人信息
      title = '用户详情';
      await requestOtherUserProfile(userId);
    } else {
      title = '个人中心';
      await requestUserProfile();
    }
  }

  /// mark - method
  ///
  /// 获取数据
  UserInfoEntity? get userInfo {
    return vm.value.userInfo;
  }

}
