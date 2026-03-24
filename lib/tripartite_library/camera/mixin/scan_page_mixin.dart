import 'package:flutter/material.dart';

/// FileName scan_page_mixin
///
/// @Author 谌文
/// @Date 2023/12/8 09:22
///
/// @Description
abstract class ScanPageMixin {
  /// 是否显示导航头
  bool showScanTopBar();

  Widget? scanCustomWidget();
}
