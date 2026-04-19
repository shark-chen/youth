import 'package:youth/widget/bottom_alert/bottom_alert.dart';
import 'package:youth/base/base_controller.dart';

import '../user_info_controller.dart';
import '../view/block_user_confirm_dialog.dart';
import '../view/more_actions_sheet_widget.dart';
import 'user_info_request_controller.dart';

/// FileName: user_info_route_controller
///
/// @Author 谌文
/// @Date 2026/4/19 13:22
///
/// @Description 编辑资料-路由-controller
extension UserInfoRouteController on UserInfoController {
  /// push - 修改性别
  Future<void> pushMoreActionsAlert() async {
    final ctx = Get.context;
    if (ctx == null) return;
    await BottomAlert.alerts(
      ctx,
      isDismissible: true,
      wholeCustomWidget: MoreActionsSheetWidget(
        title: '',
        closeTap: Get.back,
        onReportTap: pushReportPage,
        onBlockTap: pushBlockUserConfirmAlert,
      ),
    );
  }

  /// push - 修改性别
  Future<void> pushBlockUserConfirmAlert() async {
    final ctx = Get.context;
    if (ctx == null) return;
    await showDialog<void>(
      context: ctx,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (ctx) => BlockUserConfirmDialog(
        targetName: vm.value.userInfo?.nickname ?? '',
        onCancel: Get.back,
        onConfirm: () async {
          Get.back();

          /// 拉黑用户
          await requestBlockUser(blockedUserId: vm.value.userId ?? '2');
          Get.back();
        },
      ),
    );
  }

  /// 举报
  Future<void> pushReportPage() async {
    await Get.toNamed(Routes.reportPage);
  }
}
