import 'package:get/get.dart';
import '../../../../generated/locales.g.dart';
import '../../doing/doing_tab_host.dart';
import '../../hall/hall_page.dart';
import '../../message/message_page.dart';
import '../model/tab_model.dart';

enum HomeTabs { hall, order, blog }

extension HomeTabsExtension on HomeTabs {
  String get name {
    return this.toString().split('.').last;
  }
}

/// 通过字符串获取枚举
HomeTabs stringToHomeTab(String tabString) {
  return HomeTabs.values.firstWhere(
    (tab) => tab.toString().split('.').last == tabString,
    orElse: () => HomeTabs.hall, // 返回 null 如果找不到匹配项
  );
}

enum AuthTabs { login, register, logOut }

enum OrderTabs { newOrder, processing, pickup, canceled, shipped }

/// 通过字符串获取枚举
OrderTabs stringToOrderTabs(String tabString) {
  return {
        '': OrderTabs.newOrder,
        'new': OrderTabs.newOrder,
        'processing': OrderTabs.processing,
        'pickup': OrderTabs.pickup,
        'toPickup': OrderTabs.pickup,
        'In Cancel': OrderTabs.canceled,
        'canceled': OrderTabs.canceled,
        'shipped': OrderTabs.shipped,
        'toShip': OrderTabs.shipped,
      }[tabString] ??
      OrderTabs.newOrder;
}

// ignore: non_constant_identifier_names
Map TabsKey = {
  'main': HomeTabs.hall,
  'order': HomeTabs.order,
  'blog': HomeTabs.blog,
};

/// 首页数据
// ignore: non_constant_identifier_names
List<HomePageModel> HomePages = buildHomePages();

List<HomePageModel> buildHomePages() {
  return  [
    HomePageModel(
      page: HallPage(),
      activeLogo: "assets/image/common/look_someone@3x.png",
      logo: "assets/image/common/look_someone@3x.png",
      name: '找人'.tr,
      introduceTitle: LocaleKeys.businessProcessing.tr,
      introduceContent: LocaleKeys.easilyHandleBusiness.tr,
    ),
    HomePageModel(
      page: DoingTabHost(),
      activeLogo: "assets/image/common/being@3x.png",
      logo: "assets/image/common/being@3x.png",
      name: '正在'.tr,
      introduceTitle: LocaleKeys.quicklyInformation.tr,
      introduceContent: LocaleKeys.masterCommerceIndustry.tr,
    ),
    HomePageModel(
      page: MessagePage(),
      activeLogo: "assets/image/common/message@3x.png",
      logo: "assets/image/common/message@3x.png",
      name: '消息'.tr,
    ),
  ];
}