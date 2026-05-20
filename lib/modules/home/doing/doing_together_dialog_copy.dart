import 'package:kellychat/modules/home/doing/doing_list/model/invitation_item_entity.dart';

/// 一起做相关弹窗文案（用户详情 / 正在清单共用）
class DoingTogetherDialogCopy {
  DoingTogetherDialogCopy._();

  static String cancelOldInvitationMessage(InvitationItemEntity? invitation) {
    final name = invitation?.targetNickname ?? '--';
    final tag = invitation?.tagName ?? '--';
    return '你向$name发起的「$tag」一起做邀约，等待对方接受中。'
        '继续操作将取消该邀约，并建立新的一起做。';
  }
}
