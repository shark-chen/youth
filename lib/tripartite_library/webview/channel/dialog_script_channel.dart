import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../widget/alert/custom_alert.dart';
import '../../../utils/marco/debug_print.dart';
import '../webView_script_channel.dart';

/// FileName dialog_script_channel
///
/// @Author 谌文
/// @Date 2023/6/15 15:06
///
/// @Description js 控制 弹框
class DialogScriptChannel extends WebViewScriptChannel {
  DialogScriptChannel(super.name, super.controller);

  @override
  void handler(JavaScriptMessage message) {
    DialogMessageModel? dialog;
    try {
      dialog = DialogMessageModel.fromJson(jsonDecode(message.message));
      showCustomAlert(dialog, controller: controller);
    } catch (e) {
      DebugPrint(e);
    }
  }
}
