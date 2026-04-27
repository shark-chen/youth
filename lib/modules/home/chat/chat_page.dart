import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:youth/base/base_page.dart';
import 'chat_controller.dart';
import 'package:youth/modules/user/user_center/user_center.dart';

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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ThemeColor.themeColor,
      appBar: AppBarKit.appBar(controller.title ?? '', elevation: 0.2),
      body: Stack(
        children: [
          Obx(() {
            final myId = UserCenter().user?.id ?? 0;
            final list = controller.messages;
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: list.length,
              itemBuilder: (context, index) {
                final m = list[index];
                final from = m.fromUserId ?? 0;
                final isSender = from == myId && myId != 0;
                final content = m.content ?? '';
                final createdAt = m.createdAtText;
                return Column(
                  children: [
                    if (createdAt.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Text(
                          createdAt,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.black54,
                                  ),
                        ),
                      ),
                    ChatBaseWidget(
                      text: content,
                      isSender: isSender,
                      tail: true,
                    ),
                  ],
                );
              },
            );
          }),
          MessageBar(
            onSend: (text) => controller.sendText(text),
            actions: [
              InkWell(
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 24,
                ),
                onTap: () {},
              ),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: InkWell(
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.green,
                    size: 24,
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
