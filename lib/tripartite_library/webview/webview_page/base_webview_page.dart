import 'package:kellychat/base/base_page.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'base_web_view_controller.dart';

class BaseWebViewPage extends BasePage<BaseWebViewController> {
  /// webView 路径
  final String? url;
  final bool showTitle;

  /// webView 前缀名字
  final String webViewName;

  /// webView打开时执行的js方法
  final String? openScript;

  final bool? zoomEnabled;

  /// 关闭时执行的js
  final String? closeScript;

  /// 是否需要loading
  final bool? needLoading;

  /// 是否需要进度条 ，默认不展示
  final bool? needLinearProgress;

  /// webView加载为多少才结束loading = 默认1，
  final double? loadingProgress;

  /// 是否开启自动 webView加载为多少才结束loading = 默认关闭，
  final bool? autoLoading;

  /// webView key
  final Key? webKey;

  /// If true the [body] and the scaffold's floating widgets should size
  /// themselves to avoid the onscreen keyboard whose height is defined by the
  /// ambient [MediaQuery]'s [MediaQueryData.viewInsets] `bottom` property.
  ///
  /// For example, if there is an onscreen keyboard displayed above the
  /// scaffold, the body can be resized to avoid overlapping the keyboard, which
  /// prevents widgets inside the body from being obscured by the keyboard.
  ///
  /// Defaults to true.
  final bool? resizeToAvoidBottomInset;

  BaseWebViewPage({
    Key? key,
    this.url,
    required this.showTitle,
    String? title,
    this.closeScript,
    this.openScript,
    this.zoomEnabled,
    this.needLoading,
    this.needLinearProgress = false,
    this.loadingProgress = 1.0,
    this.autoLoading = false,
    this.webKey,
    this.resizeToAvoidBottomInset = true,
    this.webViewName = "window",
  }) : super(key: key) {
    controller.title = title;
    controller.closeScript = closeScript;
    controller.url = url;
    controller.loadingProgress = loadingProgress;
    controller.zoomEnabled = zoomEnabled;
    controller.webKey = webKey;
    controller.openScript = openScript;
    controller.webTitle.value = title ?? '';

    /// Makes a specific HTTP request and loads the response in the webview.
    controller.loadRequest();
  }

  @override
  Widget build(BuildContext context) {
    final widget = Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: ThemeColor.themeColor,
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          /// webView
          _buildWebView(),

          /// 是否需要顶部进度条
          (needLinearProgress ?? false)
              ? Obx(
                  () => LinearProgressIndicator(
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blue),
                    minHeight: 1.5,
                    value: controller.progress.value,
                  ),
                )
              : Container(),
        ],
      ),
    );
    return GetPlatform.isIOS
        ? widget
        : WillPopScope(
            onWillPop: () async =>
                await controller.callBack(controller.closeScript),
            child: widget,
          );
  }

  /// 导航头
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return (showTitle)
        ? AppBarKit.appBar(
            '',
            customTitle: Obx(() =>
                Text(controller.webTitle.value, textAlign: TextAlign.center)),
            backTap: () async {
              controller.callBack(closeScript);
            },
          )
        : PreferredSize(
            preferredSize: Size.fromHeight(
                MediaQueryData.fromView(View.of(context)).padding.top),
            child: const SafeArea(top: true, child: Offstage()),
          );
  }

  /// webView
  Widget _buildWebView() {
    if (controller.webViewController != null) {
      return WebViewWidget(
        key: webKey,
        controller: controller.webViewController!,
      );
    }
    return Container(color: ThemeColor.themeColor);
  }
}
