import 'package:youth/base/base_bindings.dart';
import '../sex_select/model/user_info_param.dart';
import 'birthday_select_controller.dart';

/// FileName: birthday_select_binding
///
/// @Author 谌文
/// @Date 2026/3/26 16:31
///
/// @Description 生日选择-binding
class BirthdaySelectBinding extends BaseBindings {
  @override
  void dependencies() {
    if (Get.arguments != null && Get.arguments is UserInfoParam) {
      Get.lazyPut<BirthdaySelectController>(
        () => BirthdaySelectController(userInfoParam: Get.arguments),
      );
    } else {
      Get.lazyPut<BirthdaySelectController>(() => BirthdaySelectController());
    }
  }
}
