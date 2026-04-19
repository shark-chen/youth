import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youth/modules/routes/app_pages.dart';
import 'package:youth/utils/marco/debug_print.dart';
import 'package:youth/utils/marco/marco.dart';
import 'modules/auxiliary/network_look/view/draggable_net_view.dart';
import 'modules/home/home/utils/tab_switch_utils.dart';
import 'modules/home/home/view/tabs.dart';
import 'tripartite_library/get/app_route_observer.dart';
import 'tripartite_library/notification/event_bus_manager.dart';
import 'tripartite_library/uuid/udid_util.dart';
import 'utils/extension/system_chromes/system_chromes.dart';
import 'utils/lang/translation_service.dart';

/// 主界面
class App extends StatelessWidget with WidgetsBindingObserver {
  const App({Key? key, this.locale}) : super(key: key);

  /// 语种
  final Locale? locale;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BigSeller',
      debugShowCheckedModeBanner: getEnableLog,
      enableLog: getEnableLog,
      defaultTransition: Transition.fade,
      locale: locale ?? TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      translations: TranslationService(),
      smartManagement: SmartManagement.full,
      navigatorObservers: [AppRouteObserver().routeObserver],
      initialRoute: Routes.splash,
      getPages: AppPages.routes(context),
      builder: DraggableNetWidget.init(),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    /// APP生命周期变化
    EventBusManager().fire(state);

    /// 设置应用程序只支持竖屏方向
    if (!isLandscapePad) {
      SystemChromes.setPortraitScreen();
    }
  }

  void testPush(AppLifecycleState state) async {
    try {
      var map = {
        'data':
            '{\"home\":\"order\",\"params\":{\"tab\":\"new\",\"shipProvider\":-2}}'
      };
      if (state == AppLifecycleState.resumed) {
        /// 切换到tab页面
        TabSwitchUtils.switchTab(HomeTabs.hall);
      }
    } catch (_) {}
  }

  @override
  void didChangeLocales(List<Locale>? locales) async {
    /// 🚫 系统语言变化，直接忽略 // 什么都不做
    debugPrint('System locale changed: $locales');
  }
}
