import 'package:youth/modules/home/doing/model/publish_doing_entity.dart';
import 'package:youth/network/net/entry/doing/doing.dart';
import 'package:youth/network/net/entry/message/message.dart';

import '../message_controller.dart';
import 'package:youth/base/base_controller.dart';

/// FileName: message_request_controller
///
/// @Author 谌文
/// @Date 2026/4/18 11:50
///
/// @Description 消息模块-请求-controller
extension MessageRequestController on MessageController {
  /// mark - request
  ///
  /// GET /api/message/conversations 获取用户会话列表
  Future<void> requestConversations({
    int page = 1,
    int size = 20,
  }) async {
    EasyLoading.show();
    final response = await Net.value<Message>().requestMessageConversations<dynamic>(
      page: page,
      size: size,
    );
    EasyLoading.dismiss();
    if (response.succeed) {
      vm.refresh();
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }

  /// GET /api/status/my-doing
  Future<void> requestMyDoing() async {
    EasyLoading.show();
    final response =
    await Net.value<Doing>().cache<PublishDoingEntity>((value) {
      vm.value.configMyDoing(value);
      vm.refresh();
    }).requestMyDoing<PublishDoingEntity>();
    EasyLoading.dismiss();
    if (response.succeed) {
      vm.value.configMyDoing(response.value);
      vm.refresh();
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }

  /// DELETE /api/status/doing/{statusId}
  /// request - 取消一个正在做的状态
  Future<void> requestDeleteStatusDoing(int statusId) async {
    EasyLoading.show();
    final response = await Net.value<Doing>()
        .requestDeleteStatusDoing<dynamic>(statusId: statusId);
    EasyLoading.dismiss();
    if (response.succeed) {
      EasyLoading.showToast('已删除');
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }
}
