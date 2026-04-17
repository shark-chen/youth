import 'package:youth/base/base_bindings.dart';
import 'user_info_controller.dart';

/// FileName: user_info_binding
///
/// @Author 谌文
/// @Date 2026/3/16 22:50
///
/// @Description 用户信息模块-binding
class UserInfoBinding extends BaseBindings {
  @override
  void dependencies() {
    final parameters = Get.parameters;
    if (Maps.isNotEmpty(parameters) &&
        Strings.isNotEmpty(parameters['userId'])) {
      Get.lazyPut<UserInfoController>(
        () => UserInfoController(userId: parameters['userId']),
      );
    } else {
      Get.lazyPut<UserInfoController>(() => UserInfoController());
    }
  }
}
