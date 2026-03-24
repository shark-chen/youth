import 'package:youth/base/base_bindings.dart';
import 'ping_controller.dart';

/// FileName: ping_binding
///
/// @Author 谌文
/// @Date 2026/1/22 10:35
///
/// @Description ping_binding
class PingBinding extends BaseBindings {
   @override
   void dependencies() {
      Get.lazyPut<PingController>(()=> PingController());
   }
}