import 'package:get/get.dart';
import 'login_controller.dart';
import 'model/reLogin_account_entity.dart';

/// FileName login_binding
///
/// @Author 谌文
/// @Date 2024/7/8 14:34
///
/// @Description binding
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    if (Get.arguments != null && Get.arguments is ReLoginAccountEntity) {
      Get.put<LoginController>(LoginController(reLogin: Get.arguments));
    } else {
      Get.put<LoginController>(LoginController());
    }
  }
}
