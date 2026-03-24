import 'dart:async';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
export 'package:image_gallery_saver/image_gallery_saver.dart';

/// FileName gallery_savers
///
/// @Author 谌文
/// @Date 2024/7/29 15:44
///
/// @Description 相册库
mixin GalleryMixin {
  /// 保存图片
  FutureOr saveImage(Uint8List imageBytes);

  Future saveFile(String file);

  Future saveUrl(String url);
}

class ImageGallerySavers with GalleryMixin {
  @override
  Future saveFile(String file) {
    return ImageGallerySaver.saveFile(file);
  }

  @override
  FutureOr saveImage(Uint8List imageBytes) {
    return ImageGallerySaver.saveImage(imageBytes);
  }

  @override
  Future saveUrl(String url) {
    throw UnimplementedError();
  }
}
