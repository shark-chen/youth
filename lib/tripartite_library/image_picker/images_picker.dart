import 'package:image_picker/image_picker.dart';

/// FileName images_picker
///
/// @Author 谌文
/// @Date 2024/7/26 17:25
///
/// @Description 调用系统相机或者照片库
class ImagesPicker extends ImagePicker {
  /// 打开系统相机拍照
  Future<XFile?> takePicture() async {
    return await pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
    );
  }
}
