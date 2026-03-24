import 'dart:io';
import 'package:youth/tripartite_library/camera/cameras.dart';
import 'dart:ui' as ui;

/// FileName photo_preview_view
///
/// @Author 谌文
/// @Date 2023/12/6 15:37
///
/// @Description 拍照图片预览
class PhotoPreviewView extends StatelessWidget {
  const PhotoPreviewView({
    Key? key,
    required this.path,
    this.image,
    this.minScale = 0.8,
    this.maxScale,
  }) : super(key: key);

  /// 图片资源位置
  final String path;

  /// 图片image
  final ui.Image? image;

  /// 图片放大尺寸
  final double? minScale;

  /// 图片放大尺寸
  final double? maxScale;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      minScale: minScale ?? 0.8,
      maxScale: maxScale ?? 4.0,
      child: image == null
          ? Image.file(File(path), fit: BoxFit.fitHeight)
          : RawImage(image: image, fit: BoxFit.fitHeight),
    );
  }
}
