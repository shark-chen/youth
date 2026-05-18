import 'package:kellychat/base/base_stateless_widget.dart';

/// FileName: user_label_info_view
///
/// @Author 谌文
/// @Date 2026/3/16 23:23
///
/// @Description 用户标签信息- view
class UserLabelInfoWidget extends BaseStatelessWidget {
  const UserLabelInfoWidget({
    Key? key,
    required this.labels,
  }) : super(key: key);

  /// 标签数组
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: labels.map((e) {
          return Container(
            padding: EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: ThemeColor.inputBgColor,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add),
                SizedBox(width: 3),
                Text(
                  e,
                  style: TextStyles(
                    color: ThemeColor.whiteColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
