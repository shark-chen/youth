import 'package:get/get.dart';
import 'package:youth/widget/bottom_alert/bottom_alert.dart';

import '../edit_mine_info_controller.dart';
import '../view/edit_nickname_widget.dart';

/// FileName: edit_mine_info_route_controller
///
/// @Author 谌文
/// @Date 2026/4/13 23:33
///
/// @Description 编辑资料-路由-controller
extension EditMineInfoRouteController on EditMineInfoController {
  /// push - 修改昵称（底部弹框 + 输入聚焦）
  Future<void> pushEditNiceNameAlert() async {
    final ctx = Get.context;
    if (ctx == null) return;

    final tec = TextEditingController(text: vm.value.draft.nickname);
    final focusNode = FocusNode();
    focusNode.requestFocus();
    try {
      await BottomAlert.alerts(
        ctx,
        isDismissible: true,
        wholeCustomWidget: EditNickNameWidget(
          nickname: tec.text,
          maxLength: 100,
          controller: tec,
          focusNode: focusNode,
          closeTap: Get.back,
          sureTap: () {

          },
        ),
      );
    } finally {
      tec.dispose();
      focusNode.dispose();
    }
  }
}

