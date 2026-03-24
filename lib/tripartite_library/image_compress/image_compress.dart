import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

/// FileName image_compress
///
/// @Author 谌文
/// @Date 2024/8/13 10:21
///
/// @Description 图片压缩
class ImageCompress {
  /// 压缩图片
  static Future<XFile?> compressImage(
    XFile? file,
    int targetSizeInBytes,
  ) async {
    if (file == null) return file;

    /// 初始压缩质量
    int quality = 100;
    int decrease = 10;
    if (targetSizeInBytes > (1024 * 1024 * 9)) {
      quality = 50;
    }
    XFile? compressedFile;

    /// 不断降低质量直到文件大小接近目标大小
    while (quality > 0) {
      final dir = await getTemporaryDirectory();
      final targetPath =
          "${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg";
      compressedFile = await FlutterImageCompress.compressAndGetFile(
        file.path,
        targetPath,
        quality: quality,
      );

      /// 检查压缩后的文件大小
      if (compressedFile != null &&
          (await compressedFile.length()) <= targetSizeInBytes) {
        break;
      }
      quality -= decrease;
    }
    return compressedFile;
  }
}
