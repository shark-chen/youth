import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/widgets.dart';

/// FileName: device_info_util
///
/// @Author 谌文
/// @Date 2025/9/28 16:04
///
/// @Description 设备信息工具类
class DeviceInfoUtil {
  static final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  /// 安卓设备信息
  static AndroidDeviceInfo? _androidInfo;

  static Future<AndroidDeviceInfo> get androidInfo async {
    _androidInfo ??= await deviceInfo.androidInfo;
    return _androidInfo!;
  }

  /// iOS设备信息
  static IosDeviceInfo? _iosInfo;

  static Future<IosDeviceInfo> get iosInfo async {
    _iosInfo ??= await deviceInfo.iosInfo;
    return _iosInfo!;
  }

  /// 获取设备唯一ID
  static Future<String> getDeviceId() async {
    try {
      if (Platform.isAndroid) {
        /// 在 Android 10+ 中，ANDROID_ID 是应用特定的
        return (await androidInfo).id;
      } else if (Platform.isIOS) {
        /// 在 iOS 中，identifierForVendor 是应用供应商特定的
        return (await iosInfo).identifierForVendor ?? 'unknown';
      } else if (Platform.isWindows) {
        WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;
        return windowsInfo.deviceId;
      } else if (Platform.isMacOS) {
        MacOsDeviceInfo macOsInfo = await deviceInfo.macOsInfo;
        return macOsInfo.systemGUID ?? 'unknown';
      } else if (Platform.isLinux) {
        LinuxDeviceInfo linuxInfo = await deviceInfo.linuxInfo;
        return linuxInfo.machineId ?? 'unknown';
      }
    } catch (e) {
      debugPrint('Error getting device ID: $e');
    }
    return 'unknown';
  }
}
