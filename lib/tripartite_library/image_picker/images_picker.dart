import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kellychat/utils/authority/photos_authority.dart';

import 'image_crop_editor.dart';

/// FileName images_picker
///
/// @Author 谌文
/// @Date 2024/7/26 17:25
///
/// @Description 调用系统相机或相册；选图后裁剪使用项目内 [extended_image] 编辑器（无 image_cropper 等额外原生库）
class ImagesPicker {
  final ImagePicker _imagePicker = ImagePicker();

  /// 打开系统相机拍照
  Future<XFile?> takePicture() async {
    return await _imagePicker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
    );
  }

  /// 拍照后进入裁剪页（需 [context] 用于 [Navigator]）
  Future<XFile?> takePictureThenEdit(
    BuildContext context, {
    double? cropAspectRatio,
  }) async {
    final shot = await takePicture();
    if (shot == null) return null;
    return cropWithEditor(context, shot, cropAspectRatio: cropAspectRatio);
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

  /// 相册选图后进入裁剪页（需 [context]）
  ///
  /// [cropAspectRatio] 为宽高比，如 `1` 表示正方形；为 `null` 表示自由比例。
  Future<XFile?> pickImageFromGalleryThenEdit(
    BuildContext context, {
    int imageQuality = 90,
    double? cropAspectRatio,
  }) async {
    final picked = await pickImageFromGallery(imageQuality: imageQuality);
    if (picked == null) return null;
    return cropWithEditor(context, picked, cropAspectRatio: cropAspectRatio);
  }

  /// 对已有本地图打开裁剪页（需 [context]）
  Future<XFile?> cropWithEditor(
    BuildContext context,
    XFile source, {
    double? cropAspectRatio,
  }) async {
    return openImageCropEditor(
      context,
      sourcePath: source.path,
      cropAspectRatio: cropAspectRatio,
    );
  }
}
