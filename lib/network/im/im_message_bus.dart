import 'package:kellychat/tripartite_library/notification/event_bus_manager.dart';

import 'im_incoming_message_event.dart';
import 'im_models.dart';

/// IM 私信 EventBus 通知
class ImMessageBus {
  ImMessageBus._();

  /// 解析成功则发送 [ImIncomingMessageEvent]，返回是否有效
  static bool tryFireFromIncoming(ImIncomingMessage message) {
    final map = message.tryAsJsonMap();
    if (map == null || map.isEmpty) return false;
    EventBusManager().fire(const ImIncomingMessageEvent());
    return true;
  }
}
