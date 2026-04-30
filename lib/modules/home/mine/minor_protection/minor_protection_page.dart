import 'package:kellychat/base/base_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'minor_protection_controller.dart';

/// FileName: minor_protection_page
///
/// @Description 未成年人个人信息保护规则-page（本地 HTML）
class MinorProtectionPage extends BasePage<MinorProtectionController> {
  const MinorProtectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.themeColor,
      appBar: AppBarKit.appBar(
        controller.title ?? '未成年人保护规则',
        backgroundColor: ThemeColor.themeColor,
        elevation: 0,
        textColor: ThemeColor.whiteColor,
        backTap: controller.closePage,
      ),
      body: controller.webViewController == null
          ? Container(color: ThemeColor.themeColor)
          : WebViewWidget(controller: controller.webViewController!),
    );
  }
}

