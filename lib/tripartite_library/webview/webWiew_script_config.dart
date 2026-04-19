import 'channel/dialog_script_channel.dart';
import 'channel/global_script_channel.dart';
import 'channel/reload_script_channel.dart';
import 'webView_script_channel.dart';
import 'webview_page/base_web_view_controller.dart';

class WebViewScriptConfig {
  static List<WebViewScriptChannel> scriptChannel(
    BaseWebViewController controller,
  ) {
    return [
      DialogScriptChannel('PostDialog', controller),
      GlobalScriptChannel('Global', controller),
      ReloadScriptChannel('Reload', controller),
    ];
  }
}
