import '../../../base/base_bindings.dart';
import 'network_look_controller.dart';

/// FileName network_look_binding
///
/// @Author 谌文
/// @Date 2023/10/8 19:26
///
/// @Description binding
class NetworkLookBinding extends BaseBindings {
  @override
  void dependencies() {
    Get.lazyPut<NetworkLookController>(() {
      return NetworkLookController();
    });
  }
}