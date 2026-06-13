import 'package:kellychat/base/base_vm.dart';
import 'package:kellychat/modules/home/doing/doing_list/model/invitation_inbox_entity.dart';
import 'package:kellychat/modules/home/doing/doing_list/model/invitation_item_entity.dart';
import '../model/knock_record_entity.dart';
import '../model/message_person_list_entity.dart';

/// FileName: message_vm
///
/// @Author 谌文
/// @Date 2026/3/10 23:17
///
/// @Description 消息-vm
class MessageVM extends BaseVM {
  /// 消息人列表
  List<MessagePersonListEntity> conversations = [];

  /// 敲一下记录
  KnockRecordEntity? knockRecordEntity;

  /// 邀约记录
  InvitationInboxEntity? invitationInbox;

  @override
  void onInit() {
    super.onInit();
  }

  /// 配置对话列表
  void configConversations(
    List<MessagePersonListEntity>? values, {
    bool? refresh = true,
  }) {
    if (true == refresh) {
      conversations.clear();
    }
    conversations.addAll(values ?? []);
  }

  /// 删除成功后移除本地会话项
  void removeConversation(int conversationId) {
    conversations =
        conversations.where((e) => e.conversationId != conversationId).toList();
  }

  /// 配置邀约收件箱
  void configInvitationInbox(InvitationInboxEntity? value) {
    invitationInbox = value;
  }

  /// 邀约记录
  List<InvitationItemEntity>? get invitationRow {
    return invitationInbox?.items;
  }
}
