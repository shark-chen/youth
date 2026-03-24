import 'cameras_controller.dart';

class CameraScanBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CamerasController>(CamerasController());
  }
}