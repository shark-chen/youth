import 'package:kellychat/modules/home/doing/model/publish_doing_entity.dart';
import 'package:kellychat/network/net/entry/doing/doing.dart';
import 'package:kellychat/network/net/entry/message/message.dart';

import '../beat_record/model/beat_item_entity.dart';
import '../invite_record/model/together_list_entity.dart';
import '../message_controller.dart';
import 'package:kellychat/base/base_controller.dart';

import '../model/message_person_list_entity.dart';

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
    final response =
        await Net.value<Message>().caches<MessagePersonListEntity>((values) {
      vm.value.configConversations(values);
      vm.refresh();
    }).requestMessageConversations<MessagePersonListEntity>(
      page: page,
      size: size,
    );
    EasyLoading.dismiss();
    if (response.succeed) {
      vm.value.configConversations(response.values);
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

  /// GET /api/together/my-list
  Future<void> requestTogetherMyList() async {
    EasyLoading.show();
    final response =
    await Net.value<Doing>().caches<TogetherListEntity>((values) {
      vm.value.configTogetherList(values);
      vm.refresh();
    }).requestTogetherMyList<TogetherListEntity>();
    EasyLoading.dismiss();
    if (response.success) {
      vm.value.configTogetherList(response.values);
      vm.refresh();
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }

  /// 收到的敲一下列表 · GET /api/knock/received
  Future<void> requestKnockReceived() async {
    EasyLoading.show();
    final response = await Net.value<Doing>().caches<BeatItemEntity>((values) {
      vm.value.configBeatItemList(values);
      vm.refresh();
    }).requestKnockReceived<BeatItemEntity>();
    EasyLoading.dismiss();
    if (response.succeed) {
      vm.value.configBeatItemList(response.values);
      vm.refresh();
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }
}
