import 'package:webview_flutter/webview_flutter.dart';
import '../webView_script_channel.dart';

/// FileName reload_script_channel
///
/// @Author 谌文
/// @Date 2023/6/15 15:06
///
/// @Description js 新刷新webView
class ReloadScriptChannel extends WebViewScriptChannel {
  ReloadScriptChannel(super.name, super.controller);

  @override
  void handler(JavaScriptMessage message) {
    controller?.webViewController?.loadRequest(Uri.parse(message.message));
  }
}
