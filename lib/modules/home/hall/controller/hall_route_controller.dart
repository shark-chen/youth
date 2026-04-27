import '../hall_controller.dart';
import 'package:kellychat/base/base_controller.dart';
import '../model/smart_match_people_entity.dart';

/// FileName: hall_route_controller
///
/// @Author 谌文
/// @Date 2026/4/26 13:04
///
/// @Description 首页-request-控制器-controller
extension HallRouteController on HallController {
  /// mark - push
  ///
  /// 个人信息页面
  Future pushUserInfoPage() async {
    await Get.toNamed(Routes.minePage);
  }

  /// push - 个人信息页面
  Future<void> pushProfile({required String userId}) async {
    await Get.toNamed(Routes.userInfoPage, parameters: {
      'userId': userId,
    });
  }

  /// push-性别选择-页面-page
  Future pushSexSelectPage() async {
    await Get.toNamed(Routes.sexSelectPage);
  }

  /// push - 实际聊天窗口-page-页面
  Future pushChatPage(SmartMatchPeopleList friend) async {
    await Get.toNamed(Routes.chatPage);
  }
}
