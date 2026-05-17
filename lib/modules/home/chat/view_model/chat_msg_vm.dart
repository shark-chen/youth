import 'package:kellychat/modules/user/user_center/user_center.dart';
import '../model/chat_history_entity.dart';
import '../model/chat_im_entity.dart';
import 'chat_vm.dart';

/// 与上一条间隔超过此时长才展示时间条（对齐微信）
const Duration _kChatTimeSeparatorGap = Duration(minutes: 10);

DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

/// 自然周：周一为起点（与微信常用一致）
DateTime _startOfWeekMonday(DateTime d) {
  final day = _dateOnly(d);
  return day.subtract(Duration(days: day.weekday - 1));
}

bool _isSameWeek(DateTime a, DateTime b) =>
    _startOfWeekMonday(a) == _startOfWeekMonday(b);

bool _isToday(DateTime msg, DateTime now) => _dateOnly(msg) == _dateOnly(now);

bool _isYesterday(DateTime msg, DateTime now) {
  final yesterday = _dateOnly(now).subtract(const Duration(days: 1));
  return _dateOnly(msg) == yesterday;
}

/// 解析服务端 / IM 时间字符串
DateTime? _parseChatCreatedAt(String? s) {
  if (s == null || s.isEmpty) return null;
  final iso = DateTime.tryParse(s);
  if (iso != null) return iso;
  final n = int.tryParse(s.trim());
  if (n != null) {
    final ms = n < 2000000000 ? n * 1000 : n;
    return DateTime.fromMillisecondsSinceEpoch(ms);
  }
  return null;
}

String _formatHHmm(DateTime d) =>
    '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

/// 微信风格时间文案（参考当前时间为「今天」）
///
/// 时间部分用数字拼接，避免 [DateFormat] 带 `zh_CN` 时依赖
/// `initializeDateFormatting`（未初始化会抛 [UninitializedLocaleData]）。
String _formatWeChatTimeTag(DateTime msgTime) {
  final now = DateTime.now();
  final hm = _formatHHmm(msgTime);

  if (_isToday(msgTime, now)) return hm;
  if (_isYesterday(msgTime, now)) return '昨天 $hm';
  if (_isSameWeek(msgTime, now)) {
    const weekdayNames = [
      '星期一',
      '星期二',
      '星期三',
      '星期四',
      '星期五',
      '星期六',
      '星期日',
    ];
    return '${weekdayNames[msgTime.weekday - 1]} $hm';
  }
  if (msgTime.year == now.year) {
    return '${msgTime.month}月${msgTime.day}日 $hm';
  }
  return '${msgTime.year}年${msgTime.month}月${msgTime.day}日 $hm';
}

/// FileName: chat_msg_vm
///
/// @Author 谌文
/// @Date 2026/5/4 23:17
///
/// @Description 聊天-处理消息-vm
///
/// 若在列表顶部插入历史（insertChatMsg / insertChatMsgList），插入后需重算
/// 插入块末条与原首条交界处的 timeTag，见 [ChatVM.insertChatMsgList]。
extension ChatMsgVM on ChatVM {
  /// 处理消息
  List<ChatHistoryList> handleChatMsg(List<ChatHistoryList> values) {
    final myId = (UserCenter().user?.id ?? 0).toString();
    for (var i = 0; i < values.length; i++) {
      final value = values[i];
      final from = value.fromUserId ?? 0;
      value.isSender = from == myId && myId != 0;
      if (value.isSender &&
          value.sendStatus == ChatMsgSendStatus.none) {
        value.sendStatus = ChatMsgSendStatus.sent;
      }
      if (value.isSender) {
        value.avatar = UserCenter().user?.avatar;
      } else {
        value.avatar = value.fromAvatar ?? chatParam.avatar;
      }

      /// 消息类型：1-文本，2-图片
      switch (value.contentType) {
        case 1:
          {
            value.chatMsgType = ChatMsgType.text;
          }
          break;
        case 2:
          {
            value.chatMsgType = ChatMsgType.photo;
          }
          break;
      }

      final ChatHistoryList? prevEntity =
          i > 0 ? values[i - 1] : (messages.isEmpty ? null : messages.last);
      final prevDt =
          prevEntity != null ? _parseChatCreatedAt(prevEntity.createdAt) : null;
      final currDt = _parseChatCreatedAt(value.createdAt);

      if (currDt == null) {
        value.timeTag = null;
      } else if (prevEntity == null || prevDt == null) {
        value.timeTag = _formatWeChatTimeTag(currDt);
      } else if (currDt.difference(prevDt) <= _kChatTimeSeparatorGap) {
        value.timeTag = null;
      } else {
        value.timeTag = _formatWeChatTimeTag(currDt);
      }
    }
    return values;
  }

  /// IM - 发送消息，构建UI模型
  ChatHistoryList buildIMSendMsgUIModel({
    required int contentType,
    required String content,
    required String clientMsgId,
  }) {
    final result = ChatHistoryList();
    result.fromUserId = (UserCenter().user?.id ?? 0).toString();
    result.toUserId = chatParam.userId;
    result.contentType = contentType;
    result.content = content;
    result.createdAt = DateTime.now().toIso8601String();
    result.isSender = true;
    result.clientMsgId = clientMsgId;
    result.sendStatus = ChatMsgSendStatus.sending;
    return result;
  }

  /// 处理 IM 推送：返回 true 表示已更新/忽略，false 表示应插入新消息
  bool applyIncomingImMessage(ChatImEntity im, {required String peerUserId}) {
    final peer = peerUserId.trim();
    if (peer.isEmpty) return true;

    final myId = (UserCenter().user?.id ?? 0).toString();
    final from = (im.fromUserId ?? '').trim();
    final status = (im.status ?? '').toLowerCase();
    final clientMsgId = (im.clientMsgId ?? '').trim();

    if (clientMsgId.isNotEmpty) {
      final idx = messages.indexWhere((e) => e.clientMsgId == clientMsgId);
      if (idx >= 0) {
        _mergeImIntoMessage(messages[idx], im, status);
        return true;
      }
      if (status == 'sent' && from == myId) {
        final item = ChatHistoryList.fromChatMessage(im);
        handleChatMsg([item]);
        messages.add(item);
        return true;
      }
    }

    if (status == 'received') {
      if (from != peer) return true;
      if (im.messageId != null &&
          messages.any((e) => e.messageId == im.messageId)) {
        return true;
      }
      return false;
    }

    if (from == myId) return true;
    if (from != peer) return true;
    return false;
  }

  void markSendFailedByClientMsgId(String clientMsgId, {String? reason}) {
    final id = clientMsgId.trim();
    if (id.isEmpty) return;
    final idx = messages.indexWhere((e) => e.clientMsgId == id);
    if (idx < 0) return;
    messages[idx].sendStatus = ChatMsgSendStatus.failed;
    if (reason != null && reason.isNotEmpty) {
      messages[idx].sendFailReason = reason;
    }
  }

  void _mergeImIntoMessage(
    ChatHistoryList target,
    ChatImEntity im,
    String status,
  ) {
    if (im.messageId != null) target.messageId = im.messageId;
    if (im.createdAt != null && im.createdAt!.isNotEmpty) {
      target.createdAt = im.createdAt;
    }
    target.sendStatus = ChatHistoryList.sendStatusFromIm(status);
    if (target.sendStatus != ChatMsgSendStatus.failed) {
      target.sendFailReason = null;
    }
  }
}
