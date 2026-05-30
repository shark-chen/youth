import 'package:kellychat/modules/home/doing/doing_list/model/invitation_inbox_entity.dart';
import 'package:kellychat/network/net/entry/doing/doing.dart';
import '../invite_record_controller.dart';
import 'package:kellychat/base/base_controller.dart';

/// FileName: invite_record_request_controller
///
/// @Author 谌文
/// @Date 2026/4/18
///
/// @Description 邀约记录-请求-controller
extension InviteRecordRequestController on InviteRecordController {
  /// mark - request
  ///
  /// request - 邀约收件箱
  Future<void> requestInvitationInbox() async {
    EasyLoading.show();
    final response =
        await Net.value<Doing>().cache<InvitationInboxEntity>((value) {
      if (value == null) return;
      vm.value.configInvitationInbox(value);
      vm.refresh();
    }).requestInvitationInbox<InvitationInboxEntity>();
    EasyLoading.dismiss();
    if (response.succeed) {
      vm.value.configInvitationInbox(response.value);
      vm.refresh();
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }
}
