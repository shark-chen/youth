import 'package:kellychat/widget/bottom_alert/bottom_alert.dart';
import 'package:kellychat/base/base_controller.dart';
import '../doing_list_controller.dart';
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
}
