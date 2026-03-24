import 'package:camera/camera.dart';

/// 相机模型控制类
class CameraDrive {
  /// 获取摄像机后置摄像头
  static int getCameraBackIndex(List<CameraDescription> cameras) {
    try {
      if (cameras.any((element) =>
          element.lensDirection == CameraLensDirection.back &&
          element.sensorOrientation == 90)) {
        return cameras.indexOf(cameras.firstWhere((element) =>
            element.lensDirection == CameraLensDirection.back &&
            element.sensorOrientation == 90));
      } else {
        return cameras.indexOf(
          cameras.firstWhere(
              (element) => element.lensDirection == CameraLensDirection.back),
        );
      }
    } catch (_) {
      return 0;
    }
  }
}
