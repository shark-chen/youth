import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kellychat/modules/routes/app_pages.dart';
import 'package:kellychat/utils/extension/lists/lists.dart';
import 'package:kellychat/utils/extension/strings/strings.dart';
import 'package:kellychat/widget/bottom_alert/bottom_alert.dart';
import 'package:kellychat/widget/region_picker/region_picker_sheet.dart';
import '../edit_mine_info_controller.dart';
import 'edit_mine_info_request_controller.dart';
import '../view/edit_change_password_sheet_widget.dart';
import '../view/edit_gender_sheet_widget.dart';
import '../view/edit_reset_private_password_confirm_dialog.dart';
import '../view/edit_nickname_sheet_widget.dart';
import '../birthday_sheet/view/edit_birthday_sheet_widget.dart';

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
    String? hintText,
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
          hintText: hintText,
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
      wholeCustomWidget: SafeArea(
        child: EditChangePasswordSheetWidget(
          title: title,
          closeTap: Get.back,
          showResetPassword: vm.value.draft.hasPrivateContent,
          onConfirm: (password) {
            Get.back();
            onConfirm.call(password);
          },
          onModifyPasswordTap: () {
            Get.back();
            Future<void>.microtask(() async {
              await pushResetPrivatePasswordConfirmDialog();
            });
          },
        ),
      ),
    );
  }

  /// 居中弹框：确认重置私密密码（清空私密信息）
  Future<void> pushResetPrivatePasswordConfirmDialog() async {
    final ctx = Get.context;
    if (ctx == null) return;
    await showDialog<void>(
      context: ctx,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (dialogContext) => DialogAlertWidget(
        leftTap: () => Navigator.pop(dialogContext),
        rightTap: () async {
          Navigator.pop(dialogContext);

          /// request-重置私密信息密码
          await requestUserPrivateResetPassword();

          /// 请求个人信息数据
          await requestData();
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

  /// 修改生日（全屏半透明遮罩 + 底部滚轮；点遮罩或 X 均采用当前滚轮日期）
  Future<void> pushEditBirthdaySheet() async {
    final ctx = Get.context;
    if (ctx == null) return;
    final now = DateTime.now();
    final initial = vm.value.birthdayAsDate() ?? DateTime(now.year - 25);
    final picked = await showDialog<DateTime>(
      context: ctx,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (dialogContext) =>
          EditBirthdaySheetDialog(initialDate: initial),
    );
    if (picked != null) {
      vm.value.setBirthday(picked);
      vm.refresh();
    }
  }

  /// 底部弹出省市区选择（加载 assets/data/china_regions.json）
  Future<void> pushRegionPickerAlert() async {
    final ctx = Get.context;
    if (ctx == null) return;
    final provinces = await vm.value.loadProvinces();
    if (Lists.isEmpty(provinces)) return;
    final h = MediaQuery.sizeOf(ctx).height;
    await showModalBottomSheet<void>(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return SizedBox(
          height: h * 0.65,
          child: RegionPickerSheet(
            title: '选择地区',
            provinces: provinces ?? [],
            onClose: Get.back,
            onSelectionChanged: (s) {
              if (!Strings.isNotEmpty(s.district)) {
                EasyLoading.showToast('请选择区县');
                return;
              }
              vm.value.draft.province = s.province;
              vm.value.draft.city = s.city;
              vm.value.draft.district = s.district;
              vm.refresh();
              Get.back();
            },
          ),
        );
      },
    );
  }

  /// push - 私密语言-页面
  Future<void> pushPrivateMessagePage({
    String? content,
    String? password,
    String? oldPassword,
  }) async {
    await Get.toNamed(Routes.editPrivateMessagePage, parameters: {
      'content': content ?? '',
      'password': password ?? '',
      'oldPassword': oldPassword ?? '',
    });
  }
}
