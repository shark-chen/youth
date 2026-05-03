import 'package:kellychat/base/base_page.dart';
import 'package:kellychat/modules/user/user_center/user_center.dart';
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
    return Scaffold(
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
                  final myId = UserCenter().user?.id ?? 0;
                  final list = controller.messages;
                  return ListView.builder(
                    padding: EdgeInsets.only(
                      bottom: bottomInset + inputReserve + 8,
                    ),
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
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
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SafeArea(
                  top: false,
                  child: ChatInputBar(
                    onSend: (text) => controller.sendText(text),
                    onAttach: () {
                      // TODO: 相册 / 更多入口
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
