import 'package:kellychat/base/base_stateless_widget.dart';

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
    this.tags,
  }) : super(key: key);

  /// 标题
  final String? title;

  /// 标签
  final List<String>? tags;

  @override
  Widget build(BuildContext context) {
    if (Lists.isEmpty(tags)) {
      return Text(
        '暂无标签',
        style: TextStyles(
          fontSize: 12,
          color: ThemeColor.whiteColor.withOpacity(0.6),
        ),
      );
    }
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: (tags ?? []).map(
        (e) {
          return Container(
            padding: EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: ThemeColor.inputBgColor,
            ),
            child: Text(
              e,
              style: TextStyles(
                color: ThemeColor.whiteColor,
                fontSize: 12,
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
