import 'package:kellychat/base/base_controller.dart';
import '../doing_controller.dart';
import '../model/doing_nav_ids.dart';
import '../model/doing_hot_tags_entity.dart';

/// FileName: doing_route_controller
///
/// @Author 谌文
/// @Date 2026/5/2 10:48
///
/// @Description
extension DoingRouteController on DoingController {
  /// mark - push
  ///
  /// push-正在做的清单-页面
  Future pushDoingListPage(DoingHotTagsEntity tag) async {
    await Get.toNamed(
      Routes.doingListPage,
      arguments: tag,
      id: doingNavigatorId,
    );
  }


  /// 个人信息页面
  Future pushUserInfoPage() async {
    await Get.toNamed(Routes.minePage);
  }
}