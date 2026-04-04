import 'package:webview_flutter/webview_flutter.dart';
import '../webView_script_channel.dart';

/// FileName global_script_channel
///
/// @Author 谌文
/// @Date 2023/6/15 15:06
///
/// @Description js 控制 各种东西
class GlobalScriptChannel extends WebViewScriptChannel {
  GlobalScriptChannel(super.name, super.controller);

  @override
  void handler(JavaScriptMessage message) async {}
}

String getPathBeforeQuery(String? input) {
  if (input == null || input.isEmpty) return '';
  int index = input.indexOf('?');
  return index != -1 ? input.substring(0, index) : input;
}

String? url(String? input) {
  Uri uri = Uri.parse("https://dummy.com$input");
  String? urlValue = uri.queryParameters['clipboardUrl'];
  return urlValue;
}
