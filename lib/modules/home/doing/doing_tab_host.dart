import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kellychat/modules/home/doing/doing_nav_ids.dart';
import 'package:kellychat/modules/home/doing/doing_page.dart';
import 'package:kellychat/modules/home/doing/doing_list/doing_list_controller.dart';
import 'package:kellychat/modules/home/doing/doing_list/doing_list_page.dart';
import 'package:kellychat/modules/routes/app_pages.dart';

/// FileName: doing_tab_host
///
/// @Author 谌文
/// @Date 2026/4/30
///
/// @Description “正在(Doing)”Tab 内部子路由容器，保证底部 Tab 不丢
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
        switch (name) {
          case _initialRoute:
            return GetPageRoute(
              settings: settings,
              page: () => const DoingPage(),
              transition: Transition.noTransition,
            );
          case Routes.doingListPage:
            return GetPageRoute(
              settings: settings,
              page: () => const DoingListPage(),
              binding: BindingsBuilder(() {
                Get.lazyPut<DoingListController>(
                  () => DoingListController(initialArg: settings.arguments),
                );
              }),
              transition: Transition.downToUp,
            );
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
}

