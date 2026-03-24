import '../cameras_controller.dart';
import '../model/photo_model.dart';

/// FileName cameras_picker_controller
///
/// @Author 谌文
/// @Date 2024/7/29 11:40
///
/// @Description 原生相机控制器
extension PickerPhotoController on CamerasController {
  /// 切换到原生相机拍照模式
  Future<void> pickerPhotoMode() async {
    await cameraEngine?.stopImageStream();
    await stopScan();
    XFile? file = await picker.takePicture();
    if(Strings.isEmpty(file?.path)) {
      if(obtainCameraPattern() == CameraPattern.scanAndPickerPattern) {
        /// 切换成扫描模式
        switchScanMode();
      } else if(obtainCameraPattern() == CameraPattern.pickerPhotoPattern) {
        Get.back();
      }
      return;
    }
    cameraVM.photoModel = PhotoModel(file: file);
    cameraVM.photoModel?.generateMultipartFile();
    exportPhotoResult(cameraVM.photoModel, true);
  }

  /// 切换成扫描模式
  Future pickerScanMode() async {
    scannerIng = false;
    cameraVM.previewIng = false;
    await cameraEngine?.initialize().then((_) {
      cameraVM.cameraInitialized.value = true;
      cameraVM.cameraType?.value = CameraType.scan;
      cameraVM.cameraType?.refresh();
      startScan();
    });
    cameraVM.cameraType?.value = CameraType.scan;
    cameraVM.cameraType?.refresh();
  }
}
