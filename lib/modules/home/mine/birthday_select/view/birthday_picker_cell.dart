import 'package:kellychat/base/base_stateless_widget.dart';

/// FileName: birthday_picker_cell
///
/// @Author 谌文
/// @Date 2026/4/6 22:59
///
/// @Description 日期选择-cell
class BirthdayPickerCell extends BaseStatelessWidget {
  const BirthdayPickerCell({
    Key? key,
    this.text,
    this.selected,
  }) : super(key: key);

  /// 标题
  final String? text;

  /// 是否选中
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text ?? '',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: true == selected
              ? ThemeColor.themeGreenColor
              : ThemeColor.themeA2Color,
        ),
      ),
    );
  }
}
