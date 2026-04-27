import 'package:kellychat/base/base_bindings.dart';
import 'sex_select_controller.dart';

/// FileName: sex_select_binding
///
/// @Author 谌文
/// @Date 2026/3/25 23:52
///
/// @Description 性别选择-binding
class SexSelectBinding extends BaseBindings {
  @override
  void dependencies() {
    Get.lazyPut<SexSelectController>(() => SexSelectController());
  }
}
