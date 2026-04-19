import 'package:get/get.dart';
import 'package:youth/utils/extension/lists/lists.dart';
import 'package:youth/utils/extension/strings/strings.dart';
import 'package:youth/widget/bottom_alert/bottom_alert.dart';
import 'package:youth/widget/region_picker/region_picker_sheet.dart';
import '../edit_mine_info_controller.dart';
import 'edit_mine_info_request_controller.dart';
import '../view/edit_change_password_sheet_widget.dart';
import '../view/edit_gender_sheet_widget.dart';
import '../view/edit_reset_private_password_confirm_dialog.dart';
import '../view/edit_nickname_sheet_widget.dart';

/// FileName: edit_mine_info_route_controller
///
/// @Author 谌文
/// @Date 2026/4/13 23:33
///
/// @Description 编辑资料-路由-controller
extension EditMineInfoRouteController on EditMineInfoController {
  /// push - 修改昵称（底部弹框 + 输入聚焦）
  Future<void> pushEditNiceNameAlert({
    String? title,
    String? text,
    ValueChanged<String>? sureCall,
  }) async {
    final ctx = Get.context;
    if (ctx == null) return;
    final tec = TextEditingController(text: text);
    final focusNode = FocusNode();
    focusNode.requestFocus();
    try {
      await BottomAlert.alerts(
        ctx,
        isDismissible: true,
        wholeCustomWidget: EditNickNameSheetWidget(
          title: title,
          nickname: tec.text,
          maxLength: 100,
          controller: tec,
          focusNode: focusNode,
          closeTap: Get.back,
          sureTap: () => sureCall?.call(tec.text.trim()),
        ),
      );
    } finally {
      tec.dispose();
      focusNode.dispose();
    }
  }

  /// push - 更改密码（6 位数字 + 修改密码入口）
  Future<void> pushPasswordAlert({
    required String title,
    required ValueChanged<String> onConfirm,
  }) async {
    final ctx = Get.context;
    if (ctx == null) return;
    await BottomAlert.alerts(
      ctx,
      isDismissible: true,
      wholeCustomWidget: EditChangePasswordSheetWidget(
        title: title,
        closeTap: Get.back,
        showResetPassword: vm.value.draft?.hasPrivateContent ,
        onConfirm: (password) {
          Get.back();
          onConfirm.call(password);
        },
        onModifyPasswordTap: () {
          Get.back();
          Future<void>.microtask(() async {
            await showResetPrivatePasswordConfirmDialog();
          });
        },
      ),
    );
  }

  /// 居中弹框：确认重置私密密码（清空私密信息）
  Future<void> showResetPrivatePasswordConfirmDialog() async {
    final ctx = Get.context;
    if (ctx == null) return;
    await showDialog<void>(
      context: ctx,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (dialogContext) => EditResetPrivatePasswordConfirmDialog(
        onCancel: () => Navigator.pop(dialogContext),
        onConfirm: () async {
          Navigator.pop(dialogContext);
          await requestUserPrivateResetPassword();
        },
      ),
    );
  }

  /// push - 修改性别
  Future<void> pushEditGenderAlert() async {
    final ctx = Get.context;
    if (ctx == null) return;
    await BottomAlert.alerts(
      ctx,
      isDismissible: true,
      wholeCustomWidget: EditGenderSheetWidget(
        selectGender: vm.value.gender,
        closeTap: Get.back,
        selectTap: (gender) {
          vm.value.setGender(gender.index + 1);
          vm.refresh();
          Get.back();
        },
      ),
    );
  }

  /// 底部弹出省市区选择（加载 assets/data/china_regions.json）
  Future<void> pushRegionPickerAlert() async {
    final ctx = Get.context;
    if (ctx == null) return;
    final provinces = await vm.value.loadProvinces();
    if (Lists.isEmpty(provinces)) return;
    await showModalBottomSheet(
      context: ctx,
      builder: (BuildContext context) {
        return RegionPickerSheet(
          provinces: provinces ?? [],
          onClose: Get.back,
          onSelectionChanged: (s) async {
            print(s);
            if (Strings.isNotEmpty(s.district)) {
              vm.value.draft.province = s.province;
              vm.value.draft.city = s.city;
              vm.value.draft.district = s.district;
              vm.refresh();
              Get.back();
            }
          },
        );
      },
    );
  }
}
