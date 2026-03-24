import '../../../base/base_bindings.dart';
import 'service_alter_controller.dart';

/// FileName service_alter_binding
///
/// @Author 谌文
/// @Date 2024/7/12 16:13
///
/// @Description binding
class ServiceAlterBinding extends BaseBindings {
  @override
  void dependencies() {
    Get.put<ServiceAlterController>(ServiceAlterController());
  }
}