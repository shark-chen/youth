import 'dart:async';

import 'package:kellychat/base/base_controller.dart';
import 'package:kellychat/network/im/im_service.dart';
import 'controller/chat_request_controller.dart';
import 'model/chat_message_entity.dart';

/// FileName: chat_controller
///
/// @Author 谌文
/// @Date 2026/3/17 23:56
///
/// @Description 实际聊天窗口 - controller
class ChatController extends BaseController {
  /// 对方用户 id（从路由参数/arguments 读取）
  late final int toUserId;

  /// 消息列表（对齐后端 push 字段）
  final RxList<ChatMessageEntity> messages = <ChatMessageEntity>[].obs;

  final Set<int> _dedupeMessageIds = <int>{};

  StreamSubscription? _msgSub;

  @override
  void onInit() async {
    super.onInit();
    title = '小雨';

    final arg = Get.parameters;
    final String? argUserId;
    argUserId = (arg['userId'] ?? arg['toUserId']);

    toUserId =
        int.tryParse('${Get.parameters['userId'] ?? argUserId ?? ''}') ?? 0;

    /// 确保 IM 已连接
    try {
      await Get.find<ImService>().connectIfNeeded();
    } catch (_) {}

    /// 先拉一次历史（如果能拿到 toUserId）
    if (toUserId > 0) {
      await _loadHistory();
    }

    /// 订阅实时消息
    _msgSub = Get.find<ImService>().messageStream.listen((m) {
      final map = m.tryAsJsonMap();
      if (map == null || map.isEmpty) return;

      final msg = ChatMessageEntity.fromJson(map);
      if (_shouldIgnore(msg)) return;
      _appendMessage(msg);
    });
  }

  Future<void> _loadHistory() async {
    final res = await requestMessageHistory(userId: toUserId.toString());
    if (!res.succeed) return;
    final data = res.data;
    if (data is List) {
      for (final item in data) {
        if (item is Map) {
          final msg = ChatMessageEntity.fromJson(item.cast<String, dynamic>());
          if (_shouldIgnore(msg)) continue;
          _appendMessage(msg);
        }
      }
    }
  }

  Future<void> sendText(String text) async {
    final t = text.trim();
    if (t.isEmpty || toUserId <= 0) return;
    await Get.find<ImService>().sendChatMessage(
      toUserId: toUserId,
      contentType: 1,
      content: t,
    );
  }

  bool _shouldIgnore(ChatMessageEntity msg) {
    if ((msg.type ?? '').toUpperCase() != 'CHAT') return true;
    if (toUserId <= 0) return false;
    final from = msg.fromUserId ?? 0;
    final to = msg.toUserId ?? 0;
    // 过滤：只保留与当前会话相关的消息（from/to 任一为对方）
    if (from == toUserId || to == toUserId) return false;
    return true;
  }

  void _appendMessage(ChatMessageEntity msg) {
    final id = msg.messageId;
    if (id != null) {
      if (_dedupeMessageIds.contains(id)) return;
      _dedupeMessageIds.add(id);
    }
    messages.add(msg);
  }

  @override
  void onClose() {
    try {
      _msgSub?.cancel();
    } catch (_) {}
    _msgSub = null;
    super.onClose();
  }
}
