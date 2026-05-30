import 'package:kellychat/base/base_page.dart';
import 'package:kellychat/tripartite_library/tripartite_library.dart';
import 'chat_controller.dart';
import 'view/chat_input_bar.dart';

/// FileName: chat_page
///
/// @Author 谌文
/// @Date 2026/3/17 23:56
///
/// @Description 实际聊天窗口-page-页面
class ChatPage extends BasePage<ChatController> {
  ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.hideKeyboard,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: ThemeColor.themeColor,
        appBar:
            AppBarKit.appBar(controller.title ?? '', elevation: 0, actions: [
          GestureDetector(
            onTap: () => controller.pushProfile(
              userId: '${controller.vm.value.chatParam.userId}',
            ),
            child: Padding(
              padding: EdgeInsets.only(right: 6),
              child: Image.asset(
                'assets/image/common/look_more@3x.png',
                width: 32,
                height: 32,
              ),
            ),
          ),
        ]),
        body: Obx(
          () => SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: controller.vm.value.listScrollController,
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      final item = controller.messages[index]..index = '$index';
                      return controller.buildChatMsgUI(item);
                    },
                  ),
                ),
                ChatInputBar(
                  onSend: (text) => controller.sendText(text),
                  onAttach: controller.clickAddPhoto,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
