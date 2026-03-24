import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../widget/alert/alert.dart';
import '../../generated/locales.g.dart';

/// FileName photos_authority
///
/// @Author 谌文
/// @Date 2024/3/11 20:42
///
/// @Description 相册存储权限
class PhotosAuthority {
  /// 请求权限
  static Future<bool> request() async {
    bool permission = false;
    try {
      PermissionStatus status;
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt <= 32) {
          status = await Permission.storage.status;
        } else {
          status = await Permission.photos.request();
        }
      } else {
        status = await Permission.storage.status;
      }

      /// permanentlyDenied 已经手动拒绝; 弹框提示用户去设置页面设置权限
      if (status == PermissionStatus.permanentlyDenied ||
          status == PermissionStatus.restricted) {
        await PhotosAuthority.showCameraRejectDeniedDialog(
            LocaleKeys.accessAlbumStoragePermissionsOpenStoragePermissions.tr);
        permission = false;
      } else if (status == PermissionStatus.denied) {
        /// denied从未授权过，需要申请授权
        PermissionStatus status = await Permission.photos.request();
        if (status.isDenied && Platform.isAndroid) {
          status = await Permission.storage.request();
        }
        if (status.isDenied || status.isPermanentlyDenied) {
          await PhotosAuthority.showCameraRejectDeniedDialog(LocaleKeys
              .accessAlbumStoragePermissionsOpenStoragePermissions.tr);
          permission = false;
        } else {
          permission = true;
        }
      } else {
        permission = true;
      }
    } catch (_) {
    } finally {
      return permission;
    }
  }

  static Future showCameraRejectDeniedDialog(String content) async {
    return await Alert.show(
      title: content,
      rightTitle: LocaleKeys.GoSetting.tr,
      sureTap: () async {
        try {
          await AppSettings.openAppSettings();
        } catch (_) {}
      },
    );
  }
}
