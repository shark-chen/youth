import '../cameras_controller.dart';

/// FileName photo_zoom_controller
///
/// @Author 谌文
/// @Date 2024/7/15 14:12
///
/// @Description  图片放大缩小
extension PhotoZoomController on CamerasController {
  void photoZoomPointerDown(PointerDownEvent event) {
    photoZoom.pointers++;
  }

  void photoZoomPointerUp(PointerUpEvent event) {
    photoZoom.pointers--;
  }

  void photoZoomStart(ScaleStartDetails details) {
  }

  /// 放大缩小
  Future photoZoomUpdate(ScaleUpdateDetails details) async {
  }

  /// 双击
  Future photoZoomDoubleTap() async {
  }
}
