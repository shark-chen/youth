import 'package:kellychat/base/base_bindings.dart';

import 'edit_private_message_controller.dart';

/// FileName: edit_private_message_binding
///
/// @Description 说两句-binding
class EditPrivateMessageBinding extends BaseBindings {
  @override
  void dependencies() {
    if (Maps.isNotEmpty(Get.parameters)) {
      Get.lazyPut<EditPrivateMessageController>(
        () => EditPrivateMessageController(
          content: Get.parameters['content'],
          password: Get.parameters['password'],
          oldPassword: Get.parameters['oldPassword'],
        ),
      );
    } else {
      Get.lazyPut<EditPrivateMessageController>(
          () => EditPrivateMessageController());
    }
  }
}
