import 'package:youth/base/base_bindings.dart';

import 'mine_controller.dart';

/// FileName: mine_binding
///
/// @Author 谌文
/// @Date 2026/4/12 20:42
///
/// @Description 我的页 binding
class MineBinding extends BaseBindings {
  @override
  void dependencies() {
    Get.lazyPut<MineController>(() => MineController());
  }
}
