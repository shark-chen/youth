import 'dart:convert';

/// 连接状态
enum ImConnectionState {
  disconnected,
  connecting,
  connected,
  reconnecting,
}

/// 收到的消息（保留 raw，便于业务自行解析）
class ImIncomingMessage {
  final dynamic raw;

  ImIncomingMessage(this.raw);

  /// 尝试把 raw 解析为 Map（raw 可能是 String / Map / 其他）
  Map<String, dynamic>? tryAsJsonMap() {
    final r = raw;
    if (r is Map<String, dynamic>) return r;
    if (r is Map) return r.cast<String, dynamic>();
    if (r is String) {
      try {
        final decoded = jsonDecode(r);
        if (decoded is Map<String, dynamic>) return decoded;
        if (decoded is Map) return decoded.cast<String, dynamic>();
      } catch (_) {
        return null;
      }
    }
    return null;
  }
}

/// 对外发送的消息（默认按 JSON 文本发送）
class ImOutgoingMessage {
  final Map<String, dynamic> json;

  ImOutgoingMessage(this.json);

  String encode() => jsonEncode(json);
}

