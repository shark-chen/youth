import 'package:flutter/services.dart';

/// FileName system_chromes
///
/// @Author 谌文
/// @Date 2024/6/25 16:53
///
/// @Description 系统管理
extension SystemChromes on SystemChrome {
  /// 设置应用程序支持所有方向
  static Future<void> setAllDirectionScreen() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  /// 设置应用程序只支持竖屏方向
  static Future<void> setPortraitScreen() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  /// 设置应用程序只支持横屏方向
  static Future<void> setLandscapeScreen() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
}
