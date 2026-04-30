import 'package:kellychat/base/base_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'privacy_policy_html.dart';

/// FileName: privacy_policy_controller
///
/// @Description 隐私政策（本地 HTML）
class PrivacyPolicyController extends BaseController {
  WebViewController? webViewController = WebViewController.fromPlatformCreationParams(
    const PlatformWebViewControllerCreationParams(),
  );

  @override
  void onInit() async {
    super.onInit();
    title = '隐私政策';

    webViewController?.setJavaScriptMode(JavaScriptMode.unrestricted);
    final html = buildPrivacyPolicyHtml();
    await webViewController?.loadHtmlString(html);
  }

  @override
  void onClose() {
    try {
      webViewController?.clearCache();
      webViewController = null;
    } catch (_) {}
    super.onClose();
  }
}

