import 'package:flutter/material.dart';
import '../../../utils/utils/theme_color.dart';

/// FileName sort_button
///
/// @Author 谌文
/// @Date 2024/10/16 18:45
///
/// @Description 排序按钮
class SortButton extends StatelessWidget {
  const SortButton({
    Key? key,
    this.text,
    this.selected,
    this.desc,
    this.onTap,
  }) : super(key: key);

  /// 文案
  final String? text;

  /// 是否是选中状态
  final bool? selected;

  /// 排序状态
  final int? desc;

  /// 点击事件
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 26,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: selected == true
              ? ThemeColor.lightPurpleColor
              : ThemeColor.buttonGrayColor,
        ),
        padding: const EdgeInsets.only(left: 12, right: 7),
        child: Row(
          children: [
            Text(
              text ?? '',
              style: TextStyle(
                  color: selected == true
                      ? ThemeColor.blueBtnColor
                      : ThemeColor.mainTextColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 13),
            ),
            const SizedBox(width: 2),
            Image.asset(
                selected == false || desc == null
                    ? 'assets/image/common/common_sorter_nor@3x.png'
                    : (desc == 1
                        ? 'assets/image/common/common_sorter_up@3x.png'
                        : 'assets/image/common/common_sorter_down@3x.png'),
                width: 14,
                height: 14),
          ],
        ),
      ),
    );
  }
}
