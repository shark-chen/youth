import 'dart:convert';
import 'package:youth/modules/user/global.dart';
import '../webView_script_channel.dart';
import '../message/token_message.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// FileName token_script_channel
///
/// @Author 谌文
/// @Date 2023/6/15 15:06
///
/// @Description js 获取设置token
class TokenScriptChannel extends WebViewScriptChannel {
  TokenScriptChannel(super.name, super.controller);

  @override
  void handler(JavaScriptMessage message) async {
    var res = TokenMessage();
    dynamic dec;
    try {
      dec = jsonDecode(message.message);
      var tokenMessage = TokenMessage.fromMap(dec);
      if (tokenMessage.handler != null) {
        res.handler = tokenMessage.handler;
        switch (tokenMessage.handler) {
          case "get":
            res.accessToken = await Global.getAccessToken;
            break;
          case "set":
            if (tokenMessage.accessToken != null) {
              res.accessToken =
                  await Global.setAccessToken(tokenMessage.accessToken!);
            }
            break;
          default:
            break;
        }
        await controller
            ?.runScript("${controller?.webViewName}.tokenManage(${res.toJson()})");
      }
    } catch (_) {}
  }
}
