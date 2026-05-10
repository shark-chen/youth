import 'package:kellychat/modules/home/doing/model/doing_hot_tags_entity.dart';
import 'package:kellychat/network/net/entry/doing/doing.dart';
import '../../model/publish_doing_entity.dart';
import '../doing_list_controller.dart';
import 'package:kellychat/base/base_controller.dart';
import '../model/doing_list_entity.dart';
import '../model/invite_friend_entity.dart';

/// FileName: doing_list_request_controller
///
/// @Author 谌文
/// @Date 2026/4/16 21:28
///
/// @Description
extension DoingListRequestController on DoingListController {
  /// mark - request
  ///
  /// request - 我正在做的事情G
  Future<void> requestMyDoing() async {
    EasyLoading.show();
    final response =
        await Net.value<Doing>().cache<PublishDoingEntity>((value) {
      if (value == null) return;
      vm.value.configMyDoing(value);
    }).requestMyDoing<PublishDoingEntity>();
    EasyLoading.dismiss();
    if (response.succeed) {
      vm.value.configMyDoing(response.value);
      vm.refresh();
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }

  /// request - 取消一个正在做的状态
  Future<bool> requestDeleteStatusDoing(int statusId) async {
    EasyLoading.show();
    final response = await Net.value<Doing>()
        .requestDeleteStatusDoing<dynamic>(statusId: statusId);
    EasyLoading.dismiss();
    if (response.code == 200) {
      EasyLoading.showToast('已删除');
      return true;
    } else if (response.code == 50000) {
      EasyLoading.showToast(response.msg ?? '');
      return true;
    } else {
      EasyLoading.showToast(response.msg ?? '');
      return false;
    }
  }

  /// request - 获取当前热门的正在做标签列表
  Future requestHotTags() async {
    EasyLoading.show();
    var response =
    await Net.value<Doing>().requestHotTags<DoingHotTagsEntity>(limit: 20);
    EasyLoading.dismiss();
    if (response.succeed) {
      vm.value.configHotTags(response.values);
      vm.refresh();
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }

  /// request - 获取正在做某个标签的用户列表
  Future<void> requestStatusDoingByTagId(int tagId) async {
    EasyLoading.show();
    final response = await Net.value<Doing>()
        .requestStatusDoing<DoingListEntity>(tagId: tagId);
    EasyLoading.dismiss();
    if (response.succeed) {
      /// 配置正在做的事情数据
      vm.value.configDoingListEntity(response.value);
      vm.refresh();
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }

  /// 发布热门标签为「我正在做」（列表空态里点加号，与 Doing 页选标签一致）
  Future<void> requestPublishDoingFromHotTag(DoingHotTagsEntity tag) async {
    if (Strings.isEmpty(tag.tagName)) return;
    EasyLoading.show();
    final response =
        await Net.value<Doing>().requestPostStatusDoing<PublishDoingEntity>(
      tagName: tag.tagName ?? '',
    );
    EasyLoading.dismiss();
    if (response.succeed && response.value != null) {
      EventBusManager().fire(response.value!);
      EasyLoading.showToast('发布成功');
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }

  /// request - 向某个用户发送敲一下
  Future<void> requestKnockSend({
    required int toUserId,
    int? tagId,
  }) async {
    EasyLoading.show();
    final response = await Net.value<Doing>().requestKnockSend<dynamic>(
      toUserId: toUserId,
      tagId: tagId,
    );
    EasyLoading.dismiss();
    if (response.succeed) {
      EasyLoading.showToast('已发送');
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }

  /// request - 发送邀约
  Future<void> requestInvitationSend({
    required int toUserId,
    int invitationType = 1,
    required int tagId,
    String message = '',
  }) async {
    EasyLoading.show();
    final response = await Net.value<Doing>().requestInvitationSend<dynamic>(
      toUserId: toUserId,
      invitationType: invitationType,
      tagId: tagId,
      message: message,
    );
    EasyLoading.dismiss();
    if (response.succeed) {
      EasyLoading.showToast('已发送');
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }

  /// request -  生成邀约码 · POST /api/invitation/generate-code
  /// request body: inviteChannel, invitationType(必传), tagId(必传), message
  /// invitationType: 邀约类型：1-一起做某事
  Future<InviteFriendEntity?> requestInvitationGenerateCode({
    int inviteChannel = 0,
    required int invitationType,
    required int tagId,
    String message = '',
  }) async {
    EasyLoading.show();
    final response = await Net.value<Doing>()
        .requestInvitationGenerateCode<InviteFriendEntity>(
      inviteChannel: inviteChannel,
      invitationType: invitationType,
      tagId: tagId,
      message: message,
    );
    EasyLoading.dismiss();
    if (response.succeed) {
      return response.value;
    } else {
      EasyLoading.showToast(response.msg ?? '');
      return null;
    }
  }

  /// 发起一起做活动
  Future<void> requestTogetherCreate({String? tagName}) async {
    final name = (tagName ?? vm.value.activityTitle).trim();
    if (name.isEmpty) {
      EasyLoading.showToast('暂无活动标签');
      return;
    }
    EasyLoading.show();
    final response =
        await Net.value<Doing>().requestTogetherCreate<dynamic>(tagName: name);
    EasyLoading.dismiss();
    if (response.succeed) {
      EasyLoading.showToast('已发起');
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }

  /// request -  加入一个等待中的一起做活动
  Future<void> requestTogetherJoin(String togetherId) async {
    final id = togetherId.trim();
    if (id.isEmpty) {
      EasyLoading.showToast('活动信息无效');
      return;
    }
    EasyLoading.show();
    final response =
        await Net.value<Doing>().requestTogetherJoin<dynamic>(togetherId: id);
    EasyLoading.dismiss();
    if (response.succeed) {
      EasyLoading.showToast('已加入');
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }
}
