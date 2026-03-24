import '../cameras_controller.dart';

/// FileName cameras_sharpness_controller
///
/// @Author 谌文
/// @Date 2024/7/15 14:17
///
/// @Description 清晰度模块
extension CamerasSharpnessController on CamerasController {
  /// 点击清晰度按钮
  void clickSharpness() {
    cameraVM.sharpness?.showSharpnessElect.value =
        !(cameraVM.sharpness?.showSharpnessElect.value ?? false);
    cameraVM.sharpness?.showSharpnessElect.refresh();
  }

  /// 设置清晰度
  /// sharpness: 1:标清， 2：高清， 3： 超清
  Future selectSharpness(int sharpness) async {
    if ((await cameraVM.selectSharpness(sharpness)) == false) return;
    await initCameraEngine(preset: cameraVM.sharpness?.preset);
    if (GetPlatform.isIOS ||
        cameraVM.sharpness?.preset == ResolutionPreset.ultraHigh ||
        cameraVM.sharpness?.preset == ResolutionPreset.max) {
      await closeScan();
    } else {
      await stopScan();
    }
  }
}
