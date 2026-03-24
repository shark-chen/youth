import 'package:app_settings/app_settings.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../generated/locales.g.dart';
import 'dart:io';
import '../../widget/alert/alert.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

/// FileName camera_authority
///
/// @Author 谌文
/// @Date 2023/8/21 13:32
///
/// @Description 相机权限
class CameraAuthority {
  /// 请求相机权限
  static Future requestCameraAuthority({String? tip}) async {
    PermissionStatus status = await Permission.camera.status;
    bool permission = false;

    /// permanentlyDenied 已经手动拒绝; 弹框提示用户去设置页面设置权限
    if (status == PermissionStatus.permanentlyDenied ||
        status == PermissionStatus.restricted) {
      await CameraAuthority.showCameraRejectDeniedDialog(tip: tip);
      permission = false;
    } else if (status == PermissionStatus.denied) {
      /// denied从未授权过，需要申请授权
      PermissionStatus status;
      if (Platform.isIOS) {
        status = await Permission.camera.request();
      } else {
        EasyLoading.showToast(tip ?? LocaleKeys.requireCameraPermissionsPleaseAuthorizeUseCamera.tr,
            toastPosition: EasyLoadingToastPosition.top,
            duration: const Duration(milliseconds: 10000));
        status = await Permission.camera.request();
      }
      if (status.isDenied || status.isPermanentlyDenied) {
        await CameraAuthority.showCameraRejectDeniedDialog(tip: tip);
      } else {
        EasyLoading.dismiss();
        // todo 第一次相机授权立即回调permission,相机预览不出来(能扫描),后续还的深究啥原因
        await Future.delayed(
            const Duration(milliseconds: 300), () => permission = true);
      }
    } else {
      permission = true;
    }
    return permission;
  }

  static Future showCameraRejectDeniedDialog({String? tip}) async {
    return await Alert.show(
      title: tip ?? LocaleKeys.requireCameraPermissionsPleaseAuthorizeUseCamera.tr,
      rightTitle: LocaleKeys.GoSetting.tr,
      cancelTap: () {
        Get.back();
        EasyLoading.dismiss();
      },
      sureTap: () async {
        try {
          await AppSettings.openAppSettings();
        } catch (_) {}
        Get.back();
      },
    );
  }
}
