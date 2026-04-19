import 'package:youth/config/environment_config/app_config.dart';
import 'package:youth/network/net/net_mixin.dart';
import 'package:youth/network/net/net_result.dart';

/// FileName message
///
/// @Author 谌文
/// @Date 2026/4/18
///
/// @Description 消息 / 会话相关接口
class Message extends NetMixin<Message> {
  Message();

  factory Message.init() => Message();

  /// GET /api/message/conversations 获取用户会话列表
  Future<NetResult<T>> requestMessageConversations<T>({
    int page = 1,
    int size = 20,
  }) async {
    return await get<T>(
      AppConfig.getMessageConversationsUrl,
      params: <String, dynamic>{
        'page': page,
        'size': size,
      },
    );
  }

  /// GET /api/message/history/{userId} query: lastMessageId, size
  Future<NetResult<T>> requestMessageHistory<T>({
    required String userId,
    int? lastMessageId,
    int size = 20,
  }) async {
    final params = <String, dynamic>{'size': size};
    if (lastMessageId != null) {
      params['lastMessageId'] = lastMessageId;
    }
    return await get<T>(
      AppConfig.getMessageHistoryUrl(userId),
      params: params,
    );
  }
}
