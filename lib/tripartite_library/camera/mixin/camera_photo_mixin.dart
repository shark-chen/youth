import '../model/photo_model.dart';

/// FileName camera_photo_mixin
///
/// @Author 谌文
/// @Date 2023/12/6 10:38
///
/// @Description 相机拍照混合类
abstract class CameraPhotoMixin {
  /// 拍照结果
  void exportPhotoResult(PhotoModel? photoModel, bool sure);
}