import 'package:youth/base/base_bindings.dart';
import 'message_controller.dart';

/// FileName: message_binding
///
/// @Author 谌文
/// @Date 2026/3/10 19:53
///
/// @Description 消息模块-binding
class MessageBinding extends BaseBindings {
  @override
  void dependencies() {
    Get.lazyPut<MessageController>(() => MessageController());
  }
}
