import 'dart:async';

import 'package:get/get.dart';
import 'package:kellychat/modules/user/global.dart';

import 'im_models.dart';
import 'stomp_im_client.dart';

/// IM 长连接服务（全局单例，建议在 HomeBinding 注册）
class ImService extends GetxService {
  final StompImClient _im = StompImClient();

  Stream<ImConnectionState> get stateStream => _im.stateStream;
  Stream<ImIncomingMessage> get messageStream => _im.messageStream;
  Stream<ImIncomingMessage> get errorStream => _im.errorStream;

  bool get isConnected => _im.isConnected;

  /// 确保已连接（有 token 才会连接）
  Future<void> connect() async {
    if (isConnected) return;
    final token = (await Global.getAccessToken) ?? '';
    if (token.trim().isEmpty) return;
    await _im.connect(token: token);
  }

  Future<void> disconnect() => _im.disconnect();

  /// contentType: 消息类型：1-文本，2-图片
  /// content: 内容
  Future<void> sendChatMessage({
    required String toUserId,
    required int contentType,
    required String content,
  }) =>
      _im.sendChatMessage(
        toUserId: toUserId,
        contentType: contentType,
        content: content,
      );
}

