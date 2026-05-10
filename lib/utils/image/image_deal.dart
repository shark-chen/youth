import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:cross_file/cross_file.dart';
import 'package:image/image.dart' as img;
import 'package:kellychat/tripartite_library/image_compress/image_compress.dart';
import 'package:path_provider/path_provider.dart';

/// FileName image_deal
///
/// @Author 谌文
/// @Date 2024/3/27 15:39
///
/// @Description 图片处理工具
class ImageByteData {
  ImageByteData({this.byteData, this.uint8List});

  final ByteData? byteData;
  final Uint8List? uint8List;
}

class ImageDeal {
  /// 将本地图片压到不超过 [maxBytes]（默认 4MB），返回可供上传（如 FormData 本地文件）使用的路径。
  ///
  /// - 原文件不超过上限时 **直接返回** [filePath]，不写临时文件。
  /// - 否则先走 [ImageCompress]（`flutter_image_compress`）；若仍超限，再用降采样 + JPEG 兜底。
  /// - 返回路径可能是临时目录下的 `.jpg`，上传成功后可按需 [File.delete]。
  /// - 文件不存在、无法解码或兜底仍无法达标时抛出异常。
  Future<String> compressFileUnderMaxBytes(
    String filePath, {
    int maxBytes = 1 * 1024 * 1024,
  }) async {
    final file = File(filePath);
    if (!await file.exists()) {
      throw ArgumentError.value(filePath, 'filePath', '文件不存在');
    }
    final length = await file.length();
    if (length <= maxBytes) {
      return filePath;
    }

    final compressed =
        await ImageCompress.compressImage(XFile(filePath), maxBytes);
    if (compressed == null) {
      throw StateError('图片压缩失败: $filePath');
    }
    final outPath = compressed.path;
    final outLen = await File(outPath).length();
    if (outLen <= maxBytes) {
      return outPath;
    }

    return _fallbackShrinkFileToMaxBytes(outPath, maxBytes);
  }

  /// 原生压缩仍超限时的兜底：降分辨率 + 降 JPEG 质量，直到 ≤ [maxBytes]。
  Future<String> _fallbackShrinkFileToMaxBytes(
    String filePath,
    int maxBytes,
  ) async {
    final raw = await File(filePath).readAsBytes();
    final decoded = img.decodeImage(raw);
    if (decoded == null) {
      throw FormatException('无法解码图片: $filePath');
    }
    img.Image image = decoded;

    var quality = 85;
    while (true) {
      final jpg = Uint8List.fromList(img.encodeJpg(image, quality: quality));
      if (jpg.length <= maxBytes) {
        return _writeTempJpgBytes(jpg);
      }
      if (image.width > 128 && image.height > 128) {
        final nw = (image.width * 0.82).round().clamp(128, image.width).toInt();
        final nh = (image.height * (nw / image.width)).round();
        image = img.copyResize(image, width: nw, height: nh);
        quality = 85;
        continue;
      }
      if (quality > 15) {
        quality -= 10;
        continue;
      }
      final last = Uint8List.fromList(img.encodeJpg(image, quality: 10));
      if (last.length <= maxBytes) {
        return _writeTempJpgBytes(last);
      }
      throw StateError('无法在可接受范围内将图片压至 ${maxBytes ~/ 1024}KB 以下');
    }
  }

  Future<String> _writeTempJpgBytes(Uint8List bytes) async {
    final dir = await getTemporaryDirectory();
    final path =
        '${dir.path}/img_deal_${DateTime.now().millisecondsSinceEpoch}.jpg';
    await File(path).writeAsBytes(bytes);
    return path;
  }

  /// 压缩图片
  Future<ImageByteData?> compressImage(ByteData? byteData) async {
    Uint8List? imageData = byteData?.buffer.asUint8List();
    if (imageData == null) {
      return ImageByteData(uint8List: imageData, byteData: byteData);
    }
    try {
      final Completer<ui.Image> completer = Completer();
      decodeImageFromList(imageData, (ui.Image img) => completer.complete(img));

      ui.Image image = await completer.future;
      // Calculate the scale factor to compress the image
      double scaleFactor = 1.0;
      int width = image.width;
      int height = image.height;

      // Choose the maximum width or height
      int maxDimension = 2048;
      if (width > maxDimension || height > maxDimension) {
        scaleFactor = maxDimension / width;
        if (height * scaleFactor > maxDimension) {
          scaleFactor = maxDimension / height;
        }
      }

      // Create a new canvas and paint the image on it
      ui.PictureRecorder recorder = ui.PictureRecorder();
      ui.Canvas canvas = ui.Canvas(recorder);
      canvas.scale(scaleFactor, scaleFactor);
      ui.Paint paint = ui.Paint();
      paint.filterQuality = ui.FilterQuality.high;
      canvas.drawImage(image, ui.Offset.zero, paint);

      // Convert the compressed image to ByteData
      ui.Picture picture = recorder.endRecording();
      ui.Image compressedImage = await picture.toImage(
          (width * scaleFactor).toInt(), (height * scaleFactor).toInt());
      ByteData? byteData =
          await compressedImage.toByteData(format: ui.ImageByteFormat.png);

      // Return the compressed image as a Uint8List
      return ImageByteData(
          uint8List: byteData?.buffer.asUint8List(), byteData: byteData);
    } catch (_) {
      return ImageByteData(uint8List: imageData, byteData: byteData);
    }
  }

// 将 ui.Image 转换为 img.Image
  Future<img.Image> convertUiImageToImgImage(ui.Image uiImage) async {
    final byteData =
        await uiImage.toByteData(format: ui.ImageByteFormat.rawRgba);
    if (byteData == null) {
      throw Exception("Failed to get image byte data.");
    }

    final pixels = byteData.buffer.asUint8List();

    // 将像素数据转换为 img.Image 格式
    img.Image image = img.Image(width: uiImage.width, height: uiImage.height);

    for (int y = 0; y < uiImage.height; y++) {
      for (int x = 0; x < uiImage.width; x++) {
        final index = (y * uiImage.width + x) * 4;
        final r = pixels[index];
        final g = pixels[index + 1];
        final b = pixels[index + 2];
        final a = pixels[index + 3];

        // 创建每个像素的 ARGB 值
        image.setPixel(x, y, img.ColorUint8.rgba(r, g, b, a));
      }
    }
    return image;
  }

  Future<img.Image> resizeImageForPrinter(
      img.Image originalImage, double targetWidthMm, int dpi) async {
    // 1. 计算打印机纸的宽度对应的像素数（转换为英寸后再计算像素）
    final targetWidthInches = targetWidthMm / 25.4; // 1 英寸 = 25.4 毫米
    final targetWidthPixels = (targetWidthInches * dpi).toInt();

    // 2. 计算原图的宽高比例
    final aspectRatio = originalImage.width / originalImage.height;

    // 3. 计算目标高度，保持宽高比例不变
    final targetHeightPixels = targetWidthPixels ~/ aspectRatio;

    // 4. 使用图像库调整尺寸
    final resizedImage = img.copyResize(originalImage,
        width: targetWidthPixels, height: targetHeightPixels);

    return resizedImage;
  }

  /// 二值化处理，阈值设置为128
  static img.Image imageBinaryConversion(img.Image binaryImage) {
    for (int y = 0; y < binaryImage.height; y++) {
      for (int x = 0; x < binaryImage.width; x++) {
        /// 获取像素值
        img.Pixel pixel = binaryImage.getPixel(x, y);

        /// 获取像素的RGB分量
        final r = pixel.r;
        final g = pixel.g;
        final b = pixel.b;

        /// 使用亮度计算公式
        final int luminance = (0.299 * r + 0.587 * g + 0.114 * b).round();

        /// 根据阈值设置颜色
        const int threshold = 128;
        final newColor = luminance < threshold ? blackColor : whiteColor;

        /// 设置新像素值
        binaryImage.setPixel(x, y, newColor);
      }
    }
    return binaryImage;
  }

  static img.Image imageBinaryConversion2(img.Image image) {
    final img.Image result = img.Image.from(image);

    /// 获取图像的字节数据
    final Uint8List bytes = result.getBytes();

    /// 一次性处理所有像素  每个像素4个字节(RGBA)
    for (int i = 0; i < bytes.length; i += 32) {
      final r = bytes[i];
      final g = bytes[i + 1];
      final b = bytes[i + 2];

      /// 计算亮度
      final luminance = (0.299 * r + 0.587 * g + 0.114 * b).round();

      /// 二值化
      final newValue = luminance < 128 ? 0 : 255;

      /// 设置RGB分量
      bytes[i] = newValue;
      bytes[i + 1] = newValue;
      bytes[i + 2] = newValue;
    }
    return result;
  }
}

/// ARGB 格式的黑色
final blackColor = img.ColorInt8.rgb(0, 0, 0);

/// ARGB 格式的白色
final whiteColor = img.ColorInt8.rgb(255, 255, 255);
