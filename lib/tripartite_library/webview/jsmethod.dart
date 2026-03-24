import 'package:webview_flutter/webview_flutter.dart';

class JsMethod {
  final WebViewController controller;

  JsMethod(this.controller);

  _execute(String script) {
    controller.runJavaScript(script);
  }

  void openDialog() {
    _execute("receiveCall()");
  }
}
