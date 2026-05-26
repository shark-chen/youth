import 'dart:async';
import 'package:kellychat/base/base_controller.dart';
import 'package:kellychat/modules/home/mine/edit_mine_info/view/edit_reset_private_password_confirm_dialog.dart';
import 'package:kellychat/modules/user/user_center/my_doing/my_doing.dart';
import '../../model/doing_nav_ids.dart';
import '../doing_list_controller.dart';
import '../model/doing_list_entity.dart';
import '../model/invite_friend_entity.dart';
import '../model/invitation_item_entity.dart';
import '../view/doing_together_confirm_widget.dart';
import 'package:kellychat/modules/home/doing/doing_together_dialog_copy.dart';
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
    vm.refresh();
    final doing = MyDoing().doing;
    if (doing != null) {
      vm.value.doingHotTagsEntity?.tagName = doing.tagName;
      vm.value.doingHotTagsEntity?.tagId = doing.tagId;
    }
    await refreshData();
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
                '确定向「${item?.nickname ?? '--'}」发起「${vm.value.doingListEntity?.tagName ?? '-'}」一起做邀约吗？',
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
        content: '将移除当前状态，并断开与当前用户的连接。',
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

  /// push - 已与其他人建立一起做的提示弹窗
  Future<void> pushAlreadyConnectedDialog(String partnerName) async {
    final ctx = Get.context;
    if (ctx == null) return;
    await showDialog<void>(
      context: ctx,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (dialogContext) => DialogAlertWidget(
        content: '你正在与$partnerName一起做，请取消后再试。',
        leftTitle: '我知道了',
        leftTap: Get.back,
        rightTitle: '',
        rightTap: Get.back,
      ),
    );
  }

  /// push - 取消旧邀约并建立新的一起做 弹窗
  Future<bool> pushCancelOldInvitationAlert(
      InvitationItemEntity? invitation) async {
    var result = false;
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
}
