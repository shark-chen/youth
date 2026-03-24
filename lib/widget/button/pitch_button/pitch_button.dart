import 'package:flutter/material.dart';
import '../../../utils/utils/theme_color.dart';

/// FileName pitch_button
///
/// @Author 谌文
/// @Date 2024/3/6 13:41
///
/// @Description 带边框选中背景颜色的button
class PitchButton extends StatelessWidget {
  const PitchButton({
    Key? key,
    this.title,
    this.selected,
    this.width,
    this.height = 32,
    this.padding,
    this.onTap,
  }) : super(key: key);

  /// 标题
  final String? title;

  /// 是否选中
  final bool? selected;

  /// 宽度
  final double? width;

  /// 高度
  final double? height;

  /// 边框
  final EdgeInsetsGeometry? padding;

  /// 点击事件
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: padding ?? const EdgeInsets.only(left: 10, right: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
              color: selected == true
                  ? ThemeColor.cambridgeBlueColor
                  : ThemeColor.bgGray2Color,
              width: 1),
          color: selected == true
              ? ThemeColor.lightPurpleColor
              : ThemeColor.bgGray2Color,
          borderRadius:
          BorderRadius.all(Radius.circular(((height ?? 32) + 4) / 2)),
        ),
        child: Text(
          overflow: TextOverflow.ellipsis,
           title ?? '',
          style: TextStyle(
              color: selected == true
                  ? ThemeColor.blueColor
                  : ThemeColor.mainTextColor,
              fontSize: 13,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
