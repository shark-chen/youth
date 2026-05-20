import 'package:kellychat/base/base_controller.dart';
import '../../model/knock_record_entity.dart';
import '../beat_record_controller.dart';

/// FileName: beat_record_route_controller
///
/// @Author 谌文
/// @Date 2026/5/20 23:10
///
/// @Description 敲一下记录-请求-controller
extension BeatRecordRouteController on BeatRecordController {
  /// push - 跳转到对应用户详情页
  Future<void> pushUserInfoPage(KnockRecordItems item) async {
    final userId = item.targetUserId;
    if (userId == null) return;
    await Get.toNamed(Routes.userInfoPage, parameters: {
      'userId': userId.toString(),
    });
  }

  /// push - 实际聊天窗口-page-页面
  Future pushChatPage(KnockRecordItems item) async {
    await Get.toNamed(Routes.chatPage, parameters: {
      'userId': item.targetUserId.toString(),
      'niceName': item.targetNickname ?? '',
    });
  }
}