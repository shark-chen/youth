import 'package:youth/modules/home/home/view/tabs.dart';

import 'package:youth/modules/login/login/model/reLogin_account_entity.dart';

import 'package:youth/widget/center_alert/center_alert.dart';

import '../mine_controller.dart';
import '../../../../base/base_controller.dart';

/// FileName: mine_route_controller
///
/// @Author 谌文
/// @Date 2026/1/22 18:58
///
/// @Description 我的页面路由
extension MineRouteController on MineController {
  /// MARK - PUSH
  ///
  /// push - 跳转到系统设置页面
  Future pushSystemSetPage() async {
    await Get.toNamed(Routes.settings);
  }

  /// push - 跳转联系我们页面
  Future pushContactWayPage() async {
    await Get.toNamed(Routes.contactWayPage);
  }

  /// push - 跳转到店铺授权页面
  Future pushShopAuthPage() async {
    List<String> userRights = await UserCenter().requestUserRights();
    if (userRights.contains("others:integrations")) {
      await AppRouter.toNamed(Routes.shopAuth);
    } else {
      EasyLoading.showToast(LocaleKeys.ContactAccountntegrations.tr);
    }
  }




}
