import 'package:youth/widget/bottom_alert/bottom_alert.dart';
import 'package:youth/widget/bottom_dialog/bottom_dialog.dart';
import 'package:get/get.dart';
import '../edit_mine_info_controller.dart';
import '../view/edit_nickname_widget.dart';

/// FileName: edit_mine_info_route_controller
///
/// @Author 谌文
/// @Date 2026/4/13 23:33
///
/// @Description 编辑资料-路由-controller
extension EditMineInfoRouteController on EditMineInfoController {
  /// push - 修改昵称
  Future<void> pushEditNiceNameAlert() async {
    await BottomAlert.alerts(
      Get.context!,
      wholeCustomWidget: EditNickNameWidget(

        closeTap: Get.back,
      ),
    );
  }
}
