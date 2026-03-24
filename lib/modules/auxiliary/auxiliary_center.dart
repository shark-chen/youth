import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../network/reporter/config/report_config.dart';
import '../../network/reporter/report_util.dart';

/// FileName auxiliary_center
///
/// @Author 谌文
/// @Date 2023/12/20 11:13
///
/// @Description 辅助功能中心
class AuxiliaryCenter {
  static final AuxiliaryCenter _instance = AuxiliaryCenter._();

  factory AuxiliaryCenter() => _instance;

  AuxiliaryCenter._();

  bool _debug = false;

  /// 计时器
  Timer? _timer;

  /// 是否是调试模式
  bool get debug {
    return _debug;
  }

  /// 记录数据
  void record(
    String text, {
    ErrorLevel? errorLevel = ErrorLevel.severity,
    bool? ping,
  }) {
    if (_debug) {
      ReportUtil().record(text, errorLevel: errorLevel, ping: ping);
    }
  }

  /// 点击打开或关闭debug模式
  void autoOpenCloseDebug() {
    _debug = !_debug;
    EasyLoading.showToast('调试模式${_debug ? "开启" : '关闭'}',
        maskType: EasyLoadingMaskType.clear);
    if (_debug) {
      startTimer();
    }
  }

  /// 打开调试模式
  void openDebug() {
    _debug = true;
    EasyLoading.showToast('调试模式${_debug ? "开启" : '关闭'}',
        maskType: EasyLoadingMaskType.clear);
    startTimer();
  }

  /// 关闭调试模式
  void closeDebug() {
    _debug = false;
    EasyLoading.showToast('调试模式${_debug ? "开启" : '关闭'}',
        maskType: EasyLoadingMaskType.clear);
  }

  /// 计时器销毁
  void cancelTimer() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
  }

  /// 开始计时
  void startTimer() {
    cancelTimer();
    _timer = Timer(const Duration(minutes: 3), () {
      /// 计时器销毁
      cancelTimer();
      closeDebug();
    });
  }
}
