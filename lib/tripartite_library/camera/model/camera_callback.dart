import 'package:flutter/material.dart';

class CameraScanCallBack {
  CameraScanCallBack({
    required this.scanResultCallback,
    this.title,
    this.customWidget,
  });

  /// 扫描页面的标题
  String? title;

  /// 开启扫描结果回调call- 默认是开始的
  VoidCallback? startScanCall;

  /// 关闭扫描，流也停止了
  VoidCallback? closeScanCall;

  /// 停止扫描 （只是不返回扫描结果）
  VoidCallback? stopScanCall;

  /// 恢复扫摸 （返回扫描结果）
  VoidCallback? resumeScanCall;

  /// 关闭扫描页面call-
  VoidCallback? closeScanPageCall;

  /// 改变摄像头
  VoidCallback? changeCameraCall;

  /// 自定义扫描页面
  Widget? customWidget;

  /// 扫描结果回调
  Future Function(List list, List? changeList) scanResultCallback;
}
