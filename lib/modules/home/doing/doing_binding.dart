import '../../../base/base_bindings.dart';
import 'doing_controller.dart';

/// FileName doing_binding
///
/// @Author 谌文
/// @Date 2023/8/24 11:18
///
/// @Description binding
class DoingBinding extends BaseBindings {
  @override
  void dependencies() {
    Get.lazyPut<DoingController>(() => DoingController());
  }
}
