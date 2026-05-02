import 'package:image_picker/image_picker.dart';
import 'package:kellychat/utils/authority/photos_authority.dart';

/// FileName images_picker
///
/// @Author 谌文
/// @Date 2024/7/26 17:25
///
/// @Description 调用系统相机或者照片库
class ImagesPicker {
  final ImagePicker _imagePicker = ImagePicker();

  /// 打开系统相机拍照
  Future<XFile?> takePicture() async {
    return await _imagePicker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
    );
  }

  /// 相册选图：关闭 Loading、下一帧再调起，避免遮罩/重建与系统相册冲突；iOS 关闭全量元数据以减轻卡死
  Future<XFile?> pickImageFromGallery({
    int imageQuality = 90,
  }) async {
    if (!await PhotosAuthority.request()) return null;
    return await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 2048,
      maxHeight: 2048,
      imageQuality: imageQuality,
      requestFullMetadata: false,
    );
  }
}
