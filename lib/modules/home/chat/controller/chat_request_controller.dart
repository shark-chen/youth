import 'package:kellychat/base/base_controller.dart';
import 'package:kellychat/modules/home/mine/edit_mine_info/model/image_links_entity.dart';
import 'package:kellychat/network/net/entry/message/message.dart';
import 'package:kellychat/network/net/entry/user/user.dart';
import 'package:kellychat/network/net/net_result.dart';

import '../chat_controller.dart';
import '../model/chat_history_entity.dart';

/// FileName: chat_request_controller
///
/// @Author 谌文
/// @Date 2026/4/19 17:46
///
/// @Description 聊天-请求- controller
extension ChatRequestController on ChatController {
  /// request -聊天历史 · GET /api/message/history/{userId}
  ///
  /// [lastMessageId] 首次拉取可省略；分页时传上一页最早一条消息的 id。
  Future<ChatHistoryEntity?> requestMessageHistory({
    required String userId,
    int? lastMessageId,
    int size = 20,
  }) async {
    if (userId.isEmpty) {
      EasyLoading.showToast('用户无效');
      return null;
    }
    EasyLoading.show();
    final response =
        await Net.value<Message>().requestMessageHistory<ChatHistoryEntity>(
      userId: userId,
      lastMessageId: lastMessageId,
      size: size,
    );
    EasyLoading.dismiss();
    if (response.succeed) {
      return response.value;
    }
    return null;
  }

  /// request - 上传图片
  Future<ImageLinksEntity?> requestUploadPhoto(String path) async {
    if (Strings.isEmpty(path)) return null;
    EasyLoading.show();
    final response =
    await Net.value<User>().requestUploadPhoto<ImageLinksEntity>(
      path,
      filename: path.split('/').last,
    );
    EasyLoading.dismiss();
    if (response.succeed) {
      return response.value;
    } else {
      EasyLoading.showToast('发送失败');
      return null;
    }
  }
}
