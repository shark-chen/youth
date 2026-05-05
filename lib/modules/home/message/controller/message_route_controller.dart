import 'package:kellychat/modules/home/doing/doing_list/view/invite_together_sheet_widget.dart';

import '../message_controller.dart';
import 'package:kellychat/base/base_controller.dart';

import '../model/message_person_list_entity.dart';

/// FileName: message_route_controller
///
/// @Author 谌文
/// @Date 2026/3/12 23:18
///
/// @Description 消息模块-路由-controller
extension MessageRouteController on MessageController {
  /// mark - push
  ///
  /// 个人信息页面
  Future pushUserInfoPage() async {
    await Get.toNamed(Routes.minePage);
  }

  /// push - 跳转到邀约记录-页面
  Future pushInviteRecordPage() async {
    await Get.toNamed(Routes.inviteRecordPage);
  }

  /// push - 敲一下记录-页面
  Future pushBeatRecordPage() async {
    await Get.toNamed(Routes.beatRecordPage);
  }

  /// push - 实际聊天窗口-page-页面
  Future pushChatPage(MessagePersonListEntity item) async {
    await Get.toNamed(Routes.chatPage, parameters: {
      'userId': item.userId.toString(),
      'niceName': item.nickname ?? '',
      'avatar': item.avatar ?? '',
    });
  }

  /// push - 邀请
  Future<void> pushInviteAlert() async {
    final ctx = Get.context;
    if (ctx == null) return;
    await BottomAlert.alerts(
      ctx,
      isDismissible: true,
      wholeCustomWidget: InviteTogetherSheetWidget(
        inviteCode: '${vm.value.myDoing?.tagId ?? '--'}',
        shareLink:
            'https://images.unsplash.com/photo-1538370965046-79c0d6907d47',
      ),
    );
  }
}
