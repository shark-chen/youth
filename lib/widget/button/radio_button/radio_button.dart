import 'package:flutter/material.dart';

/// FileName radio_button
///
/// @Author 谌文
/// @Date 2024/11/5 20:07
///
/// @Description 圆圈选择按钮
class RadioButton extends StatelessWidget {
  const RadioButton({
    Key? key,
    this.outerSize = 18,
    this.selected = true,
    this.borderWidth = 1,
    this.innerSize = 8,
    this.onTap,
    this.selectedColor = const Color(0xFF4635AB),
    this.unselectColor = const Color(0xFFE5E5E5),
  }) : super(key: key);

  /// 是否选中
  final bool? selected;

  /// 选择点击
  final VoidCallback? onTap;

  /// 外圈大小
  final double? outerSize;

  /// 外圈边线宽度
  final double? borderWidth;

  /// 内圈大小
  final double? innerSize;

  /// 选中的颜色
  final Color? selectedColor;

  /// 选中的颜色
  final Color? unselectColor;

  @override
  Widget build(BuildContext context) {
    Color color = (selected == true ? selectedColor : unselectColor) ??
        const Color(0xFF4635AB);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: outerSize,
        width: outerSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular((outerSize ?? 18) * 0.5),
          border: Border.all(color: color, width: borderWidth ?? 1),
        ),
        child: Visibility(
          visible: selected == true,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular((innerSize ?? 8) * 0.5),
                color: color),
            height: innerSize,
            width: innerSize,
          ),
        ),
      ),
    );
  }
}
