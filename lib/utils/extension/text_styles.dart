import 'package:flutter/material.dart';

/// FileName text_style
///
/// @Author 谌文
/// @Date 2024/10/24 19:04
///
/// @Description 字体
TextStyle? TextStyles({
  FontWeight? fontWeight = FontWeight.w400,
  Color? color = const Color(0xFF313033),
  double? fontSize = 14,
  String? fontFamily,
  double? height,
}) {
  return TextStyle(
    fontWeight: fontWeight,
    color: color,
    fontSize: fontSize,
    fontFamily: fontFamily,
    height: height,
  );
}
