import 'package:flutter/material.dart';
import '../strings/strings.dart';

extension ColorUtil on Color {
  static Color parseColor(String colorString) {
    if (Strings.isEmpty(colorString)) {
      return Colors.white;
    }
    colorString = colorString.toUpperCase().replaceAll('#', '');
    if (colorString.length == 6) {
      colorString = 'FF' + colorString;
    }
    Color color = Colors.white;
    try {
      color = Color(int.tryParse(colorString, radix: 16) ?? 0XFF000000);
    } catch (error) {
      return Colors.white;
    }
    return color;
  }
}
