import 'package:kellychat/base/base_controller.dart';
import '../chat_controller.dart';

/// FileName: chat_route_controller
///
/// @Author 谌文
/// @Date 2026/5/4 22:05
///
/// @Description 聊天-路由- controller
extension ChatRouteController on ChatController {
  /// push - 他人资料页（须有效 [userId]）
  Future<void> pushProfile({required String userId}) async {
    if (userId.isEmpty) return;
    await Get.toNamed(Routes.userInfoPage, parameters: {
      'userId': userId,
    });
  }

  /// push - 本人资料页（不传 userId，页面内默认展示当前账号）
  Future<void> pushMyProfile() async {
    await Get.toNamed(Routes.userInfoPage);
  }
}
