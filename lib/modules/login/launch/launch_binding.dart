import 'package:get/get.dart';
import 'launch_controller.dart';

/// FileName launch_binding
///
/// @Author 谌文
/// @Date 2023/9/20 09:35
///
/// @Description 启动页
class LaunchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LaunchController>(LaunchController());
  }
}
