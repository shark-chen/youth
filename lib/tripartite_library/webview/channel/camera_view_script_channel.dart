import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';
import '../webView_script_channel.dart';
import '../message/view_change_message_model.dart';
import '../webview_page/base_camera_webview_controller.dart';

/// FileName camera_view_script_channel
///
/// @Author 谌文
/// @Date 2023/6/15 15:06
///
/// @Description js 控制相机- 无此业务了， 可删除
class CameraViewScriptChannel extends WebViewScriptChannel {
  CameraViewScriptChannel(super.name, super.controller);

  @override
  void handler(JavaScriptMessage message) {
    if (controller is BaseCameraWebViewController) {
      var viewController = controller as BaseCameraWebViewController;
      ViewChangeMessageModel model;
      try {
        model = ViewChangeMessageModel.fromJson(jsonDecode(message.message));
        viewController.changeView(model);
      } catch (_) {}
    }
  }
}
