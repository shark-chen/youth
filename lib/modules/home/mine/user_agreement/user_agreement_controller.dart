import 'package:kellychat/base/base_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'user_agreement_html.dart';

/// FileName: user_agreement_controller
///
/// @Author 谌文
/// @Date 2026/4/30
///
/// @Description 用户服务协议（本地 HTML）
class UserAgreementController extends BaseController {
  WebViewController? webViewController =
      WebViewController.fromPlatformCreationParams(
          const PlatformWebViewControllerCreationParams());

  @override
  void onInit() async {
    super.onInit();
    title = '用户协议';

    webViewController?.setJavaScriptMode(JavaScriptMode.unrestricted);
    final html = buildUserAgreementHtml();
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

