import 'package:kellychat/base/base_stateless_widget.dart';

/// FileName: find_friend_prompt_view
///
/// @Author 谌文
/// @Date 2026/3/29 20:33
///
/// @Description 找朋友提示语-view

/// 「Hi, 」与昵称之间有空格；昵称最多展示 10 字，超出加省略号。
String _greetingHiLine(String? niceName) {
  final raw = niceName?.trim() ?? '';
  if (raw.isEmpty) {
    return 'Hi,';
  }
  var display = raw;
  if (display.length > 10) {
    display = '${display.substring(0, 10)}...';
  }
  return 'Hi, $display';
}

class FindFriendPromptWidget extends BaseStatelessWidget {
  const FindFriendPromptWidget({
    Key? key,
    this.niceName,
  }) : super(key: key);

  /// 昵称
  final String? niceName;

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
          _greetingHiLine(niceName),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '描述你想找的人，AI智能匹配～',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}
