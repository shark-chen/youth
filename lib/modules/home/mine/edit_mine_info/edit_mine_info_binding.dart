import 'package:kellychat/base/base_bindings.dart';
import 'edit_mine_info_controller.dart';

/// FileName: edit_mine_info_binding
///
/// @Author 谌文
/// @Date 2026/4/12 22:51
///
/// @Description
class EditMineInfoBinding extends BaseBindings {
  @override
  void dependencies() {
    Get.lazyPut<EditMineInfoController>(() => EditMineInfoController());
  }
}
