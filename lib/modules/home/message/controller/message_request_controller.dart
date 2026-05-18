import 'package:kellychat/modules/home/doing/model/publish_doing_entity.dart';
import 'package:kellychat/modules/user/user_center/my_doing/my_doing.dart';
import 'package:kellychat/network/net/entry/doing/doing.dart';
import 'package:kellychat/network/net/entry/message/message.dart';

import '../beat_record/model/beat_item_entity.dart';
import '../invite_record/model/together_list_entity.dart';
import '../message_controller.dart';
import 'package:kellychat/base/base_controller.dart';

import '../model/knock_record_entity.dart';
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
    bool cache = false,
    bool? showLoad = true,
  }) async {
    if (true == showLoad) EasyLoading.show();
    final response =
        await Net.value<Message>().caches<MessagePersonListEntity>((values) {
      vm.value.configConversations(values, refresh: pageNo == 1);
      vm.refresh();
    }, cache: cache).requestMessageConversations<MessagePersonListEntity>(
      page: pageNo,
      size: pageSize,
    );
    if (true == showLoad) EasyLoading.dismiss();
    if (response.succeed) {
      vm.value.configConversations(response.values, refresh: pageNo == 1);
      vm.refresh();
    } else {
      if (true == showLoad) EasyLoading.showToast(response.msg ?? '');
    }
  }

  /// DELETE /api/message/conversations/{conversationId}
  Future<bool> requestDeleteConversation({
    required int conversationId,
    bool showLoad = true,
  }) async {
    if (showLoad) EasyLoading.show();
    final response = await Net.value<Message>()
        .requestDeleteConversation<dynamic>(conversationId: conversationId);
    if (showLoad) EasyLoading.dismiss();
    if (response.succeed) {
      EasyLoading.showToast(
        response.msg?.isNotEmpty == true ? response.msg! : '已删除',
      );
      return true;
    }
    EasyLoading.showToast(response.msg ?? '');
    return false;
  }

  /// GET /api/status/my-doing
  Future<void> requestMyDoing({
    bool? showLoad = true,
  }) async {
    if (true == showLoad) EasyLoading.show();
    final response =
        await Net.value<Doing>().cache<PublishDoingEntity>((value) {
      vm.value.configMyDoing(value);
      vm.refresh();
    }).requestMyDoing<PublishDoingEntity>();
    if (true == showLoad) EasyLoading.dismiss();
    if (response.succeed) {
      vm.value.configMyDoing(response.value);
      MyDoing().configDoing(response.value);
      vm.refresh();
    } else if (response.code == 200) {
      vm.value.configMyDoing(null);
      MyDoing().configDoing(null);
      vm.refresh();
    } else {
      if (true == showLoad) EasyLoading.showToast(response.msg ?? '');
    }
  }

  /// DELETE /api/status/doing/{statusId}
  /// request - 取消一个正在做的状态
  Future<void> requestDeleteStatusDoing(
    int statusId, {
    bool? showLoad = true,
  }) async {
    if (true == showLoad) EasyLoading.show();
    final response = await Net.value<Doing>()
        .requestDeleteStatusDoing<dynamic>(statusId: statusId);
    if (true == showLoad) EasyLoading.dismiss();
    if (response.succeed) {
      EasyLoading.showToast('已删除');
    } else {
      if (true == showLoad) EasyLoading.showToast(response.msg ?? '');
    }
  }

  /// GET /api/together/my-list
  Future<void> requestTogetherMyList({
    bool? showLoad = true,
  }) async {
    if (true == showLoad) EasyLoading.show();
    final response =
        await Net.value<Doing>().caches<TogetherListEntity>((values) {
      vm.value.configTogetherList(values);
      vm.refresh();
    }).requestTogetherMyList<TogetherListEntity>();
    if (true == showLoad) EasyLoading.dismiss();
    if (response.success) {
      vm.value.configTogetherList(response.values);
      vm.refresh();
    } else {
      if (true == showLoad) EasyLoading.showToast(response.msg ?? '');
    }
  }

  /// 收到的敲一下列表 · GET /api/knock/received
  Future<void> requestKnockReceived({
    bool? showLoad = true,
  }) async {
    if (true == showLoad) EasyLoading.show();
    final response = await Net.value<Doing>().caches<BeatItemEntity>((values) {
      vm.value.configBeatItemList(values);
      vm.refresh();
    }).requestKnockReceived<BeatItemEntity>();
    if (true == showLoad) EasyLoading.dismiss();
    if (response.succeed) {
      vm.value.configBeatItemList(response.values);
      vm.refresh();
    } else {
      if (true == showLoad) EasyLoading.showToast(response.msg ?? '');
    }
  }

  /// request - 敲一下收件箱
  /// 敲一下 inbox · GET /api/knock/inbox
  Future<void> requestKnockInbox({
    bool? showLoad = true,
  }) async {
    if (true == showLoad) EasyLoading.show();
    final response = await Net.value<Doing>().cache<KnockRecordEntity>((value) {
      if (value == null) return;
      vm.value.knockRecordEntity = value;
      vm.refresh();
    }).requestKnockInbox<KnockRecordEntity>();
    if (true == showLoad) EasyLoading.dismiss();
    if (response.succeed) {
      vm.value.knockRecordEntity = response.value;
      vm.refresh();
    } else {
      if (true == showLoad) EasyLoading.showToast(response.msg ?? '');
    }
  }
}
