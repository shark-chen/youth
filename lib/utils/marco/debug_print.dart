import 'package:youth/config/environment_config/app_config.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

/// FileName debug_print
///
/// @Author 谌文
/// @Date 2023/8/15 17:23
///
/// @Description debug环境下才输出
// ignore: non_constant_identifier_names
void DebugPrint(Object? object) {
  if (kDebugMode) {
    print(object);
  }
}

/// 是否是测试环境 -及非正式环境都是true
final isDev = AppConfig.env != Environment.prod || true;

/// Getx是否打印
final getEnableLog = isDev && true;

/// 是否打印网络接口数据
final netEnableLog = isDev && true;

/// 是否打印网络接口请求头数据
final netHeaderEnableLog = isDev && true;

/// 是否发送异常数据到企业微信群
final wechatSendCodeException = isDev && true;
