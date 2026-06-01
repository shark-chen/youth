import 'package:kellychat/modules/home/doing/model/doing_hot_tags_entity.dart';
import 'package:kellychat/modules/home/mine/user_info/model/current_doing_state_entity.dart';
import 'package:kellychat/modules/user/user_center/my_doing/my_doing.dart';
import 'package:kellychat/network/net/entry/doing/doing.dart';
import '../../model/publish_doing_entity.dart';
import '../doing_list_controller.dart';
import 'package:kellychat/base/base_controller.dart';
import '../model/doing_list_entity.dart';
import '../model/invite_friend_entity.dart';
import '../model/invitation_inbox_entity.dart';

/// FileName: doing_list_request_controller
///
/// @Author 谌文
/// @Date 2026/4/16 21:28
///
/// @Description
extension DoingListRequestController on DoingListController {
  /// mark - request
  ///
  /// request -查询当前事项邀约状态
  Future<CurrentDoingStateEntity?> requestInvitationCurrentDoingState<T>({
    required int targetUserId,
  }) async {
    EasyLoading.show();
    final response = await Net.value<Doing>()
        .requestInvitationCurrentDoingState<CurrentDoingStateEntity>(
      targetUserId: targetUserId,
    );
    EasyLoading.dismiss();
    if (response.success) {
      return response.value;
    } else {
      EasyLoading.showToast(response.msg ?? '');
      return null;
    }
  }

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
      MyDoing().configDoing(response.value);
      vm.refresh();
    } else if (response.code == 200) {
      vm.value.configMyDoing(null);
      MyDoing().configDoing(null);
      vm.refresh();
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }

  /// 取消一起做
  Future<bool> requestCancelTogether({
    required String togetherId,
    bool showLoad = true,
  }) async {
    final id = togetherId.trim();
    if (id.isEmpty) {
      EasyLoading.showToast('活动信息无效');
      return false;
    }
    if (showLoad) EasyLoading.show();
    final response = await Net.value<Doing>().requestCancelTogether<dynamic>(
      togetherId: id,
    );
    if (showLoad) EasyLoading.dismiss();
    if (response.code == 200) {
      EasyLoading.showToast('已取消');
      await MyDoing().requestMyDoing();
      EventBusManager().fire(MyDoing().doing);
      if (!MyDoing().existTagName) {
        await pushDoingPage();
      }
      return true;
    }
    EasyLoading.showToast(response.msg ?? '');
    return false;
  }

  /// request - 取消一个发布的正在状态
  Future<bool> requestDeleteStatusDoing(int statusId) async {
    EasyLoading.show();
    final response = await Net.value<Doing>()
        .requestDeleteStatusDoing<dynamic>(statusId: statusId);
    EasyLoading.dismiss();
    if (response.code == 200 || response.code == 50000) {
      EasyLoading.showToast(
        response.code == 200 ? '已删除' : (response.msg ?? ''),
      );
      MyDoing().configDoing(null);
      vm.value.configMyDoing(null);
      await MyDoing().requestMyDoing();
      vm.value.configMyDoing(MyDoing().doing);
      vm.refresh();
      return true;
    }
    EasyLoading.showToast(response.msg ?? '');
    return false;
  }

  /// request - 获取当前热门的正在做标签列表
  Future requestHotTags({bool showLoad = true}) async {
    if (showLoad) EasyLoading.show();
    var response =
        await Net.value<Doing>().requestHotTags<DoingHotTagsEntity>(limit: 20);
    if (showLoad) EasyLoading.dismiss();
    if (response.succeed) {
      vm.value.configHotTags(response.values);
      vm.refresh();
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }

  /// request - 获取正在做某个标签的用户列表（分页：[pageNo]、[pageSize]）
  Future<bool> requestStatusDoingByTagId(
    int tagId, {
    bool showLoad = true,
    bool refresh = true,
  }) async {
    if (showLoad) EasyLoading.show();
    final response =
        await Net.value<Doing>().requestStatusDoing<DoingListEntity>(
      tagId: tagId,
      page: pageNo,
      size: pageSize,
    );
    if (showLoad) EasyLoading.dismiss();
    if (response.succeed) {
      vm.value.configDoingListEntity(response.value, refresh: refresh);
      vm.refresh();
      final total = vm.value.doingListEntity?.total ?? 0;
      final loaded = vm.value.rows?.length ?? 0;
      haveLoadMore(loaded < total);
      return true;
    }
    EasyLoading.showToast(response.msg ?? '');
    return false;
  }

  /// 发布热门标签为「我正在做」（列表空态里点加号，与 Doing 页选标签一致）
  Future<void> requestPublishDoingFromHotTag(DoingHotTagsEntity tag) async {
    if (Strings.isEmpty(tag.tagName)) return;
    if (requesting.value) return;
    requesting.value = true;
    try {
      final statusId = vm.value.myDoing?.statusId;
      if (statusId != null && statusId > 0) {
        final deleted = await requestDeleteStatusDoing(statusId);
        if (!deleted) return;
      }
      EasyLoading.show();
      final response =
          await Net.value<Doing>().requestPostStatusDoing<PublishDoingEntity>(
        tagName: tag.tagName ?? '',
      );
      EasyLoading.dismiss();
      if (response.succeed && response.value != null) {
        final doing = response.value!;
        MyDoing().configDoing(doing);
        await MyDoing().requestMyDoing();
        refreshController.refreshCompleted();
        EventBusManager().fire(doing);
        EasyLoading.showToast('发布成功');
        vm.refresh();
      } else {
        EasyLoading.showToast(response.msg ?? '');
      }
    } finally {
      requesting.value = false;
    }
  }

  /// request - 向某个用户发送敲一下
  ///
  /// [showLoading] 为 false 时不展示全屏 Loading，成功 Toast 由调用方处理。
  Future<bool> requestKnockSend({
    required int toUserId,
    int? tagId,
    bool showLoading = true,
  }) async {
    if (showLoading) EasyLoading.show();
    final response = await Net.value<Doing>().requestKnockSend<dynamic>(
      toUserId: toUserId,
      tagId: tagId,
    );
    if (showLoading) EasyLoading.dismiss();
    if (response.success) {
      return true;
    }
    EasyLoading.showToast(response.msg ?? '');
    return false;
  }

  /// GET /api/invitation/inbox
  /// 邀约收件箱（双向合并列表 + 未读数）
  ///
  /// [useCache] 为 false 时跳过缓存，用于「一起做」前拉最新 pending 状态。
  Future<void> requestInvitationInbox({bool useCache = true}) async {
    final response =
        await Net.value<Doing>().cache<InvitationInboxEntity>((value) {
      if (value == null) return;
      vm.value.configInvitationInbox(value);
      vm.refresh();
    }, cache: useCache).requestInvitationInbox<InvitationInboxEntity>();
    if (response.succeed) {
      vm.value.configInvitationInbox(response.value);
      vm.refresh();
    }
  }

  /// DELETE /api/invitation/{invitationId}
  /// 取消邀约（发起方主动取消，仅限待处理状态）
  Future<bool> requestInvitationCancel(int invitationId) async {
    EasyLoading.show();
    final response = await Net.value<Doing>()
        .requestInvitationCancel<dynamic>(invitationId: invitationId);
    EasyLoading.dismiss();
    if (response.succeed || response.code == 200) {
      EasyLoading.showToast('已取消');
      await requestInvitationInbox(useCache: false);
      return true;
    } else {
      EasyLoading.showToast(response.msg ?? '');
      return false;
    }
  }

  /// request - 发送邀约
  Future<bool> requestInvitationSend({
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
      await requestInvitationInbox(useCache: false);
      return true;
    } else {
      EasyLoading.showToast(response.msg ?? '');
      return false;
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

  /// POST /api/together/direct-connect
  /// 直接建立一起做连接
  Future<bool> requestTogetherDirectConnect({
    required int toUserId,
    required int tagId,
    bool force = true,
  }) async {
    EasyLoading.show();
    final response =
        await Net.value<Doing>().requestTogetherDirectConnect<dynamic>(
      toUserId: toUserId,
      tagId: tagId,
      force: force,
    );
    EasyLoading.dismiss();
    if (response.success) {
      EasyLoading.showToast('已连接');
      return true;
    }
    EasyLoading.showToast(response.msg ?? '');
    return false;
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
