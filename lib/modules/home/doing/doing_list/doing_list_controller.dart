import 'package:youth/base/base_controller.dart';
import 'view_model/doing_list_vm.dart';

/// FileName: doing_list_controller
///
/// @Author 谌文
/// @Date 2026/3/9 23:18
///
/// @Description 正在做的清单-controller
class DoingListController extends BaseController {
  /// vm
  Rx<DoingListVM> vm = DoingListVM().obs;

  @override
  void onInit() async {
    super.onInit();
    title = '😯 我正在';
  }
}
