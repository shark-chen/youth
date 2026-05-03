import 'dart:async';
import 'package:kellychat/base/base_controller.dart';
import 'package:kellychat/modules/home/mine/edit_mine_info/view/edit_reset_private_password_confirm_dialog.dart';
import '../../model/doing_nav_ids.dart';
import '../doing_list_controller.dart';
import '../model/doing_list_entity.dart';
import '../model/invite_friend_entity.dart';
import '../view/doing_together_confirm_widget.dart';
import '../view/invite_together_sheet_widget.dart';

/// FileName: doing_list_route_controller
///
/// @Author 谌文
/// @Date 2026/4/16 21:43
///
/// @Description
extension DoingListRouteController on DoingListController {
  /// mark - push
  ///
  /// 个人信息页面
  Future pushUserInfoPage() async {
    await Get.toNamed(Routes.minePage);
  }

  /// mark - push
  ///
  /// push-正在做的清单-页面
  Future pushDoingPage() async {
    await Get.toNamed(Routes.doingPage, id: doingNavigatorId);
  }

  /// push - 邀请
  Future<void> pushInviteAlert(InviteFriendEntity? entity) async {
    if (entity == null) return;
    final ctx = Get.context;
    if (ctx == null) return;
    await BottomAlert.alerts(
      ctx,
      isDismissible: true,
      wholeCustomWidget: InviteTogetherSheetWidget(
        inviteCode: entity.inviteCode ?? '',
        shareLink: entity.link ?? '',
        onWeChatTap: () {
          EasyLoading.showToast('还打不开微信');
        },
      ),
    );
  }

  /// push - 个人信息页面
  Future<void> pushProfile({required String userId}) async {
    await Get.toNamed(Routes.userInfoPage, parameters: {
      'userId': userId,
    });
  }

  /// push - 一起做 弹框确认alert
  Future<bool> pushTogetherDoAlert(DoingListList? item) async {
    var result = false;
    await Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: DoingTogetherConfirmWidget(
            content:
                '你向「${item?.nickname ?? '--'}」发起的「${vm.value.doingListEntity?.tagName ?? '-'}」一起做邀约，等待对方接受中。继续操作将取消该邀约，并建立新的一起做。',
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

  /// push - 取消正在做的事情状态
  Future<bool> pushCancelDoingDialog() async {
    final ctx = Get.context;
    if (ctx == null) return false;
    var result = false;
    await showDialog<void>(
      context: ctx,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (dialogContext) => DialogAlertWidget(
        content: '是否移除当前状态',
        leftTap: Get.back,
        rightTitle: '确定',
        rightTap: () async {
          result = true;
          Get.back();
        },
      ),
    );
    return result;
  }
}
