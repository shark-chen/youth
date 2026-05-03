import 'package:flutter/material.dart';
import 'package:kellychat/utils/utils/theme_color.dart';

/// 编辑资料-生日滚轮单项样式
class EditBirthdayPickerCell extends StatelessWidget {
  const EditBirthdayPickerCell({
    super.key,
    this.text,
    this.selected,
  });

  final String? text;
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
              : ThemeColor.whiteColor.withOpacity(0.38),
        ),
      ),
    );
  }
}
