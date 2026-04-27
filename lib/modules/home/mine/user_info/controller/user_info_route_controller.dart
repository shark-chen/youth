import 'package:kellychat/widget/bottom_alert/bottom_alert.dart';
import 'package:kellychat/base/base_controller.dart';

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
  /// push - 更多
  Future<void> pushMoreActionsAlert() async {
    /// 是否已拉黑 · GET /api/block/check/{blockedUserId}
    final blocked =
        await requestBlockCheck(blockedUserId: vm.value.userId ?? '2');
    final ctx = Get.context;
    if (ctx == null) return;
    await BottomAlert.alerts(
      ctx,
      isDismissible: true,
      wholeCustomWidget: MoreActionsSheetWidget(
        title: '',
        blocked: blocked,
        closeTap: Get.back,
        onReportTap: () async {
          Get.back();
          await pushReportPage();
        },
        onBlockTap: () async {
          Get.back();
          await pushBlockUserConfirmAlert(
            blocked: blocked,
          );
        },
      ),
    );
  }

  /// push - 修改性别
  Future<void> pushBlockUserConfirmAlert({bool? blocked}) async {
    final ctx = Get.context;
    if (ctx == null) return;

    await showDialog<void>(
      context: ctx,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (ctx) => BlockUserConfirmDialog(
        targetName: vm.value.userInfo?.nickname ?? '',
        blocked: blocked,
        onCancel: Get.back,
        onConfirm: () async {
          Get.back();
          if (true == blocked) {
            /// 取消拉黑 · DELETE /api/block/{blockedUserId}
            await requestUnblockUser(blockedUserId: vm.value.userId ?? '2');
          } else {
            /// 拉黑用户
            await requestBlockUser(blockedUserId: vm.value.userId ?? '2');
          }
        },
      ),
    );
  }

  /// 举报
  Future<void> pushReportPage() async {
    final id = vm.value.userId?.trim();
    if (id != null && id.isNotEmpty) {
      await Get.toNamed(Routes.reportPage,
          parameters: <String, String>{'userId': id});
    } else {
      await Get.toNamed(Routes.reportPage);
    }
  }

  /// 关于 KellyChat
  Future<void> pushEditMineInfoPage() async {
    await Get.toNamed(Routes.editMineInfoPage);
  }
}
