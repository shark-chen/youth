import 'dart:convert';

/// 对齐后端推送字段（/user/queue/messages）
///
/// type: "CHAT"
/// messageId/fromUserId/contentType/... 见后端 pushMessage map
class ChatMessageEntity {
  String? type;
  int? messageId;
  int? fromUserId;
  String? fromNickname;
  String? fromAvatar;
  int? contentType;
  String? content;
  dynamic createdAt;

  /// 兼容服务端可能回传（历史接口）toUserId，用于会话过滤
  int? toUserId;

  ChatMessageEntity();

  factory ChatMessageEntity.fromJson(dynamic json) {
    final m = ChatMessageEntity();
    if (json is Map) {
      final map = json.cast<String, dynamic>();
      m.type = map['type']?.toString();
      m.messageId = _toInt(map['messageId']);
      m.fromUserId = _toInt(map['fromUserId']);
      m.fromNickname = map['fromNickname']?.toString();
      m.fromAvatar = map['fromAvatar']?.toString();
      m.contentType = _toInt(map['contentType']);
      m.content = map['content']?.toString();
      m.createdAt = map['createdAt'];
      m.toUserId = _toInt(map['toUserId']);
    }
    return m;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': type,
        'messageId': messageId,
        'fromUserId': fromUserId,
        'fromNickname': fromNickname,
        'fromAvatar': fromAvatar,
        'contentType': contentType,
        'content': content,
        'createdAt': createdAt,
        if (toUserId != null) 'toUserId': toUserId,
      };

  /// 用于 UI 展示的时间文本（尽量兼容 string/epoch/DateTime）
  String get createdAtText {
    final v = createdAt;
    if (v == null) return '';
    if (v is DateTime) return v.toString();
    if (v is String) return v;
    if (v is int) {
      // 兼容秒/毫秒
      final ms = v < 2000000000 ? v * 1000 : v;
      return DateTime.fromMillisecondsSinceEpoch(ms).toString();
    }
    return v.toString();
  }

  static int? _toInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    return int.tryParse(v.toString());
  }

  @override
  String toString() => jsonEncode(toJson());
}

