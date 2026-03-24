import 'dart:io';
import 'package:youth/tripartite_library/documents/documents.dart';
import '../../../config/environment_config/app_config.dart';
import '../../../modules/user/user_center/user_center.dart';
import '../../../utils/marco/marco.dart';

/// FileName report_config
///
/// @Author 谌文
/// @Date 2023/9/15 16:57
///
/// @Description 请求接口需要上报的接口
/// 致命, 严重, 一般, 提示, 建议
enum ErrorLevel { deadly, severity, general, hint, suggest }

class ReportConfig {
  /// 哪些接口报错需要上报- 默认是错误级别是 -致命类型
  static var needReportErrorUrls = {
    AppConfig.getScanToShipUrl,
    AppConfig.getGenerateExpressSignUrl,
  };

  /// 不需要上报的接口, 黑名单, 比如上报接口本身
  static var ignoreReportErrorUrls = {
    AppConfig.getUploadLogUrl,
    AppConfig.getUploadFlagUrl,
  };

  /// 基础参数
  static Future<Map<String, dynamic>> getBaseParameters() async {
    return {
      "username": UserCenter().user?.account,
      "puid": UserCenter().user?.puid,
      "errorLevel": "一般",
      "platform": isIOS ? "iOS" : ((UserCenter().isCamera) ? 'Android' : 'PDA'),
      "apiPath": '',
      "networkType": "网络类型暂无",
      "networkStatus": "网络状态暂无",
      "memory": "内存消耗暂无",
      "errorTime": "报错发生的事件",
      // "appVersion":
      //     "${(await packageInfo).version}(${(await packageInfo).buildNumber})",
    };
  }

  static Map errorLevelMap = {
    ErrorLevel.deadly: "致命",
    ErrorLevel.severity: "严重",
    ErrorLevel.general: "一般",
    ErrorLevel.hint: "提示",
    ErrorLevel.suggest: "建议",
  };

  /// 获取日志文件
  static Future<File> getReportFile() async {
    final directory = await Documents().directory;
    return File(
        '${directory.path}/BigSeller_log_${UserCenter().user?.account}.txt');
  }
}

/// 企业微信可上报文本日志的白名单
List<String> whiteList = [
  '2690803127@qq.com',
  '395892199@qq.com',
  'gl7777@swz6010000',
];
