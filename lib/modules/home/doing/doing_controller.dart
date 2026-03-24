import 'dart:async';
import 'package:youth/base/base_controller.dart';
import 'package:youth/tripartite_library/webview/webview_page/base_web_view_controller.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../config/environment_config/app_config.dart';
import '../../../tripartite_library/notification/event_bus_manager.dart';
import '../../../utils/utils/language/lang_value.dart';
import '../home/view/tabs.dart';
import 'model/blog_url_model.dart';
import 'package:get/get.dart';

/// FileName blog_controller
///
/// @Author 谌文
/// @Date 2023/8/24 11:18
///
/// @Description 博客控制器
class DoingController extends BaseController {
  /// blog 地址
  var blogUrl = AppConfig.blogUrl;

  /// 刷新state
  VoidCallback? stateCallback;

  /// 需要使用如下方式才能实现刷新webView
  /// 1. final Completer<WebViewController> controllerCompleter = Completer<WebViewController>();
  /// WebView对象onWebViewCreated方法后: controllerCompleter.complete(webViewController)
  /// 之后刷新webView通过  controller.controllerCompleter.future.loadUrl(url), 来刷新，但历史webView写的导致此方式不兼容不生效
  /// 2. 方式2：给webView一个key，刷新URL时后创新赋值新key,这样, webView就会重新加载创建了
  final Completer<WebViewController> controllerCompleter =
      Completer<WebViewController>();

  @override
  void onInit() async {
    super.onInit();

    Get.put<BaseWebViewController>(BaseWebViewController(), tag: 'blog');

    /// 其他H5页面点击可跳转到blog页面并加载想要加载的url
    EventBusManager().listen<BlogUrlModel>(this, (event) {
      blogUrl = event.url ?? AppConfig.blogUrl;
      stateCallback?.call();
    });

    /// 有状态widget,接受到语言变化的通知, 刷新UI
    EventBusManager().listen<LangValue>(this, (event) {
      blogUrl = AppConfig.blogUrl;
      stateCallback?.call();
    });

    /// 点击tab
    EventBusManager().listen<HomeTabs>(this, (event) {
      if (event == HomeTabs.blog) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
      }
    });
  }

  /// push-正在做的清单-页面
  Future pushDoingListPage() async {
    await Get.toNamed(Routes.doingListPage);
  }
}
