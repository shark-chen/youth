import 'package:webview_flutter/webview_flutter.dart';
import 'webview_page/base_web_view_controller.dart';

/// web-js调用Flutter 通道
abstract class WebViewScriptChannel {
  final BaseWebViewController? controller;

  /// 通道名称
  final String name;

  WebViewScriptChannel(this.name, this.controller);

  void handler(JavaScriptMessage message);
}
