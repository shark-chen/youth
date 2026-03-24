import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'dart:math' as math;

/// FileName convert_image
///
/// @Author 谌文
/// @Date 2024/3/18 09:30
///
/// @Description 视频流转换成图片-(使用场景,如扫描后拍照)
class ConvertImage {
  /// 视频流转成图片
  static Future<ui.Image> convertToImage(InputImage inputImage) async {
    if (Platform.isAndroid) {
      return await rotateImage(await convertNv21ToImage(inputImage));
    }
    return await convertBgra8888ToImage(inputImage);
  }

  /// 转换Bgra8888成图片
  static Future<ui.Image> convertBgra8888ToImage(InputImage inputImage) {
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromPixels(
      inputImage.bytes!,
      (inputImage.metadata?.size.width.toInt())!,
      (inputImage.metadata?.size.height.toInt())!,
      PixelFormat.bgra8888,
      (ui.Image img) => completer.complete(img),
    );
    return completer.future;
  }

  ///Nv21流转换成ui.Image图片
  static Future<ui.Image> convertNv21ToImage(InputImage inputImage) {
    Uint8List nv21Data = inputImage.bytes!;
    final int width = (inputImage.metadata?.size.width.toInt())!;
    final int height = (inputImage.metadata?.size.height.toInt())!;
    Uint8List rgbData = Uint8List(width * height * 4);
    for (int i = 0, yp = 0; i < height; i++) {
      int uvp = width * height + (i >> 1) * width, u = 0, v = 0;
      for (int j = 0; j < width; j++, yp++) {
        int y = nv21Data[yp] & 0xff;
        if ((j & 1) == 0) {
          v = nv21Data[uvp++] & 0xff;
          u = nv21Data[uvp++] & 0xff;
        }
        rgbData[yp * 4 + 3] = 0xFF;
        rgbData[yp * 4 + 2] = (y + 1.13983 * (v - 128)).toInt().clamp(0, 255);
        rgbData[yp * 4 + 1] = (y - 0.39465 * (u - 128) - 0.5806 * (v - 128))
            .toInt()
            .clamp(0, 255);
        rgbData[yp * 4 + 0] = (y + 2.03211 * (u - 128)).toInt().clamp(0, 255);
      }
    }

    final ByteData byteData = ByteData.view(rgbData.buffer);
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromPixels(
      byteData.buffer.asUint8List(),
      width,
      height,
      ui.PixelFormat.bgra8888,
      (ui.Image img) => completer.complete(img),
      targetWidth: width,
      targetHeight: height,
      allowUpscaling: false,
    );
    return completer.future;
  }

  /// 图片旋转90度
  static Future<ui.Image> rotateImage(ui.Image image) async {
    final width = image.width;
    final height = image.height;
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    canvas.translate(height / 2, width / 2); // 注意这里交换了宽高
    canvas.rotate(math.pi / 2); // 逆时针旋转90度
    canvas.translate(-width / 2, -height / 2);
    canvas.drawImage(image, Offset.zero, Paint());
    final rotatedPicture = pictureRecorder.endRecording();
    return await rotatedPicture.toImage(height, width);
  }
}
