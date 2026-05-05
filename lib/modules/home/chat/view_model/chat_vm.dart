import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:kellychat/base/base_vm.dart';
import 'package:kellychat/tripartite_library/image_picker/images_picker.dart';
import '../model/chat_history_entity.dart';
import '../model/chat_param_model.dart';

import 'chat_msg_vm.dart';
export 'chat_msg_vm.dart';

/// FileName: chat_vm
///
/// @Author 谌文
/// @Date 2026/5/4 12:52
///
/// @Description 聊天-vm
class ChatVM extends BaseVM {
  /// 聊天列表-list
  List<ChatHistoryList> messages = [];

  /// 用户IM-初始化参数
  ChatParamModel chatParam = ChatParamModel();

  /// mark - IM
  ///
  /// IM - 监听
  StreamSubscription? msgSub;

  /// 消息列表滚动（历史加载后滚到底部等）
  final ScrollController listScrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
  }

  /// 添加聊天信息
  void addChatMsg(ChatHistoryList value) {
    /// 处理消息
    handleChatMsg([value]);
    messages.add(value);
  }

  /// 添加聊天信息-list
  void addChatMsgList(List<ChatHistoryList>? values) {
    if (Lists.isEmpty(values)) return;

    /// 处理消息
    handleChatMsg(values ?? []);
    messages.addAll(values ?? []);
  }

  /// 插入聊天信息
  void insertChatMsg(ChatHistoryList value) {
    /// 处理消息
    handleChatMsg([value]);
    messages.insert(0, value);
  }

  /// 插入聊天信息
  void insertChatMsgList(List<ChatHistoryList>? values) {
    if (Lists.isEmpty(values)) return;

    /// 处理消息
    handleChatMsg(values ?? []);
    messages.insertAll(0, values ?? []);
  }

  /// 添加图片墙
  Future<XFile?> pickPhotoFile() async {
    try {
      final x = await ImagesPicker().pickImageFromGallery();
      if (x == null) return null;
      return x;
    } catch (_) {
      EasyLoading.showToast('选择图片失败');
      return null;
    }
  }

  /// 配置IM-参数
  /// userId: 用户ID
  /// niceName: 用户昵称
  void configChatParam({required ChatParamModel value}) {
    chatParam = value;
  }
}
