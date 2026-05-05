import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kellychat/base/base_bindings.dart';
import 'chat_controller.dart';
import 'model/chat_param_model.dart';

/// FileName: chat_binding
///
/// @Author 谌文
/// @Date 2026/3/17 23:56
///
/// @Description 实际聊天窗口-binding
class ChatBinding extends BaseBindings {
  @override
  void dependencies() {
    final param = ChatParamModel.fromJson(Get.parameters);
    Get.lazyPut<ChatController>(() => ChatController(chatParam: param));
  }
}
