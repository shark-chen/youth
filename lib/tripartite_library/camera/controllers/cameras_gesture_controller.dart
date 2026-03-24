import 'photo_zoom_controller.dart';
import 'cameras_zoom_controller.dart';
import '../cameras_controller.dart';

/// FileName cameras_gesture_controller
///
/// @Author 谌文
/// @Date 2024/7/15 14:15
///
/// @Description 手势事件
extension CamerasGestureController on CamerasController {
  void onPointerDown(PointerDownEvent event) {
    cameraVM.previewIng ? photoZoomPointerDown(event) : camerasZoomPointerDown(event);
  }

  void onPointerUp(PointerUpEvent event) {
    cameraVM.previewIng ? photoZoomPointerUp(event) : camerasZoomPointerUp(event);
  }

  void handleScaleStart(ScaleStartDetails details) {
    cameraVM.previewIng ? photoZoomStart(details) : camerasZoomStart(details);
  }


  /// 放大缩小
  Future handleScaleUpdate(ScaleUpdateDetails details) async {
    cameraVM.previewIng ? photoZoomUpdate(details) : camerasZoomUpdate(details);
  }

  /// 双击
  Future handleDoubleTap() async {
    cameraVM.previewIng ? photoZoomDoubleTap() : camerasZoomDoubleTap();
  }

  /// 用于设置相机预览视图中的焦点位置和曝光点的方法
  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    camerasZoomFinderTap(details, constraints);
  }

  /// 开始拖拽
  void handlePanStart(DragStartDetails details) {
    // photoPanStart(details);
  }

  /// 拖拽中
  void handlePanUpdate(DragUpdateDetails details) {
    // photoPanUpdate(details);
  }
}
