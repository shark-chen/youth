import 'package:kellychat/base/base_bindings.dart';
import 'about_kelly_chat_controller.dart';

/// FileName: about_kelly_chat_binding
///
/// @Author 谌文
/// @Date 2026/4/12 21:00
///
/// @Description
class AboutKellyChatBinding extends BaseBindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutKellyChatController>(() => AboutKellyChatController());
  }
}
