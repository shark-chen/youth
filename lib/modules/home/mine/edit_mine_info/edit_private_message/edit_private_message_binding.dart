import 'package:kellychat/base/base_bindings.dart';

import 'edit_private_message_controller.dart';

/// FileName: edit_private_message_binding
///
/// @Description 说两句-binding
class EditPrivateMessageBinding extends BaseBindings {
  @override
  void dependencies() {
    Get.lazyPut<EditPrivateMessageController>(() => EditPrivateMessageController());
  }
}

