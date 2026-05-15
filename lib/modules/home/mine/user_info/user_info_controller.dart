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
/// @Date 2026/3/16 22:51
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
    } else {
      title = '个人中心';
      await requestUserProfile();
    }
  }

  /// mark - method
  ///
  /// 获取数据
  UserInfoEntity? get userInfo {
    return vm.value.userInfo;
  }

  /// 当前查看用户的ID
  int? get targetUserId {
    final id = vm.value.userId;
    if (id == null) return null;
    return int.tryParse(id);
  }

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

  void clickInvert() async {
    final status = togetherButtonStatus;

    // 已和对方建立连接，点击取消
    if (status == TogetherButtonStatus.connected) {
      final confirm = await pushCancelDoingDialog();
      if (!confirm) return;
      // TODO: 后端缺少取消一起做的API，暂时先删除正在做状态
      await requestDeleteStatusDoing(MyDoing().doing?.statusId ?? 0);
      vm.refresh();
      return;
    }

    // 自己已和其他人建立连接
    if (status == TogetherButtonStatus.disabled) {
      final partnerName = MyDoing().doing?.togetherPartner?.nickname ?? '';
      await pushAlreadyConnectedDialog(partnerName);
      return;
    }

    final result = await pushTogetherDoAlert();
    if (result) {
      /// 发送邀约 · POST /api/invitation/send
      await requestInvitationSend(
        toUserId: vm.value.userInfo?.id ?? 0,
        invitationType: 1,
        tagId: MyDoing().doing?.tagId ?? 0,
      );
    }
  }
}
