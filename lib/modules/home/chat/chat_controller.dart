import 'dart:async';
import 'package:kellychat/base/base_controller.dart';
import 'package:kellychat/modules/home/chat/model/chat_param_model.dart';
import 'package:kellychat/modules/home/chat/view_model/chat_ui_vm.dart';
import 'package:kellychat/utils/utils/client_msg_id.dart';
import 'controller/chat_request_controller.dart';
import 'model/chat_history_entity.dart';
import 'view_model/chat_vm.dart';
import 'controller/chat_im_controller.dart';
import 'controller/chat_route_controller.dart';
export 'controller/chat_route_controller.dart';

/// FileName: chat_controller
///
/// @Author 谌文
/// @Date 2026/3/17 23:56
///
/// @Description 实际聊天窗口 - controller
class ChatController extends BaseController {
  /// userId: 用户ID
  /// niceName: 用户昵称
  ChatController({
    required ChatParamModel chatParam,
  }) {
    /// 配置IM-参数
    vm.value.configChatParam(value: chatParam);
  }

  /// vm
  Rx<ChatVM> vm = ChatVM().obs;

  @override
  void onInit() async {
    super.onInit();
    title = '${vm.value.chatParam.niceName ?? '--'}';

    /// 先拉一次历史（如果能拿到 toUserId）
    await _loadHistory();

    /// 构建IM
    await buildIM();
  }

  @override
  void onClose() {
    try {
      vm.value.msgSub?.cancel();
    } catch (_) {}
    vm.value.msgSub = null;
    try {
      vm.value.errorSub?.cancel();
    } catch (_) {}
    vm.value.errorSub = null;
    vm.value.listScrollController.dispose();
    super.onClose();
  }

  /// 构建IM
  Future<void> buildIM() async {
    /// IM - 链接
    await connectIM();

    /// 监听 - IM -消息
    listenIM();
    listenIMErrors();
  }

  /// request -聊天历史 · GET /api/message/history/{userId}
  Future<void> _loadHistory() async {
    final res = await requestMessageHistory(
        userId: vm.value.chatParam.userId.toString());
    if (res == null) return;

    /// 添加聊天信息-list
    vm.value.addChatMsgList((res.list ?? []).reversed.toList());
    vm.refresh();
    vm.value.scheduleJumpToBottomAfterHistory();
  }

  /// 发送文本信息
  Future<void> sendText(String text) async {
    await _sendOptimisticMessage(contentType: 1, content: text);
  }

  /// 点击添加图片
  Future<void> clickAddPhoto() async {
    final file = await vm.value.pickPhotoFile();
    final imageLinksEntity = await requestUploadPhoto(file?.path ?? '');
    if (imageLinksEntity == null) return;
    await _sendOptimisticMessage(
      contentType: 2,
      content: imageLinksEntity.url ?? '',
    );
  }

  /// 乐观发送：先展示 sending，再 STOMP 发送；回执用 clientMsgId 合并
  Future<void> _sendOptimisticMessage({
    required int contentType,
    required String content,
  }) async {
    final t = content.trim();
    if (t.isEmpty || Strings.isEmpty(vm.value.chatParam.userId)) return;
    final clientMsgId = newClientMsgId();
    final item = vm.value.buildIMSendMsgUIModel(
      contentType: contentType,
      content: t,
      clientMsgId: clientMsgId,
    );
    vm.value.addChatMsg(item);
    vm.refresh();
    try {
      await sendChatMessage(
        contentType: contentType,
        content: t,
        clientMsgId: clientMsgId,
      );
      vm.refresh();
    } catch (_) {
      vm.value.markSendFailedByClientMsgId(clientMsgId);
      vm.refresh();
    }
    vm.value.animateToListToBottom();
  }

  /// 失败消息重发（新 clientMsgId）
  Future<void> retrySendMessage(ChatHistoryList item) async {
    final content = (item.content ?? '').trim();
    if (content.isEmpty) return;
    final contentType = item.contentType ?? 1;
    final clientMsgId = newClientMsgId();
    item.clientMsgId = clientMsgId;
    item.sendStatus = ChatMsgSendStatus.sending;
    item.sendFailReason = null;
    vm.refresh();
    try {
      await sendChatMessage(
        contentType: contentType,
        content: content,
        clientMsgId: clientMsgId,
      );
    } catch (_) {
      vm.value.markSendFailedByClientMsgId(clientMsgId);
      vm.refresh();
    }
  }

  /// 消息列表
  List<ChatHistoryList> get messages {
    return vm.value.messages;
  }

  /// 对方消息头像：有效 userId 才跳转他人资料
  String? _peerProfileUserId(ChatHistoryList item) {
    final raw = item.fromUserId ?? vm.value.chatParam.userId;
    if (raw == null) return null;
    final id = raw.toString().trim();
    if (id.isEmpty || id == '0') return null;
    return id;
  }

  /// 构建聊天信息- UI
  Widget buildChatMsgUI(ChatHistoryList item) {
    final VoidCallback? onAvatarTap;
    if (item.isSender) {
      onAvatarTap = () => pushMyProfile();
    } else {
      final userId = _peerProfileUserId(item);
      onAvatarTap =
          userId == null ? null : () => pushProfile(userId: userId);
    }
    final VoidCallback? onRetry;
    if (item.isSender &&
        item.sendStatus == ChatMsgSendStatus.failed &&
        (item.clientMsgId ?? '').isNotEmpty) {
      onRetry = () => retrySendMessage(item);
    } else {
      onRetry = null;
    }
    return vm.value.buildChatMsgUI(
      item,
      onAvatarTap: onAvatarTap,
      onRetry: onRetry,
    );
  }
}
