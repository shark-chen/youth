import 'package:youth/config/environment_config/app_config.dart';
import 'package:youth/tripartite_library/webview/webview_page/base_webview_binding.dart';
import '../../tripartite_library/webview/webview_page/base_webview_page.dart';
import '../modules.dart';

part 'app_routes.dart';

/// 路由
class AppPages {
  static const INITIAL = Routes.splash;

  /// 路由
  static routes(BuildContext context) {
    return _routes;
  }

  /// 普通路由
  static final _routes = [
    /// 启动页
    GetPage(
        name: Routes.splash,
        page: () => LaunchPage(),
        binding: LaunchBinding(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.homePage,
        page: () => HomePage(),
        binding: HomeBinding(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.login,
        page: () => LoginPage(),
        binding: LoginBinding(),
        transition: Transition.noTransition),

    GetPage(
        name: Routes.webView,
        page: () => BaseWebViewPage(
              url: AppConfig.getUrl(Get.parameters["url"]!),
              showTitle: "true" == Get.parameters["showTitle"],
              title: Get.parameters["title"],
              closeScript: Get.parameters["closeScript"],
              webViewName: Get.parameters["webviewName"] ?? "window",
              openScript: Get.parameters["openScript"],
            ),
        binding: BaseWebViewBinding(),
        transition: Transition.rightToLeft),
    GetPage(
      name: Routes.backWebView,
      page: () => BaseWebViewPage(
        url: AppConfig.getUrl(Get.parameters["url"]!),
        showTitle: "true" == Get.parameters["showTitle"],
        title: Get.parameters["title"],
        closeScript: Get.parameters["closeScript"],
        webViewName: Get.parameters["webviewName"] ?? "window",
        openScript: Get.parameters["openScript"],
      ),
      binding: BaseWebViewBinding(),
      transition: Transition.rightToLeft,
    ),

    /// 查看网络数据页面
    GetPage(
      name: Routes.networkLookPage,
      page: () => NetworkLookPage(),
      binding: NetworkLookBinding(),
      transition: Transition.rightToLeft,
    ),

    /// 正在做的清单 - 页面
    GetPage(
      name: Routes.doingListPage,
      page: () => DoingListPage(),
      binding: DoingListBinding(),
      transition: Transition.rightToLeft,
    ),

    /// 邀约记录-页面
    GetPage(
      name: Routes.inviteRecordPage,
      page: () => InviteRecordPage(),
      binding: InviteRecordBinding(),
      transition: Transition.rightToLeft,
    ),

    /// 用户信息模块-页面
    GetPage(
      name: Routes.beatRecordPage,
      page: () => BeatRecordPage(),
      binding: BeatRecordBinding(),
      transition: Transition.rightToLeft,
    ),

    /// 实际聊天窗口-page-页面
    GetPage(
      name: Routes.chatPage,
      page: () => ChatPage(),
      binding: ChatBinding(),
      transition: Transition.rightToLeft,
    ),

    /// 性别选择-页面-page
    GetPage(
      name: Routes.sexSelectPage,
      page: () => SexSelectPage(),
      binding: SexSelectBinding(),
      transition: Transition.rightToLeft,
    ),

    /// 生日选择-页面-page
    GetPage(
      name: Routes.birthdaySelectPage,
      page: () => BirthdaySelectPage(),
      binding: BirthdaySelectBinding(),
      transition: Transition.rightToLeft,
    ),

    /// 城市选择-页面-page
    GetPage(
      name: Routes.citySelectPage,
      page: () => CitySelectPage(),
      binding: CitySelectBinding(),
      transition: Transition.rightToLeft,
    ),

    /// 城市设置-页面-page
    GetPage(
      name: Routes.citySetPage,
      page: () => CitySetPage(),
      binding: CitySetBinding(),
      transition: Transition.rightToLeft,
    ),

    /// 个人中心
    GetPage(
      name: Routes.userInfoPage,
      page: () => UserInfoPage(),
      binding: UserInfoBinding(),
      transition: Transition.rightToLeft,
    ),

    /// 我的
    GetPage(
      name: Routes.minePage,
      page: () => const MinePage(),
      binding: MineBinding(),
      transition: Transition.rightToLeft,
    ),

    /// 关于 KellyChat
    GetPage(
      name: Routes.aboutKellyChatPage,
      page: () => const AboutKellyChatPage(),
      binding: AboutKellyChatBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
