import 'package:get/get.dart';

/// FileName photo_zoom
///
/// @Author 谌文
/// @Date 2024/7/15 13:53
///
/// @Description 图片放大缩小模型
class PhotoZoom {
  double minAvailableZoom = 1.0;
  double maxAvailableZoom = 8.0;
  RxDouble currentScale = 1.0.obs;
  double baseScale = 1.0;
  int pointers = 0;
}