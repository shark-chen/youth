import 'package:kellychat/base/base_page.dart';
import 'package:kellychat/modules/home/mine/edit_mine_info/view/edit_bottom_actions.dart';
import 'package:kellychat/widget/input/count_input.dart';
import 'edit_private_message_controller.dart';

/// FileName: edit_private_message_page
///
/// @Description 说两句-page
class EditPrivateMessagePage extends BasePage<EditPrivateMessageController> {
  const EditPrivateMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ThemeColor.themeColor,
      appBar: AppBarKit.appBar(controller.title ?? ''),
      body: Obx(
        () => Stack(
          children: [
            Positioned(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                child: CountInput(
                  controller: controller.vm.value.editingController,
                  focusNode: controller.vm.value.focusNode,
                  height: 400,
                  hint: '发送给AI的内容，最多1000个字。',
                  maxLength: 1000,
                ),
              ),
            ),
            Positioned(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  EditBottomActions(
                    onCancel: controller.closePage,
                    onSave: controller.clickSave,
                    saveEnable: controller.vm.value.saveEnable,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
