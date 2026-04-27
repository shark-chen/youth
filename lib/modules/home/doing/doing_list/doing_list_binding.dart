import 'package:kellychat/base/base_bindings.dart';
import 'doing_list_controller.dart';

/// FileName: doing_list_binding
///
/// @Author 谌文
/// @Date 2026/3/9 23:18
///
/// @Description 正在做的清单-binding
class DoingListBinding extends BaseBindings {
  @override
  void dependencies() {
    Get.lazyPut<DoingListController>(() => DoingListController());
  }
}
