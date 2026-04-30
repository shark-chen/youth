import 'package:kellychat/base/base_controller.dart';
import 'package:flutter/services.dart';

/// FileName: edit_private_message_controller
///
/// @Description 说两句（编辑私密内容）
class EditPrivateMessageController extends BaseController {
  static const int maxLength = 1000;

  final TextEditingController textController = TextEditingController();
  final RxInt currentLength = 0.obs;

  @override
  void onInit() {
    super.onInit();
    title = '说两句';

    final init = _readInitialText();
    textController.text = init;
    currentLength.value = init.characters.length;

    textController.addListener(() {
      currentLength.value = textController.text.characters.length;
    });
  }

  String _readInitialText() {
    final arg = Get.arguments;
    if (arg is String) return arg;

    final p = Get.parameters['text'];
    if (p != null) return p;

    return '';
  }

  List<TextInputFormatter> get inputFormatters => [
        LengthLimitingTextInputFormatter(maxLength),
      ];

  void onCancel() {
    Get.back();
  }

  void onSave() {
    final v = textController.text.trimRight();
    Get.back(result: v);
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}

