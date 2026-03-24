import '../cameras_controller.dart';

/// FileName cameras_zoom_controller
///
/// @Author 谌文
/// @Date 2024/7/15 14:14
///
/// @Description 相机放大缩小
extension CamerasZoomController on CamerasController {
  void camerasZoomPointerDown(PointerDownEvent event) {
    zoom.pointers++;
  }

  void camerasZoomPointerUp(PointerUpEvent event) {
    zoom.pointers--;
  }

  void camerasZoomStart(ScaleStartDetails details) {
    zoom.baseScale = zoom.currentScale;
  }

  /// 放大缩小
  Future camerasZoomUpdate(ScaleUpdateDetails details) async {
    if (cameraEngine == null || zoom.pointers != 2) {
      return;
    }
    zoom.currentScale = (zoom.baseScale * details.scale)
        .clamp(zoom.minAvailableZoom, zoom.maxAvailableZoom);
    await cameraEngine!.setZoomLevel(zoom.currentScale);
  }

  /// 双击
  Future camerasZoomDoubleTap() async {
    zoom.currentScale =
    (zoom.currentScale + 1) > 3.0 ? 1.0 : zoom.currentScale + 1;
    await cameraEngine!.setZoomLevel(zoom.currentScale);
  }

  /// 用于设置相机预览视图中的焦点位置和曝光点的方法
  void camerasZoomFinderTap(
      TapDownDetails details, BoxConstraints constraints) {
    if (cameraEngine == null) {
      return;
    }
    final CameraController cameraController = cameraEngine!;
    final Offset offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    cameraController.setExposurePoint(offset);
    cameraController.setFocusPoint(offset);
  }
}

