import 'package:kellychat/base/base_vm.dart';
import 'package:kellychat/modules/home/doing/doing_list/model/invitation_inbox_entity.dart';
import 'package:kellychat/modules/home/doing/doing_list/model/invitation_item_entity.dart';
import '../model/current_doing_state_entity.dart';
import '../model/user_info_entity.dart';

/// FileName: user_info_vm
///
/// @Author 谌文
/// @Date 2026/3/16 23:04
///
/// @Description 用户信息模块-vm
class UserInfoVM extends BaseVM {
  /// 人信息数据
  UserInfoEntity? userInfo;

  /// 用户ID，无ID表示本人，有则是其他人
  String? userId;

  /// 邀约收件箱（兼容保留）
  InvitationInboxEntity? invitationInbox;

  /// 当前事项的状态
  CurrentDoingStateEntity? currentDoingState;

  @override
  void onInit() {
    super.onInit();
  }

  /// 配置个人信息数据
  void configUserInfo(UserInfoEntity? value) {
    userInfo = value;
  }

  void configInvitationInbox(InvitationInboxEntity? value) {
    invitationInbox = value;
  }


  void configCurrentDoingStateEntity(CurrentDoingStateEntity? value) {
    currentDoingState = value;
  }

  /// 发出约列表：待对方接受（status == 0）
  static bool _isPendingSentItem(InvitationItemEntity e) => e.status == 0;
}
