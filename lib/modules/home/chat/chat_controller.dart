import 'dart:async';
import 'package:kellychat/base/base_controller.dart';
import 'package:kellychat/modules/home/chat/model/chat_param_model.dart';
import 'package:kellychat/modules/home/chat/view_model/chat_ui_vm.dart';
import 'package:kellychat/network/im/im_service.dart';
import 'controller/chat_request_controller.dart';
import 'model/chat_history_entity.dart';
import 'model/chat_im_entity.dart';
import 'model/chat_message_entity.dart';
import 'view_model/chat_vm.dart';
import 'controller/chat_im_controller.dart';

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
    super.onClose();
  }

  /// 构建IM
  Future<void> buildIM() async {
    /// IM - 链接
    await connectIM();

    /// 监听 - IM -消息
    listenIM();
  }

  /// request -聊天历史 · GET /api/message/history/{userId}
  Future<void> _loadHistory() async {
    final res = await requestMessageHistory(
        userId: vm.value.chatParam.userId.toString());
    if (res == null) return;

    /// 添加聊天信息-list
    vm.value.addChatMsgList((res.list ?? []).reversed.toList());
    vm.refresh();
  }

  /// 发送文本信息
  Future<void> sendText(String text) async {
    /// 发送文本信息
    await sendChatMessage(contentType: 1, content: text);

    /// IM - 发送消息，构建UI模型
    final item = vm.value.buildIMSendMsgUIModel(
      contentType: 1,
      content: text,
    );

    /// 添加聊天信息
    vm.value.addChatMsg(item);
    vm.refresh();
  }

  /// 点击添加图片
  Future<void> clickAddPhoto() async {
    final file = await vm.value.pickPhotoFile();
    final imageLinksEntity = await requestUploadPhoto(file?.path ?? '');
    if (imageLinksEntity == null) return;

    /// 发送文本信息
    await sendChatMessage(contentType: 2, content: imageLinksEntity.url ?? '');

    /// IM - 发送消息，构建UI模型
    final item = vm.value.buildIMSendMsgUIModel(
      contentType: 2,
      content: imageLinksEntity.url ?? '',
    );

    /// 添加聊天信息
    vm.value.addChatMsg(item);
    vm.refresh();
  }

  /// 消息列表
  List<ChatHistoryList> get messages {
    return vm.value.messages;
  }

  /// 构建聊天信息- UI
  Widget buildChatMsgUI(ChatHistoryList item) {
    return vm.value.buildChatMsgUI(item);
  }
}
