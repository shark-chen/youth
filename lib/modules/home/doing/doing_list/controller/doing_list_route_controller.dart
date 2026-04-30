import 'dart:async';
import 'package:kellychat/base/base_controller.dart';
import '../doing_list_controller.dart';
import '../model/doing_list_entity.dart';
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
  /// push - 邀请
  Future<void> pushInviteAlert() async {
    final ctx = Get.context;
    if (ctx == null) return;
    await BottomAlert.alerts(
      ctx,
      isDismissible: true,
      wholeCustomWidget: InviteTogetherSheetWidget(
        inviteCode: '${vm.value.myDoing?.tagId ?? '--'}',
        shareLink:
            'https://images.unsplash.com/photo-1538370965046-79c0d6907d47',
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
}
