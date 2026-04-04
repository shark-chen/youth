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
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            content ?? '',
            style: TextStyles(
              fontSize: 12,
              color: ThemeColor.whiteColor.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
