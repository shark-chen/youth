import 'dart:io';
import 'package:get/get.dart';
import 'package:kellychat/widget/alert/alert.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../generated/locales.g.dart';

/// FileName file_authority
///
/// @Author 谌文
/// @Date 2024/8/5 14:43
///
/// @Description 文件访问权限
class FileAuthority {
  /// 请求权限
  static Future<bool> request() async {
    if (Platform.isIOS) return true;
    if (await Permission.storage.request().isGranted) {
      return true;
    }
    if (await Permission.manageExternalStorage.request().isGranted) {
      return true;
    }
    await Alert.show(
        title: '需求打开文件访问权限，获取日志',
        leftTitle: LocaleKeys.Cancel.tr,
        rightTitle: LocaleKeys.Confirm.tr,
        sureTap: openAppSettings);
    return false;
  }
}
