import 'package:flutter/services.dart';
import '../../utils/marco/debug_print.dart';

/// FileName app_events
///
/// @Author 谌文
/// @Date 2023/10/30 13:44
///
/// @Description APP埋点时间 -Facebook
class AppEvents {
  static const platform = MethodChannel('com.shark/AppEvents');

  /// 上报事件
  /// event- 上报事件
  static Future<dynamic> event(String event, {dynamic arguments}) async {
    dynamic result;
    try {
      result = await platform
          .invokeMethod("logEvent", {'event': event, 'arguments': arguments});
    } on PlatformException catch (e) {
      DebugPrint(e);
    }
    return result;
  }
}

/// 注册成功
const registerCompleted = 'registerCompleted';
