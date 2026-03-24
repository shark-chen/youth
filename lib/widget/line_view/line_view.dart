import 'package:flutter/material.dart';

import '../../utils/utils/theme_color.dart';

/// FileName line_view
///
/// @Author 谌文
/// @Date 2024/6/19 19:27
///
/// @Description 线view
class LineView extends StatelessWidget {
  const LineView({
    Key? key,
    this.height = 1,
    this.padding,
    this.lineColor,
    this.color,
  }) : super(key: key);

  /// 颜色
  final Color? color;

  /// 线颜色
  final Color? lineColor;

  /// 线高
  final double? height;

  /// This padding is in addition to any padding inherent in the [decoration];
  /// see [Decoration.padding].
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Colors.white,
      height: height,
      padding: padding ?? EdgeInsets.only(left: 12, right: 12),
      child: Container(color: lineColor ?? ThemeColor.lineColor, height: height),
    );
  }
}
