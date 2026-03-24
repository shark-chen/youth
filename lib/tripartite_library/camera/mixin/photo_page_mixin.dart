import 'package:flutter/material.dart';

/// FileName photo_page_mixin
///
/// @Author 谌文
/// @Date 2023/12/7 21:24
///
/// @Description
abstract class PhotoPageMixin {
  /// 是否显示导航头
  bool showPhotoTopBar();

  /// 相机拍照自定义view
  Widget? photoCustomWidget();
}