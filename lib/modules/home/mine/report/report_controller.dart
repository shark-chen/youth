import 'package:youth/base/base_controller.dart';

import 'model/report_reason_data.dart';

/// FileName: report_controller
///
/// @Author 谌文
/// @Date 2026/4/19
///
/// @Description 举报理由
class ReportController extends BaseController {
  /// 被举报用户 id（路由参数 `userId`，可选）
  String? reportedUserId;

  @override
  void onInit() {
    super.onInit();
    title = '举报理由';
    reportedUserId = Get.parameters['userId'];
  }

  /// 选择举报理由后进入「举报证据」页
  void onSelectReason(ReportReasonItem item) {
    final p = <String, String>{'reasonId': item.id};
    if (reportedUserId != null && reportedUserId!.trim().isNotEmpty) {
      p['userId'] = reportedUserId!.trim();
    }
    Get.toNamed(Routes.reportSubmitPage, parameters: p);
  }
}
