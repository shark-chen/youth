import 'package:youth/base/base_bindings.dart';
import 'login_controller.dart';

/// FileName login_binding
///
/// @Author 谌文
/// @Date 2024/7/8 14:34
///
/// @Description binding
class LoginBinding extends BaseBindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
  }
}
