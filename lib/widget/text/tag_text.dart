import 'package:kellychat/utils/extension/text_styles.dart';
import 'package:kellychat/utils/utils/theme_color.dart';
import 'package:flutter/material.dart';

/// FileName: tag_text
///
/// @Author 侯占峰
/// @Date 2025/11/22 17:31
///
/// @Description 某些需要有一个背景，通常作为标签的形式展示
/// 这里临时写几个，后续有时间可以统一一下tag标签相关的颜色，现在 UI 每次出图颜色都不一致
enum TagColor {
  lightRed,
  lightGreen,
  lightYellow,
}

class TagText extends StatelessWidget {
  TagText({
    required this.text,
    this.tagColor,
    this.bgColor,
    this.fontColor,
    this.padding,
  });

  /// 文案
  final String text;

  /// 类型颜色，会根据传递的类型，生产预制的背景色和字体颜色
  final TagColor? tagColor;

  /// 自定义背景色
  final Color? bgColor;

  /// 自定义字体颜色
  final Color? fontColor;

  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    Color? _bgColor;
    Color? _fontColor;

    switch (tagColor) {
      case TagColor.lightGreen:
        _bgColor = ThemeColor.successBgColor;
        _fontColor = ThemeColor.greenCapColor;
        break;
      case TagColor.lightRed:
        _bgColor = ThemeColor.errorBgColor;
        _fontColor = ThemeColor.brightRedColor;
        break;
      case TagColor.lightYellow:
        _bgColor = ThemeColor.yellowBgColor;
        _fontColor = ThemeColor.yellowFontColor;
        break;
      default:
        _bgColor = bgColor;
        _fontColor = fontColor;
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: padding ?? const EdgeInsets.only(left: 8, right: 8),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyles(
              color: _fontColor,
            ),
          )
        ],
      ),
    );
  }
}
