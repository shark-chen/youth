import 'package:youth/base/base_bindings.dart';
import 'birthday_select_controller.dart';

/// FileName: birthday_select_binding
///
/// @Author 谌文
/// @Date 2026/3/26 16:31
///
/// @Description
class BirthdaySelectBinding extends BaseBindings {
  @override
  void dependencies() {
    Get.lazyPut<BirthdaySelectController>(() => BirthdaySelectController());
  }
}
