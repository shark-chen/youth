import 'package:youth/base/base_stateless_widget.dart';

/// FileName: user_introduce_view
///
/// @Author 谌文
/// @Date 2026/3/16 23:29
///
/// @Description 用户介绍语- view
class UserIntroduceWidget extends BaseStatelessWidget {
  const UserIntroduceWidget({
    Key? key,
    this.title,
    this.content,
  }) : super(key: key);

  /// 标题
  final String? title;

  /// 内容
  final String? content;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? '',
            style: TextStyles(
              color: ThemeColor.whiteColor,
            ),
          ),
          SizedBox(height: 6),
          Container(
            padding: EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
            decoration: BoxDecoration(
              color: ThemeColor.loginFormTextColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              content ?? '',
              style: TextStyles(
                color: ThemeColor.whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
