import 'dart:convert';
import 'package:youth/network/net/net_config/net_config.dart';
import 'package:youth/tripartite_library/webview/jsmethod.dart';
import 'package:youth/utils/utils/json_utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../modules/user/user_center/user_center.dart';
import '../../../../modules/user/user_center/user_permissions/user_rights.dart';
import '../../../generated/locales.g.dart';
import '../../../modules/user/global.dart';
import '../webView_script_channel.dart';
import 'package:get/get.dart';

/// FileName global_script_channel
///
/// @Author 谌文
/// @Date 2023/6/15 15:06
///
/// @Description js 控制 各种东西
class GlobalScriptChannel extends WebViewScriptChannel {
  GlobalScriptChannel(super.name, super.controller);

  @override
  void handler(JavaScriptMessage message) async {
    String res = "";
    final method = getPathBeforeQuery(message.message);
    switch (method) {
      case "getUserLang":
        res = Json.toJson(Global.langValue.value);
        break;
      case "permissions":
        res = jsonEncode(UserRights().userRights);
        break;
      case "isMaster":
        res = jsonEncode(UserCenter().masterAccount);
        break;
      case "getUserInfo":

        /// todo
        // res = Json.toJson(Global.userInfo?.toSqlMap());
        break;
      case "messageInfo":
        res = "";
        break;
      case "loginOut":
        break;
      case "accessToken":
        var accessToken = await Global.getAccessToken;
        res = accessToken ?? "";
        break;
      case "userCookie":
        res = Global.cookies;
        break;
      case "setCookie":
        await NetConfig.loadCookie().then((value) async {
          await controller?.runScript(
              "${controller?.webViewName}.${message.message}($res)");
        });
        return;
      case "getVersion":
        // res = Json.toJson((await packageInfo).version);
        break;
      case "openDialog":
        if (controller?.webViewController != null) {
          JsMethod((controller?.webViewController)!).openDialog();
        }
        return;
      case "getScanType":
        break;
      case "setScanType":
        break;
      case "loadingDismiss":
        EasyLoading.dismiss();
        return;

      /// 拷贝
      case '/clipboard':
        {
          EasyLoading.showToast(LocaleKeys.copySuccessfully.tr);
          Clipboard.setData(ClipboardData(
              text: url(message.message) ??
                  message.message.replaceAll('/clipboard?clipboardUrl=', '')));
        }
        return;
      default:
        return;
    }
    await controller
        ?.runScript("${controller?.webViewName}.${message.message}($res)");
  }
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
