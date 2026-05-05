import 'package:kellychat/base/base_page.dart';
import 'package:kellychat/utils/extension/strings/strings.dart';
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
        appBar: AppBarKit.appBar(controller.title ?? '', elevation: 0.2),
        body: Builder(
          builder: (context) {
            final bottomInset = MediaQuery.paddingOf(context).bottom;
            const inputReserve = 72.0;
            return Stack(
              children: [
                Positioned.fill(
                  child: Obx(() {
                    return SafeArea(
                      child: ListView.builder(
                        padding: EdgeInsets.only(
                          bottom: bottomInset + inputReserve + 8,
                        ),
                        itemCount: controller.messages.length,
                        itemBuilder: (context, index) {
                          final item = controller.messages[index]
                            ..index = '$index';
                          return controller.buildChatMsgUI(item);
                        },
                      ),
                    );
                  }),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SafeArea(
                    top: false,
                    child: ChatInputBar(
                      onSend: (text) => controller.sendText(text),
                      onAttach: controller.clickAddPhoto,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
