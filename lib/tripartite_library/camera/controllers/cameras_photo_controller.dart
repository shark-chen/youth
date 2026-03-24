import '../../../utils/extension/dates/dates.dart';
import '../camera_engine/camera_engine.dart';
import '../camera_tool/convert_image.dart';
import '../cameras_controller.dart';
import '../model/photo_model.dart';
import 'dart:ui' as ui;

/// FileName cameras_photo_controller
///
/// @Author 谌文
/// @Date 2024/7/29 13:29
///
/// @Description camera库的拍照
bool _isTakingPicture = false;

extension CamerasPhotoController on CamerasController {
  /// MARK - 拍照模式
  /// 拍照样式
  Future camerasPhotoMode() async {
    cameraVM.cameraType?.value = CameraType.photo;
    scannerIng = true;
    cameraVM.previewIng = false;
    cameraVM.cameraType?.refresh();
    final CameraEngine? controller = cameraEngine;
    if (controller != null) {
      controller.resumePreview();
    }
  }

  /// 切换成扫描模式
  Future camerasScanMode() async {
    scannerIng = false;
    cameraVM.previewIng = false;
    startScan();
    cameraVM.cameraType?.value = CameraType.scan;
    cameraVM.cameraType?.refresh();
  }

  /// 拍照
  Future takeImage() async {
    takeImageTap();
    final CameraEngine? controller = cameraEngine;
    if (controller == null) return null;
    try {
      cameraVM.photoModel?.clearMultipartFile();
      try {
        if (GetPlatform.isIOS ||
            cameraVM.sharpness?.preset == ResolutionPreset.ultraHigh ||
            cameraVM.sharpness?.preset == ResolutionPreset.max) {
          await cameraTakePicture();
        } else {
          /// 发现切换标清 & 高清的时候，尺寸是不会变化的，都是 720 *1280。后续看下
          /// 通过获取视频流转成图片方式
          final inputImage = CameraImageTool.cameraImageConvertInputImage(
              (cameraVM.photoModel?.cameraImage)!, camera, controller);

          var originalImage = await ConvertImage.convertToImage(inputImage!);

          /// 添加时间水印
          if (cameraVM.showTimeWatermark == true) {
            originalImage = await addWatermark(originalImage);
          }

          cameraVM.photoModel = PhotoModel(image: originalImage);
          cameraVM.photoModel?.generateMultipartFile();
        }
      } catch (e, _) {
        await cameraTakePicture();
      }
      exportPhotoResult(cameraVM.photoModel, false);
      if (cameraVM.previewPhoto) {
        cameraVM.previewIng = true;
        cameraVM.cameraType?.refresh();
      }
      await stopScan();
    } on CameraException catch (e, s) {
    }
  }

  Future<ui.Image> addWatermark(ui.Image originalImage) async {
    try {
      // 创建一个 PictureRecorder 和 Canvas 来绘制带水印的图片
      ui.PictureRecorder recorder = ui.PictureRecorder();
      Canvas canvas = Canvas(recorder);
      Paint paint = Paint();

      // 绘制原始图片
      canvas.drawImage(originalImage, Offset.zero, paint);

      // 以标清的 720 * 1080为基准，默认字体大小设为30，底部偏移 20。再此基础根据比例sharpness字段进行等比放大即可
      double fontSize = 30;
      int dy = 20;

      // 高清先不处理，现存问题，切换标清 & 高清的时候，分辨率是不会发生变化的，都是 720 *1280。后续在看下
      if (cameraVM.sharpness?.preset != ResolutionPreset.veryHigh) {
        fontSize = fontSize * (cameraVM.sharpness?.sharpness.value ?? 1);
        dy = dy * (cameraVM.sharpness?.sharpness.value ?? 1);
      }

      // 设置水印文本样式
      DateTime now = DateTime.now();
      TextSpan textSpan = TextSpan(
        text: Dates.timeFormatHM(now),
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          background: Paint()..color = Colors.black.withOpacity(0.3),
        ),
      );

      TextPainter textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      // 设置水印位置（底部 x轴居中）
      double offsetX = (originalImage.width.toDouble() - textPainter.width) / 2;
      double offsetY =
          originalImage.height.toDouble() - textPainter.height - dy;

      textPainter.paint(canvas, Offset(offsetX, offsetY));

      // 结束录制并获取图片
      ui.Picture pictureWithWatermark = recorder.endRecording();
      ui.Image watermarkedImage = await pictureWithWatermark.toImage(
          originalImage.width, originalImage.height);

      return watermarkedImage;
    } catch (_) {
      return originalImage;
    }
  }

  /// 相机库调用获取照片
  Future cameraTakePicture() async {
    if (_isTakingPicture) return;
    _isTakingPicture = true;
    try {
      final CameraEngine? controller = cameraEngine;
      if (controller == null) return null;

      /// 直接调用API获取图片- 缺点，三星手机拍照很慢
      var file = await controller.takePicture();

      if (Strings.isEmpty(file.path)) return;

      /// 添加时间水印
      if (cameraVM.showTimeWatermark == true) {
        /// 读取图片文件为字节数据
        final Uint8List imageBytes = await file.readAsBytes();

        // 生成 ui.Image
        ui.Codec codec = await ui.instantiateImageCodec(imageBytes);
        ui.FrameInfo frameInfo = await codec.getNextFrame();
        ui.Image originalImage = frameInfo.image;

        ui.Image watermarkedImage = await addWatermark(originalImage);

        cameraVM.photoModel = PhotoModel(image: watermarkedImage);
        cameraVM.photoModel?.generateMultipartFile();
        return;
      }

      cameraVM.photoModel = PhotoModel(file: file);
      cameraVM.photoModel?.generateMultipartFile();
    } finally {
      _isTakingPicture = false;
    }
  }

  /// 取消拍照
  Future cancelTakeImage() async {
    cancelTakeImageTap();
    if (obtainCameraPattern() == CameraPattern.scanAndPhotoPattern) {
      await switchScanMode();
    } else {
      Get.back();
    }
  }
}
