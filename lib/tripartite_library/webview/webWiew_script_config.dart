import 'channel/camera_script_channel.dart';
import 'channel/camera_view_script_channel.dart';
import 'channel/dialog_script_channel.dart';
import 'channel/global_script_channel.dart';
import 'channel/reload_script_channel.dart';

import 'channel/token_script_channel.dart';
import 'webView_script_channel.dart';
import 'webview_page/base_web_view_controller.dart';

class WebViewScriptConfig {
  static List<WebViewScriptChannel> scriptChannel(
    BaseWebViewController controller,
  ) {
    return [
      CameraScriptChannel('Camera', controller),
      CameraViewScriptChannel('CameraView', controller),
      DialogScriptChannel('PostDialog', controller),
      GlobalScriptChannel('Global', controller),
      ReloadScriptChannel('Reload', controller),
      TokenScriptChannel('TokenManage', controller),
    ];
  }
}
