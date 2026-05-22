import 'package:kellychat/modules/home/doing/doing_list/model/invitation_inbox_entity.dart';
import 'package:kellychat/modules/home/doing/doing_list/model/invitation_item_entity.dart';
import 'package:kellychat/modules/home/doing/model/publish_doing_entity.dart';
import 'package:kellychat/modules/user/user_center/my_doing/my_doing.dart';
import 'package:kellychat/network/net/net_result.dart';
import 'package:kellychat/network/net/entry/doing/doing.dart';
import 'package:kellychat/network/net/entry/user/user.dart';

import '../model/user_info_entity.dart';
import '../user_info_controller.dart';
import 'package:kellychat/base/base_controller.dart';

/// FileName: user_info_request_controller
///
/// @Author 谌文
/// @Date 2026/4/19 15:14
///
/// @Description 用户资料-请求-controller
extension UserInfoRequestController on UserInfoController {
  /// 是否已拉黑 · GET /api/block/check/{blockedUserId}
  Future<bool> requestBlockCheck({
    required String blockedUserId,
  }) async {
    final id = blockedUserId.trim();
    if (id.isEmpty) {
      EasyLoading.showToast('用户无效');
      return false;
    }
    EasyLoading.show();
    final response =
        await Net.value<User>().requestBlockCheck<bool>(blockedUserId: id);
    EasyLoading.dismiss();
    return response.value ?? false;
  }

  /// 拉黑用户
  /// POST /api/block/{blockedUserId}
  Future<bool> requestBlockUser({required String blockedUserId}) async {
    final id = blockedUserId.trim();
    if (id.isEmpty) {
      EasyLoading.showToast('用户无效');
      return false;
    }
    EasyLoading.show();
    final response = await Net.value<User>().requestBlockUser<dynamic>(
      blockedUserId: id,
    );
    EasyLoading.dismiss();
    if (response.success) {
      EasyLoading.showToast('已拉黑');
      vm.refresh();
      return true;
    } else {
      EasyLoading.showToast(response.msg ?? '');
      return false;
    }
  }

  /// 取消拉黑 · DELETE /api/block/{blockedUserId}
  Future<bool> requestUnblockUser({required String blockedUserId}) async {
    final id = blockedUserId.trim();
    if (id.isEmpty) {
      EasyLoading.showToast('用户无效');
      return false;
    }
    EasyLoading.show();
    final response = await Net.value<User>().requestUnblockUser<dynamic>(
      blockedUserId: id,
    );
    EasyLoading.dismiss();
    if (response.success) {
      EasyLoading.showToast('已取消拉黑');
      vm.refresh();
      return true;
    } else {
      EasyLoading.showToast(response.msg ?? '');
      return false;
    }
  }

  /// mark - request
  ///
  /// 获取个人信息 · GET /api/user/profile
  Future<void> requestUserProfile() async {
    EasyLoading.show();
    final response = await Net.value<User>().cache<UserInfoEntity>((value) {
      vm.value.configUserInfo(value);
      vm.refresh();
    }).requestUserInfo<UserInfoEntity>();
    EasyLoading.dismiss();
    if (response.succeed) {
      vm.value.configUserInfo(response.value);
      vm.refresh();
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }

  /// request -他人信息
  Future<void> requestOtherUserProfile(String userId) async {
    EasyLoading.show();
    final response = await Net.value<User>()
        .requestUserByUserId<UserInfoEntity>(userId: userId);
    EasyLoading.dismiss();
    if (response.succeed) {
      vm.value.configUserInfo(response.value);
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
    if (response.code == 200 || response.code == 50000) {
      EasyLoading.showToast(
        response.code == 200 ? '已删除' : (response.msg ?? ''),
      );
      MyDoing().configDoing(null);
      await MyDoing().requestMyDoing();
      return true;
    }
    EasyLoading.showToast(response.msg ?? '');
    return false;
  }

  /// GET /api/invitation/sent
  /// 获取发出的邀约（用于用户详情「一起做」pending 判断）
  Future<void> requestInvitationSent({bool useCache = true}) async {
    final doing = Net.value<Doing>();
    final response = useCache
        ? await doing
            .cache<List<InvitationItemEntity>>((values) {
            vm.value.configInvitationSent(values);
            vm.refresh();
          })
            .requestInvitationSent<List<InvitationItemEntity>>()
        : await doing.requestInvitationSent<List<InvitationItemEntity>>();
    if (response.succeed) {
      vm.value.configInvitationSent(_sentItemsFromResponse(response));
      vm.refresh();
    }
  }

  List<InvitationItemEntity> _sentItemsFromResponse(NetResult response) {
    final value = response.value;
    if (value is InvitationInboxEntity) {
      return value.items ?? [];
    }
    if (Lists.isNotEmpty(response.values)) {
      return List<InvitationItemEntity>.from(response.values);
    }
    return [];
  }

  /// GET /api/invitation/inbox
  Future<void> requestInvitationInbox({bool useCache = true}) async {
    final doing = Net.value<Doing>();
    final response = useCache
        ? await doing
            .cache<InvitationInboxEntity>((value) {
            if (value == null) return;
            vm.value.configInvitationInbox(value);
            vm.refresh();
          })
            .requestInvitationInbox<InvitationInboxEntity>()
        : await doing.requestInvitationInbox<InvitationInboxEntity>();
    if (response.succeed) {
      vm.value.configInvitationInbox(response.value);
      vm.refresh();
    }
  }

  /// DELETE /api/invitation/{invitationId}
  Future<bool> requestInvitationCancel(int invitationId) async {
    EasyLoading.show();
    final response = await Net.value<Doing>()
        .requestInvitationCancel<dynamic>(invitationId: invitationId);
    EasyLoading.dismiss();
    if (response.succeed || response.code == 200) {
      EasyLoading.showToast('已取消');
      await requestInvitationSent(useCache: false);
      return true;
    }
    EasyLoading.showToast(response.msg ?? '');
    return false;
  }

  /// POST /api/status/doing
  Future<PublishDoingEntity?> requestPostStatusDoing({
    required String tagName,
  }) async {
    final name = tagName.trim();
    if (name.isEmpty) {
      EasyLoading.showToast('请输入内容');
      return null;
    }
    EasyLoading.show();
    final response =
        await Net.value<Doing>().requestPostStatusDoing<PublishDoingEntity>(
      tagName: name,
    );
    EasyLoading.dismiss();
    if (response.succeed) {
      MyDoing().configDoing(response.value);
      await MyDoing().requestMyDoing();
      final latest = MyDoing().doing;
      if (latest != null) {
        EventBusManager().fire(latest);
      }
      return latest ?? response.value;
    }
    EasyLoading.showToast(response.msg ?? '');
    return null;
  }

  /// POST /api/invitation/send
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
      await requestInvitationSent(useCache: false);
      return true;
    }
    EasyLoading.showToast(response.msg ?? '');
    return false;
  }
}
