import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:image/image.dart' as img;

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
