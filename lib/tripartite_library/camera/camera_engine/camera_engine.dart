export 'package:camera/camera.dart';
import '../cameras.dart';
export 'package:flutter/material.dart';

/// FileName camera_engine
///
/// @Author 谌文
/// @Date 2023/12/19 16:24
///
/// @Description 相机控制器
class CameraEngine extends CameraController {
  CameraEngine(
    super.description,
    super.resolutionPreset, {
    super.enableAudio,
    super.imageFormatGroup,
  });

  /// 输出照片流
  @override
  Future startImageStream(onLatestImageAvailable onAvailable) async {
    if (!cameraValid()) {
      return;
    }
    if (value.isRecordingVideo || value.isStreamingImages) {
      return 'A video recording is already started. startImageStream was called while a video is being recorded. \nor A camera has started streaming images. startImageStream was called while a camera was streaming images.';
    }
    await super.startImageStream(onAvailable);
  }

  /// 停止照片流输出
  @override
  Future stopImageStream() async {
    if (!cameraValid()) {
      return;
    }

    /// 不可重复停止
    if (!value.isStreamingImages) {
      return 'No camera is streaming images stopImageStream was called when no camera is streaming images.';
    }
    await super.stopImageStream();
  }

  /// 拍照
  @override
  Future<XFile> takePicture() async {
    if (!cameraValid()) {
      return XFile('');
    }
    if (value.isTakingPicture) {
      return XFile('');
    }

    /// 拍照前停止照片流输出，不停止有可能导致崩溃
    await stopImageStream();
    return await super.takePicture();
  }

  /// 预览
  @override
  Future resumePreview() async {
    if (!cameraValid()) {
      return;
    }
    if (!value.isPreviewPaused) {
      return;
    }
    return await super.resumePreview();
  }

  /// 暂停预览
  @override
  Future<void> pausePreview() async {
    if (!cameraValid()) {
      return;
    }
    if (value.isPreviewPaused) {
      return;
    }
    return await super.pausePreview();
  }

  /// 切换闪光灯
  Future changeLight(bool open) async {
    if (!cameraValid()) {
      return;
    }
    try {
      await setFlashMode(open ? FlashMode.torch : FlashMode.off);
    } catch (e, s) {

    }
  }

  /// 相机引擎是否有效
  bool cameraValid() {
    return value.isInitialized;
  }
}
