// ignore: library_prefixes
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as Api;
import '../../config/environment_config/config.dart';
import '../../tripartite_library/store/preferences.dart';
import '../network_monitor/model/network_status_model.dart';
import '../network_monitor/network_monitor.dart';
import 'config/report_config.dart';
import '../../base/base_controller.dart';

/// FileName report_util
///
/// @Author 谌文
/// @Date 2023/9/15 17:18
///
/// @Description 接口报错上报
class ReportUtil {
  static ReportUtil? _instance;

  ReportUtil._();

  factory ReportUtil() {
    _instance ??= ReportUtil._();
    return _instance!;
  }

  /// 基础数据
  Map<String, dynamic>? baseParameters;

  /// 监听网络状态
  void listenNetworkMonitor() {
    EventBusManager().listen<NetworkStatusModel>(this, (event) {
      baseParameters?['networkType'] = '${event.networkType}-${event.info}';
      baseParameters?['networkStatus'] = event.networkStatus;
    });
  }

  /// 记录数据
  void record(
    String text, {
    ErrorLevel? errorLevel = ErrorLevel.severity,
    bool? ping,
  }) async {
    if (environment == Environment.prod) return;

    /// 处理数据
    await _handleAndSaveData(text, errorLevel: errorLevel);
  }

  /// 记录请求数据
  void recordRequest({
    Api.Response? response,
    String? apiPath,
    Map<String, dynamic>? queryParameters,
    ErrorLevel? errorLevel = ErrorLevel.deadly,
    bool? ping = true,
  }) async {
    if (environment == Environment.prod) return;
    int code = ModelUtils.convert<int>(response?.data['code']) ?? -1;

    /// 白名单错误需要上报，黑名单不需要上报
    if (ReportConfig.needReportErrorUrls.contains(apiPath) &&
        !ReportConfig.ignoreReportErrorUrls.contains(apiPath) &&
        (response?.statusCode != 200 || code != 0)) {
      String text = {
        "path": apiPath,
        "queryParameters": queryParameters,
        "statusCode": response?.statusCode,
        "data": response?.data
      }.toString();

      /// 处理数据
      await _handleAndSaveData(text,
          apiPath: apiPath,
          queryParameters: queryParameters,
          errorLevel: errorLevel,
          ping: ping);
    }
  }

  /// 处理数据
  Future _handleAndSaveData(
    String text, {
    String? apiPath,
    Map<String, dynamic>? queryParameters,
    ErrorLevel? errorLevel,
    bool? ping,
  }) async {
    /// 开始写入文件
    void startSaveData() async {
      baseParameters ??= await ReportConfig.getBaseParameters();
      baseParameters?["errorLevel"] = ReportConfig.errorLevelMap[errorLevel];
      baseParameters?["errorTime"] = DateTime.now().toString();
      baseParameters?['username'] = UserCenter().user?.userInfo?.phone;
      baseParameters?['puid'] = UserCenter().user?.userInfo;
      Map<String, dynamic> map = {}
        ..addAll(baseParameters ?? {})
        ..addAll({"errorInfo": text})
        ..addAll({"apiPath": apiPath})
        ..addAll({"queryParameters": queryParameters});
      String content = json.encode(map);
      _writeToFile("****接口名称: $apiPath \n$content\n\n\n\n");
    }

    startSaveData();
  }

  int fourDayTamp = 4 * 24 * 60 * 60 * 1000;
  int saveBigByte = 3 * 1000 * 1000;

  /// 写入文件，只存四天的数据 || 文件大小超3M，则重新保存
  Future<void> _writeToFile(String text) async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    final file = await ReportConfig.getReportFile();
    if (!file.existsSync()) {
      file.createSync();
    }
    int? time = await Stores()
        .get<int>(UserConfigEnum.logSaveStartTime.toString(), userLat: false);
    if (time == null ||
        (timestamp - time) >= fourDayTamp ||
        (await file.length() > saveBigByte)) {
      await Stores().put<int>(
          UserConfigEnum.logSaveStartTime.toString(), timestamp,
          userLat: false);
      if (time != null) {
        String temp = file.readAsStringSync();
        String result = temp.substring(temp.length ~/ 2, temp.length);
        await file.writeAsString('$result$text', flush: true);
      } else {
        await file.writeAsString(text, flush: true);
      }
    } else {
      await file.writeAsString(text, flush: true, mode: FileMode.append);
    }
  }
}
