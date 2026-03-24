import '../message_controller.dart';
import 'package:youth/base/base_controller.dart';

/// FileName: message_route_controller
///
/// @Author 谌文
/// @Date 2026/3/12 23:18
///
/// @Description 消息模块-路由-controller
extension MessageRouteController on MessageController {
  /// push - 跳转到邀约记录-页面
  Future pushInviteRecordPage() async {
    await Get.toNamed(Routes.inviteRecordPage);
  }

  /// push - 敲一下记录-页面
  Future pushBeatRecordPage() async {
    await Get.toNamed(Routes.beatRecordPage);
  }

  /// push - 实际聊天窗口-page-页面
  Future pushChatPage() async {
    await Get.toNamed(Routes.chatPage);
  }
}
