import 'package:youth/base/base_bindings.dart';
import 'chat_controller.dart';

/// FileName: chat_binding
///
/// @Author 谌文
/// @Date 2026/3/17 23:56
///
/// @Description 实际聊天窗口-binding
class ChatBinding extends BaseBindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(() => ChatController());
  }
}
