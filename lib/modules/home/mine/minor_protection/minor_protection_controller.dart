import 'package:kellychat/base/base_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'minor_protection_html.dart';

/// FileName: minor_protection_controller
///
/// @Description 未成年人个人信息保护规则（本地 HTML）
class MinorProtectionController extends BaseController {
  WebViewController? webViewController = WebViewController.fromPlatformCreationParams(
    const PlatformWebViewControllerCreationParams(),
  );

  @override
  void onInit() async {
    super.onInit();
    title = '未成年人保护规则';

    webViewController?.setJavaScriptMode(JavaScriptMode.unrestricted);
    final html = buildMinorProtectionHtml();
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

