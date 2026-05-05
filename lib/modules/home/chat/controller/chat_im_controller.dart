import 'package:kellychat/network/im/im_service.dart';
import 'package:kellychat/utils/marco/debug_print.dart';
import '../chat_controller.dart';
import 'package:kellychat/base/base_controller.dart';
import '../model/chat_history_entity.dart';
import '../model/chat_im_entity.dart';
import '../view_model/chat_vm.dart';

/// FileName: chat_im_controller
///
/// @Author 谌文
/// @Date 2026/5/5 00:34
///
/// @Description 聊天-请求- controller
extension ChatIMController on ChatController {
  /// IM - 链接
  Future<void> connectIM() async {
    if (Strings.isEmpty(vm.value.chatParam.userId)) return;
    try {
      await Get.find<ImService>().connect();
    } catch (e) {
      DebugPrint(e);
    }
  }

  /// 监听 - IM -消息 - 订阅实时消息
  Future<void> listenIM() async {
    if (Strings.isEmpty(vm.value.chatParam.userId)) return;
    vm.value.msgSub = Get.find<ImService>().messageStream.listen((m) {
      final map = m.tryAsJsonMap();
      if (map == null || map.isEmpty) return;
      final msg = ChatImEntity.fromJson(map);

      /// 添加聊天信息
      vm.value.addChatMsg(ChatHistoryList.fromChatMessage(msg));
      vm.refresh();
    });
  }

  /// 发送文本信息
  /// contentType: 消息类型：1-文本，2-图片
  Future<void> sendChatMessage({
    required int contentType,
    required String content,
  }) async {
    final t = content.trim();
    if (t.isEmpty || Strings.isEmpty(vm.value.chatParam.userId)) return;
    await Get.find<ImService>().sendChatMessage(
      toUserId: vm.value.chatParam.userId ?? '',
      contentType: contentType,
      content: t,
    );
  }
}
