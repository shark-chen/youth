import 'package:webview_flutter/webview_flutter.dart';
import '../webView_script_channel.dart';
import '../webview_page/base_camera_webview_controller.dart';

/// FileName camera_script_channel
///
/// @Author 谌文
/// @Date 2023/6/15 15:06
///
/// @Description js 控制相机- 无此业务了， 可删除
class CameraScriptChannel extends WebViewScriptChannel {
  CameraScriptChannel(super.name, super.controller);

  @override
  void handler(JavaScriptMessage message) async {
    if (controller != null && controller is BaseCameraWebViewController) {
      var viewController = controller as BaseCameraWebViewController;
      switch (message.message) {
        case "changeCamera":
          await viewController.changeCamera();
          break;
        case "takeImage":
          await viewController.takeImage();
          break;
        case "changeModeToTakeImage":
          viewController.changeMode("takeImage");
          break;
        case "changeModeToScanImage":
          viewController.changeMode("scanImage");
          break;
        case "initCamera":
          await viewController.initCamera();
          break;
        case "pausePreview":
          viewController.pausePreview();
          break;
        case "resumePreview":
          viewController.resumePreview();
          break;
        case "stopCamera":
          await viewController.stopCamera();
          break;
        case "showCamera":
          viewController.showCamera();
          break;
        case "hideCamera":
          viewController.hideCamera();
          break;
        case "goOnScan":
          viewController.goOnScan();
          break;
      }
    }
  }
}
