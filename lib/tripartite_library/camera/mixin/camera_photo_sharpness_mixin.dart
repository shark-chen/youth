import 'dart:async';
import '../camera_engine/camera_engine.dart';

/// FileName camera_photo_sharpness_mixin
///
/// @Author 谌文
/// @Date 2025/6/30 15:26
///
/// @Description 拍照清晰度
abstract class CameraPhotoSharpnessMixin {
  /// 是否需要 自定义拍照清晰度
  bool? isCustomPhotoSharpness();

  /// 获取自定义拍照清晰度
  Future<ResolutionPreset?> getCustomPhotoSharpness();
}