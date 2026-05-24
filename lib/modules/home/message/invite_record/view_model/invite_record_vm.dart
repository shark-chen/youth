import 'package:kellychat/base/base_vm.dart';
import 'package:kellychat/modules/home/doing/doing_list/model/invitation_inbox_entity.dart';
import 'package:kellychat/modules/home/doing/doing_list/model/invitation_item_entity.dart';
import '../../model/message_person_list_entity.dart';
import '../model/together_list_entity.dart';

/// FileName: invite_record_vm
///
/// @Author 谌文
/// @Date 2026/3/12 23:25
///
/// @Description 邀约记录-vm
class InviteRecordVM extends BaseVM {
  /// 列表
  List<InvitationItemEntity> rows = [];

  @override
  void onInit() {
    super.onInit();
  }

  /// 配置邀约收件箱
  void configInvitationInbox(InvitationInboxEntity? value) {
    rows.clear();
    rows.addAll(value?.items ?? []);
  }
}
