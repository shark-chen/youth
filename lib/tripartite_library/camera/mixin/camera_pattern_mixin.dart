/// FileName camera_pattern_mixin
///
/// @Author 谌文
/// @Date 2023/12/11 18:58
///
/// @Description 相机模式
enum CameraPattern {
  /// 扫描模式
  scanPattern,

  /// 拍照模式
  photoPattern,

  /// 原生相机拍照模式
  pickerPhotoPattern,

  /// 扫描+拍照模式
  scanAndPhotoPattern,

  /// 扫描+原生相机拍照模式
  scanAndPickerPattern,
}

abstract class CameraPatternMixin {
  CameraPattern obtainCameraPattern();
}
