import 'package:kellychat/modules/home/doing/doing_list/model/invitation_item_entity.dart';
import 'package:kellychat/modules/home/doing/doing_list/view/doing_together_confirm_widget.dart';
import 'package:kellychat/modules/home/doing/doing_together_dialog_copy.dart';
import 'package:kellychat/modules/user/user_center/my_doing/my_doing.dart';
import 'package:kellychat/modules/home/mine/edit_mine_info/view/edit_reset_private_password_confirm_dialog.dart';
import 'package:kellychat/widget/bottom_alert/bottom_alert.dart';
import 'package:kellychat/base/base_controller.dart';
import '../user_info_controller.dart';
import '../view/block_user_confirm_dialog.dart';
import '../view/invite_partner_together_sheet_widget.dart';
import '../view/more_actions_sheet_widget.dart';
import 'user_info_request_controller.dart';

/// FileName: user_info_route_controller
///
/// @Author 谌文
/// @Date 2026/4/19 13:22
///
/// @Description 编辑资料-路由-controller
extension UserInfoRouteController on UserInfoController {
  /// push - 实际聊天窗口-page-页面
  Future pushChatPage() async {
    await Get.toNamed(Routes.chatPage, parameters: {
      'userId': (vm.value.userInfo?.id ?? '').toString(),
      'niceName': vm.value.userInfo?.nickname ?? '',
      'avatar': vm.value.userInfo?.avatar ?? '',
    });
  }

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
  Future<bool> pushEditMineInfoPage() async {
    final result = await Get.toNamed(Routes.editMineInfoPage);
    if (true == result) {
      return result;
    }
    return false;
  }

  /// push - 一起做确认（已有正在做，与 DoingList 文案一致）
  Future<bool> pushTogetherDoAlert({String? tagName}) async {
    final doingTagName = tagName ?? MyDoing().doing?.tagName ?? '-';
    var result = false;
    await Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: DoingTogetherConfirmWidget(
            content:
                '确定向「${userInfo?.nickname ?? '--'}」发起「$doingTagName」一起做邀约吗？',
            onCancel: Get.back,
            onContinue: () async {
              result = true;
              Get.back();
            },
          ),
        ),
      ),
      barrierDismissible: true,
    );
    return result;
  }

  /// 邀请对方一起做 — 底部输入弹层，返回输入文案；取消/关闭返回 null
  Future<String?> pushInvitePartnerTogetherSheet() async {
    final ctx = Get.context;
    if (ctx == null) return null;
    final tec = TextEditingController();
    final focusNode = FocusNode();
    String? result;
    try {
      await BottomAlert.alerts(
        ctx,
        isDismissible: true,
        wholeCustomWidget: InvitePartnerTogetherSheetWidget(
          controller: tec,
          focusNode: focusNode,
          closeTap: Get.back,
          onConfirm: (text) {
            result = text;
            Get.back();
          },
        ),
      );
    } finally {
      tec.dispose();
      focusNode.dispose();
    }
    return result;
  }

  /// 当前有邀约 — 取消旧约后继续
  Future<bool> pushCancelOldInvitationAlert(
    InvitationItemEntity? invitation,
  ) async {
    var confirmed = false;
    await Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: DoingTogetherConfirmWidget(
            content: DoingTogetherDialogCopy.cancelOldInvitationMessage(
              invitation,
            ),
            onCancel: Get.back,
            onContinue: () async {
              confirmed = true;
              Get.back();
            },
          ),
        ),
      ),
      barrierDismissible: true,
    );
    return confirmed;
  }

  /// push - 取消正在做的事情状态
  Future<bool> pushCancelDoingDialog(String? niceName) async {
    var result = false;
    await showDialog<void>(
      context: Get.context!,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (dialogContext) => DialogAlertWidget(
        content: '是否断开与${niceName ?? '--'}的连接？',
        leftTap: Get.back,
        rightTitle: '断开',
        rightTap: () async {
          result = true;
          Get.back();
        },
      ),
    );
    return result;
  }

  /// 有待接受邀约 — 仅提示（历史 cancelOld 文案，单按钮我知道了）
  Future<bool> pushPendingInvitationTipDialog(
    InvitationItemEntity? invitation,
  ) async {
    final ctx = Get.context;
    if (ctx == null) return false;
    var result = false;
    await showDialog<void>(
      context: ctx,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (dialogContext) => DialogAlertWidget(
        content: DoingTogetherDialogCopy.cancelOldInvitationMessage(
          invitation,
        ),
        leftTitle: '取消',
        leftTap: Get.back,
        rightTitle: '继续',
        rightTap: () {
          result = true;
          Get.back();
        },
      ),
    );
    return result;
  }

  /// push - 已与其他人建立一起做的提示弹窗
  Future<bool> pushAlreadyConnectedDialog(String partnerName) async {
    final ctx = Get.context;
    if (ctx == null) return false;
    var result = false;
    await showDialog<void>(
      context: ctx,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (dialogContext) => DialogAlertWidget(
        content: '你正在与$partnerName一起做，请取消后再试。',
        leftTitle: '我知道了',
        leftTap: Get.back,
        rightTitle: '',
        rightTap: () {
          result = true;
          Get.back();
        },
      ),
    );
    return result;
  }
}
