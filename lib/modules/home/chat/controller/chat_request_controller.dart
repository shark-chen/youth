import 'package:kellychat/base/base_controller.dart';
import 'package:kellychat/network/net/entry/message/message.dart';
import 'package:kellychat/network/net/net_result.dart';

import '../chat_controller.dart';

/// FileName: chat_request_controller
///
/// @Author 谌文
/// @Date 2026/4/19 17:46
///
/// @Description
extension ChatRequestController on ChatController {
  /// 聊天历史 · GET /api/message/history/{userId}
  ///
  /// [lastMessageId] 首次拉取可省略；分页时传上一页最早一条消息的 id。
  Future<NetResult<dynamic>> requestMessageHistory({
    required String userId,
    int? lastMessageId,
    int size = 20,
  }) async {
    final id = userId.trim();
    if (id.isEmpty) {
      EasyLoading.showToast('用户无效');
      return NetResult.error(msg: '用户无效');
    }
    EasyLoading.show();
    final response = await Net.value<Message>().requestMessageHistory<dynamic>(
      userId: id,
      lastMessageId: lastMessageId,
      size: size,
    );
    EasyLoading.dismiss();
    if (!response.succeed) {
      EasyLoading.showToast(response.msg ?? '');
    }
    return response;
  }
}
