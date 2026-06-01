import 'package:flutter/widgets.dart';
import 'package:kellychat/base/base_controller.dart';
import 'package:kellychat/modules/user/user_center/my_doing/my_doing.dart';
import '../doing_controller.dart';
import '../model/doing_nav_ids.dart';
import '../model/doing_hot_tags_entity.dart';
import '../model/doing_present_hot_tag_entity.dart';

/// FileName: doing_route_controller
///
/// @Author 谌文
/// @Date 2026/5/2 10:48
///
/// @Description
extension DoingRouteController on DoingController {
  /// 正在 Tab 嵌套栈顶是否为 DoingListPage
  bool get isDoingListPageShowing {
    final nav = Get.nestedKey(doingNavigatorId)?.currentState;
    if (nav == null) return false;

    Route<dynamic>? topRoute;
    nav.popUntil((route) {
      topRoute = route;
      return true;
    });
    final route = topRoute;
    if (route == null) return false;

    final name = route.settings.name;
    if (name == Routes.doingListPage) return true;
    // 初始路由 `/` 且已有正在做时，栈顶也是 DoingListPage
    return (name == null || name == '/') && MyDoing().doing != null;
  }

  /// mark - push
  ///
  /// push - 正在做的清单-页面
  Future pushDoingListPage(DoingPresentHotTagEntity tag) async {
    if (canClosePage) {
      closePage();
    } else {
      await Get.toNamed(
        Routes.doingListPage,
        arguments: tag,
        id: doingNavigatorId,
      );
    }
  }

  /// push - 个人信息页面
  Future pushUserInfoPage() async {
    await Get.toNamed(Routes.minePage);
  }
}
