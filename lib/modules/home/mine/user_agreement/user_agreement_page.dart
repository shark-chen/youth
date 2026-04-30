import 'package:kellychat/base/base_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'user_agreement_controller.dart';

/// FileName: user_agreement_page
///
/// @Author 谌文
/// @Date 2026/4/30
///
/// @Description 用户服务协议-page（本地 HTML）
class UserAgreementPage extends BasePage<UserAgreementController> {
  const UserAgreementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.themeColor,
      appBar: AppBarKit.appBar(
        controller.title ?? '用户协议',
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

