import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youth/utils/extension/extension.dart';

import '../../base/base_stateless_widget.dart';

/// FileName easy_loading_view
///
/// @Author 谌文
/// @Date 2023/7/13 11:22
///
/// @Description 封装 easy_loading三方库
class BGEasyLoading {
  static Future<void> showWebView(String title) async {
    /// 正则判断是否包含 HTML 标签
    if (title.containsHtmlTag != true) {
      EasyLoading.showToast(title);
      return;
    }
    final controller = WebViewController()
      ..setBackgroundColor(Colors.transparent);
    controller.setJavaScriptMode(JavaScriptMode.disabled);
    String htmlString =
        "<html><body><div style=\"color:#fff;font-size:62px;\">$title</div></body></html>";
    controller.loadHtmlString(htmlString);
    EasyLoading().infoWidget = SizedBox(
      height: 60,
      child: WebViewWidget(controller: controller),
    );
    EasyLoading.showInfo('').then((value) {
      EasyLoading().infoWidget = null;
    });
  }

  static Future<void> showError(String title) async {
    EasyLoading().errorWidget = Image.asset(
        width: 24, height: 24, "assets/image/icons/toast_error@3x.png");
    EasyLoading.showError(title, duration: const Duration(milliseconds: 3000))
        .then((value) {
      EasyLoading().errorWidget = null;
    });
  }
}

class ScanEasyLoading {
  static Future<void> showToast(
    String status, {
    String? scan,
    Duration? duration,
    EasyLoadingToastPosition? toastPosition,
    EasyLoadingMaskType? maskType,
    bool? dismissOnTap,
  }) async {
    if (Strings.isNotEmpty(scan) && status.contains(scan ?? '-+')) {
      await EasyLoading.showToast(status,
          duration: duration, maskType: maskType, dismissOnTap: dismissOnTap);
    } else {
      await EasyLoading.showToast(
          '${LocaleKeys.CurrentScan.tr}:【$scan】\n$status',
          duration: duration,
          maskType: maskType,
          dismissOnTap: dismissOnTap);
    }
  }
}
