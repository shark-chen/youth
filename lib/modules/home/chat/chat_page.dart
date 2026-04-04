import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:youth/base/base_page.dart';
import 'chat_controller.dart';
import 'package:youth/tripartite_library/tripartite_library.dart';

/// FileName: chat_page
///
/// @Author 谌文
/// @Date 2026/3/17 23:56
///
/// @Description 实际聊天窗口-page-页面
class ChatPage extends BasePage<ChatController> {
  ChatPage({Key? key}) : super(key: key);

  Duration duration = new Duration();
  Duration position = new Duration();
  bool isPlaying = false;
  bool isLoading = false;
  bool isPause = false;

  @override
  Widget build(BuildContext context) {
    final now = new DateTime.now();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ThemeColor.themeColor,
      appBar: AppBarKit.appBar(controller.title ?? '', elevation: 0.2),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: <Widget>[

                BubbleNormalAudio(
                  color: Color(0xFFE8E8EE),
                  duration: duration.inSeconds.toDouble(),
                  position: position.inSeconds.toDouble(),
                  isPlaying: isPlaying,
                  isLoading: isLoading,
                  isPause: isPause,
                  onSeekChanged: (_) {},
                  onPlayPauseButtonClick: () {},
                  sent: true,
                ),

                ChatBaseWidget(
                  text: 'bubble normalailnormalailnormalailnormalail',
                  isSender: true,
                  tail: true,
                  sent: true,
                ),
                ChatBaseWidget(
                  text:
                      'bubble normal with tailnormalailnormalailnormalailnormalailnormalailnormalail',
                  isSender: true,
                  showPortrait: false,
                  // tail: true,

                ),
                DateChip(
                  date: new DateTime(now.year, now.month, now.day - 2),
                ),
                ChatBaseWidget(
                  text: 'bubble normal without tail',
                  isSender: false,
                  tail: false,

                ),
                ChatBaseWidget(
                  text: 'bubble normal without tail',
                  tail: false,
                  sent: true,
                  seen: true,
                  delivered: true,

                ),
                ChatBaseWidget(
                  text: 'bubble special one with tail',
                  isSender: false,

                ),


                DateChip(
                  date: now,
                ),

              ],
            ),
          ),
          MessageBar(
            onSend: (_) => print(_),
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
