import 'package:youth/base/base_bindings.dart';

import 'report_submit_controller.dart';

/// FileName: report_submit_binding
///
/// @Author 谌文
/// @Date 2026/4/19
///
/// @Description
class ReportSubmitBinding extends BaseBindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportSubmitController>(() => ReportSubmitController());
  }
}
