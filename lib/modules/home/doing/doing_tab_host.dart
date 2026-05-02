import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kellychat/modules/home/doing/model/doing_nav_ids.dart';
import 'package:kellychat/modules/home/doing/doing_page.dart';
import 'package:kellychat/modules/home/doing/doing_list/doing_list_controller.dart';
import 'package:kellychat/modules/home/doing/doing_list/doing_list_page.dart';
import 'package:kellychat/modules/routes/app_pages.dart';
import 'package:kellychat/modules/user/user_center/my_doing/my_doing.dart';
import 'doing_controller.dart';
import 'model/doing_hot_tags_entity.dart';

/// FileName: doing_tab_host
///
/// @Author 谌文
/// @Date 2026/4/30
///
/// @Description 正在页面- tab下 正在做页面，还是 做的事情中页面
/// “正在(Doing)”Tab 内部子路由容器，保证底部 Tab 不丢
class DoingTabHost extends StatefulWidget {
  const DoingTabHost({super.key});

  @override
  State<DoingTabHost> createState() => _DoingTabHostState();
}

class _DoingTabHostState extends State<DoingTabHost>
    with AutomaticKeepAliveClientMixin {
  static const String _initialRoute = '/';

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Navigator(
      key: Get.nestedKey(doingNavigatorId),
      restorationScopeId: 'doing_tab_nav',
      initialRoute: _initialRoute,
      onGenerateRoute: (settings) {
        final name = settings.name ?? _initialRoute;
        final doing = MyDoing().doing;
        switch (name) {
          case _initialRoute:
            return doing == null
                ? getInitialDoingPage(settings)
                : getInitialDoingListPage(settings);
          case Routes.doingListPage:
            return getDoingListPage(settings);
          case Routes.doingPage:
            return getDoingPage(settings);
          default:
            return GetPageRoute(
              settings: settings,
              page: () => const SizedBox.shrink(),
              transition: Transition.noTransition,
            );
        }
      },
    );
  }

  /// 初始化-正在-tab
  GetPageRoute getInitialDoingPage(RouteSettings settings) {
    return GetPageRoute(
      settings: settings,
      page: () => const DoingPage(),
      transition: Transition.noTransition,
    );
  }

  /// 初始化-我正在做的事情-tab
  GetPageRoute getInitialDoingListPage(RouteSettings settings) {
    return GetPageRoute(
      settings: settings,
      page: () => const DoingListPage(),
      transition: Transition.noTransition,
    );
  }

  /// 正在页面
  GetPageRoute getDoingPage(RouteSettings settings) {
    return GetPageRoute(
      settings: settings,
      page: () => const DoingPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<DoingController>(
          () => DoingController(),
        );
      }),
      transition: Transition.downToUp,
    );
  }

  /// 正在做的事情 - 页面
  GetPageRoute getDoingListPage(RouteSettings settings) {
    return GetPageRoute(
      settings: settings,
      page: () => const DoingListPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<DoingListController>(
          () => DoingListController(
              value: settings.arguments as DoingHotTagsEntity),
        );
      }),
      transition: Transition.downToUp,
    );
  }
}
