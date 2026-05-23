import 'package:kellychat/modules/home/doing/doing_list/model/invitation_inbox_entity.dart';
import 'package:kellychat/modules/home/doing/doing_list/model/invitation_item_entity.dart';
import 'package:kellychat/modules/home/doing/model/publish_doing_entity.dart';
import 'package:kellychat/modules/user/user_center/my_doing/my_doing.dart';
import 'package:kellychat/network/net/net_result.dart';
import 'package:kellychat/network/net/entry/doing/doing.dart';
import 'package:kellychat/network/net/entry/user/user.dart';
import '../model/current_doing_state_entity.dart';
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

  /// request - 查询当前事项邀约状态
  Future<CurrentDoingStateEntity?> requestInvitationCurrentDoingState() async {
    EasyLoading.show();
    final response = await Net.value<Doing>()
        .requestInvitationCurrentDoingState<CurrentDoingStateEntity>();
    EasyLoading.dismiss();
    if (response.succeed) {
      vm.value.configCurrentDoingStateEntity(response.value);
      vm.refresh();
      return response.value;
    }
    return null;
  }

  /// request - 获取发出的邀约
  Future<void> requestInvitationSent({bool useCache = true}) async {
    final doing = Net.value<Doing>();
    final response = useCache
        ? await doing.cache<List<InvitationItemEntity>>((values) {
            vm.value.configInvitationSent(values);
            vm.refresh();
          }).requestInvitationSent<List<InvitationItemEntity>>()
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
        ? await doing.cache<InvitationInboxEntity>((value) {
            if (value == null) return;
            vm.value.configInvitationInbox(value);
            vm.refresh();
          }).requestInvitationInbox<InvitationInboxEntity>()
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

  /// POST /api/invitation/profile-send
  /// 用户详情页发起一起做邀约（toUserId 必填，tagName / message 可选）
  /// tagName： -当前无「正在做」时必填，用于创建新事项。
  /// 当前有「正在做」且可快捷邀约时可不传，后端自动使用当前事项。
  /// -用户主动重新输入新事项时传入，后端会切换当前事项。
  /// 后端规则已实现:
  // -发起邀约会自动把事项设为当前「正在做」。
  // -取消/切换当前「正在做」后，该用户发起的待处理邀约会失效。
  // -对方接受邀约时，如果发起方当前事项已取消或切换，邀约会被判定失效。
  //  当前事项已有待接受邀约或正在连接中时，不能快捷发起，需要先取消邀约或断开连接。
  Future requestInvitationProfileSend({
    required int toUserId,
    String? tagName,
    String? message,
  }) async {
    EasyLoading.show();
    final response = await Net.value<Doing>().requestInvitationProfileSend(
      toUserId: toUserId,
      tagName: tagName,
      message: message,
    );
    EasyLoading.dismiss();
    if (response.success) {
      EasyLoading.showToast('已邀约');
      return;
    }
    EasyLoading.showToast(response.msg ?? '');
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
      await requestInvitationCurrentDoingState();
      return true;
    }
    EasyLoading.showToast(response.msg ?? '');
    return false;
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
      return true;
    }
    EasyLoading.showToast(response.msg ?? '');
    return false;
  }
}
