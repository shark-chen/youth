import 'package:kellychat/base/base_page.dart';
import 'package:kellychat/modules/home/mine/edit_mine_info/view/edit_bottom_actions.dart';
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
      appBar: AppBarKit.appBar(
        controller.title ?? '',
        backTap: controller.onCancel,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: _buildInputCard(),
            ),
          ),
          Obx(
            () => EditBottomActions(
              onCancel: controller.onCancel,
              onSave: controller.onSave,
              saving: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
      decoration: BoxDecoration(
        color: ThemeColor.inputBgColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: ThemeColor.whiteColor.withOpacity(0.12),
        ),
      ),
      child: Stack(
        children: [
          TextField(
            controller: controller.textController,
            inputFormatters: controller.inputFormatters,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: TextStyle(
              color: ThemeColor.whiteColor.withOpacity(0.9),
              fontSize: 14,
              height: 1.35,
            ),
            decoration: InputDecoration(
              isCollapsed: true,
              border: InputBorder.none,
              hintText: '发送给AI的内容，最多1000个字。',
              hintStyle: TextStyle(
                color: ThemeColor.whiteColor.withOpacity(0.35),
                fontSize: 14,
                height: 1.35,
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Obx(
              () => Text(
                '${controller.currentLength.value}/${EditPrivateMessageController.maxLength}',
                style: TextStyle(
                  color: ThemeColor.whiteColor.withOpacity(0.35),
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

