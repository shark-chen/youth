import '../../../base/base_bindings.dart';
import 'mine_controller.dart';

/// FileName mine_binding
///
/// @Author 谌文
/// @Date 2023/8/23 11:41
///
/// @Description binding
class MineBinding extends BaseBindings {
  @override
  void dependencies() {
    Get.put<MineController>(MineController());
  }
}