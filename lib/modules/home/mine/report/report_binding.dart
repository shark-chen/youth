import 'package:kellychat/base/base_bindings.dart';

import 'report_controller.dart';

/// FileName: report_binding
///
/// @Author 谌文
/// @Date 2026/4/19
///
/// @Description
class ReportBinding extends BaseBindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportController>(() => ReportController());
  }
}
