import 'dart:async';
import 'dart:math';
import 'package:kellychat/modules/user/global.dart';
import 'package:kellychat/network/net/net_config/net_config.dart';
import 'package:kellychat/network/reporter/report_util.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../base/base_controller.dart';
import '../../../utils/marco/debug_print.dart';
import '../../../utils/utils/json_utils.dart';
import '../message/token_message.dart';
import '../webWiew_script_config.dart';

class BaseWebViewController extends BaseController {
  var webViewName = "window".obs;
  String? closeScript;

  WebViewController? webViewController =
      WebViewController.fromPlatformCreationParams(
          const PlatformWebViewControllerCreationParams());
  var ready = false.obs;

  /// webView 路径
  String? url;

  /// webView标题
  var progress = 0.0.obs;

  /// webView加载为多少才结束loading = 默认1，
  double? loadingProgress;
  bool? zoomEnabled;
  Key? webKey;

  /// webView打开时执行的js方法
  String? openScript;

  /// webView导航头标题
  RxString webTitle = ''.obs;

  @override
  void onInit() async {
    super.onInit();

    /// 加载cookie
    try {
      await NetConfig.loadCookie();
    } catch (e, _) {
      EasyLoading.showToast('loadCookie.init()$e');
    }

    /// 添加js脚本
    addScript();

    /// 添加监听
    addListen();

    /// 添加webView加载代理
    addDelegate();

    webViewController?.setJavaScriptMode(JavaScriptMode.unrestricted);
    if (zoomEnabled != null) {
      webViewController?.enableZoom(zoomEnabled ?? false);
    }

    /// webView打开时执行的js方法
    if (Strings.isNotEmpty(openScript)) {
      try {
        await webViewController?.runJavaScript(openScript ?? '');
      } catch (e) {
        Get.offAllNamed(Routes.homePage);
      }
    }
  }

  @override
  void onClose() {
    try {
      webViewController?.clearCache();
      webViewController = null;
      super.onClose();
    } catch (_) {}
  }

  /// 设置webView标题
  void setTitle(String? title) {
    this.webTitle.value = title ?? "";
    ready.refresh();
  }

  /// Makes a specific HTTP request and loads the response in the webview.
  Future loadRequest() async {
    if (Strings.isNotEmpty(url)) {
      String argument =
          'source=app&lang=${Global.langValue.value}&random=${Random().nextDouble().toString()}';
      String path =
          (url ?? '').contains("?") ? '$url&$argument' : '$url?$argument';
      await webViewController?.loadRequest(Uri.parse(path));
    }
  }

  /// 添加js脚本
  void addScript() {
    final scripts = WebViewScriptConfig.scriptChannel(this);
    for (var channel in scripts) {
      webViewController?.addJavaScriptChannel(
        channel.name,
        onMessageReceived: channel.handler,
      );
    }
  }

  /// 添加webView加载代理
  void addDelegate() {
    webViewController?.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String url) {
          EasyLoading.show(dismissOnTap: true);
        },
        onProgress: (int progress) {
          this.progress.value = progress / 100.0;
          if (this.progress.value >= (loadingProgress ?? 1.0)) {
            EasyLoading.dismiss();
          }
        },
        onPageFinished: (String url) {
          EasyLoading.dismiss();
          ready.value = true;
        },
        onWebResourceError: (WebResourceError error) {

          isNetworkError.value = true;
          ReportUtil().record(
              "加载网页失败,url:$url,code:${error.errorCode},description:${error.description},type:${error.errorType},failingUrl:${error.url}, apiPath: '$url'");
        },
      ),
    );
  }

  /// 添加监听
  void addListen() {
    Global.actualLogin.listen((p0) async {
      if (p0) {
        webViewController?.reload();
      }
    });
    Global.accessToken.listen(
      (p0) async {
        if (Strings.isNotEmpty(p0)) {
          try {
            await webViewController?.runJavaScript(
                "$webViewName.tokenManage(${TokenMessage(handler: "get", accessToken: p0).toJson()})");
          } catch (ignore) {
            DebugPrint(ignore);
          }
        }
      },
    );
    Global.lang.listen((p0) async {
      try {
        await webViewController?.runJavaScript(
            "$webViewName.getUserLang(${Json.toJson(p0.value)})");
      } catch (ignore) {
        DebugPrint(ignore);
      }
    });
  }

  /// 运行js方法
  Future runScript(String script) async {
    if (Strings.isNotEmpty(script)) {
      try {
        await webViewController?.runJavaScript(script);
      } catch (e) {
        DebugPrint("runScript$e");
      }
    }
  }

  /// 返回键回调
  Future<bool> callBack(String? closeScript) async {
    if (Strings.isEmpty(closeScript) ||
        ready.isFalse ||
        isNetworkError.isTrue) {
      closePage();
      return false;
    }
    try {
      await webViewController?.runJavaScript("window.$closeScript");
    } catch (_) {
      closePage();
      return false;
    }
    return false;
  }
}
