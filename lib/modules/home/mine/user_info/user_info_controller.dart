import 'package:kellychat/base/base_controller.dart';
import 'package:kellychat/modules/user/user_center/my_doing/my_doing.dart';
import '../../doing/doing_list/view/doing_list_cell.dart';
import 'model/user_info_entity.dart';
import 'view_model/user_info_vm.dart';
export 'controller/user_info_route_controller.dart';
export 'controller/user_info_request_controller.dart';
import 'controller/user_info_request_controller.dart';
import 'controller/user_info_route_controller.dart';

/// FileName: user_info_controller
///
/// @Author 谌文
/// @Date 2026/3/16 22:5
///
/// @Description 用户信息模块-controller
class UserInfoController extends BaseController {
  UserInfoController({String? userId}) {
    vm.value.userId = userId;
  }

  /// vm
  Rx<UserInfoVM> vm = UserInfoVM().obs;

  @override
  void onInit() async {
    super.onInit();
    final userId = vm.value.userId;
    if (userId != null) {
      /// request -他人信息
      title = '用户详情';
      await requestOtherUserProfile(userId);
      requestInvitationSent();
    } else {
      title = '个人中心';
      await requestUserProfile();
    }

    requestInvitationCurrentDoingState();
  }

  /// mark - method
  ///
  /// 获取数据
  UserInfoEntity? get userInfo {
    return vm.value.userInfo;
  }

  /// 当前查看用户的ID（路由参数）
  int? get targetUserId {
    final id = vm.value.userId;
    if (id == null) return null;
    return int.tryParse(id);
  }

  /// 当前页用户 ID（优先 profile 返回，与发约 toUserId 一致）
  int? get currentProfileUserId => userInfo?.id ?? targetUserId;

  /// 当前一起做按钮状态
  TogetherButtonStatus get togetherButtonStatus {
    final myPartner = MyDoing().doing?.togetherPartner;
    final tId = targetUserId;
    if (tId == null) return TogetherButtonStatus.available;

    // 已和对方建立连接
    if (myPartner?.userId == tId) {
      return TogetherButtonStatus.connected;
    }

    // 自己已和其他人建立连接
    if (myPartner != null) {
      return TogetherButtonStatus.disabled;
    }

    return TogetherButtonStatus.available;
  }

  /// 当前一起做按钮文案
  String get togetherButtonTitle {
    switch (togetherButtonStatus) {
      case TogetherButtonStatus.connected:
        return '取消';
      case TogetherButtonStatus.disabled:
      case TogetherButtonStatus.available:
        return '一起做';
    }
  }

  /// 左侧按钮是否可点击
  bool get togetherButtonEnabled {
    return togetherButtonStatus != TogetherButtonStatus.disabled;
  }

  /// 点击跳转到 编辑个人信息页面
  void clickPushEditMineInfoPage() async {
    final result = await pushEditMineInfoPage();
    if (true != result) return;

    /// 获取个人信息 · GET /api/user/profile
    await requestUserProfile();
    await UserInfoCenter().requestUserInfo(update: true);
  }

  /// 点击一起做
  void clickInvert() async {
    /// 查询当前事项邀约状态
    final state = await requestInvitationCurrentDoingState();
    if (state == null) return;

    /// 当前存在配对好的一起做的事：提示先断开当前连接
    if (state.hasActiveTogether == true) {
      final togetherPartner = MyDoing().doing?.togetherPartner;
      final result =
          await pushAlreadyConnectedDialog(togetherPartner?.nickname ?? '--');
      if (result) {
        /// 取消一起做
        await requestCancelTogether(
          togetherId: togetherPartner?.togetherId.toString() ?? '',
          showLoad: false,
        );

        /// 发起邀请
        await invitationProfileSend();
      }
      return;
    }

    /// 当前事项存在邀请：提示先取消当前待接受邀约（仅弹框，后续流程自行接续）
    if (state.hasPendingInvitation == true) {
      final result =
          await pushPendingInvitationTipDialog(vm.value.pendingSentInvitation);
      if (result) {
        /// 发起邀请
        await invitationProfileSend();
      }
      return;
    }

    /// 无当前事项：输入创建并发约
    if (state.hasCurrentDoing != true) {
      /// 发起邀请
      await invitationProfileSend();
      return;
    }

    /// 可直接用当前事项发起邀约
    if (state.canQuickInvite == true) {
      await requestInvitationProfileSend(toUserId: currentProfileUserId ?? 0);
    }
  }

  /// 发起邀请
  Future invitationProfileSend() async {
    final text = await pushInvitePartnerTogetherSheet();
    if (text == null || text.isEmpty) return;

    /// 用户详情页发起一起做邀约（toUserId 必填，tagName / message 可选）
    final doing = await requestInvitationProfileSend(
      tagName: text,
      toUserId: currentProfileUserId ?? 0,
    );
    if (doing == null || doing.tagId == null) return;
    vm.refresh();

    final sent = await requestInvitationSend(
      toUserId: currentProfileUserId ?? 0,
      invitationType: 1,
      tagId: doing.tagId ?? 0,
      message: text,
    );
    if (sent) {
      vm.refresh();
      await requestInvitationCurrentDoingState();
    }
  }
}
