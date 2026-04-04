import 'package:youth/base/base_stateless_widget.dart';
import 'card_stack_view.dart';

/// FileName: find_friend_prompt_view
///
/// @Author 谌文
/// @Date 2026/3/29 20:33
///
/// @Description 找朋友提示语-view
class FindFriendPromptWidget extends BaseStatelessWidget {
  const FindFriendPromptWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 46),

        /// AI找人的icon
        Image.asset(
          "assets/image/common/hello@3x.png",
          width: 125,
          height: 78,
        ),
        SizedBox(height: 25),
        Text(
          'Hi,中午好',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '输入想找的人，AI智能匹配～',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}
