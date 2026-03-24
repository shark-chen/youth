import 'package:flutter/material.dart';

/// FileName highlight_text
///
/// @Author 谌文
/// @Date 2024/10/29 15:13
///
/// @Description 某些字体高亮字体啥的不一样
class HighlightText extends StatelessWidget {
  HighlightText({
    this.text,
    this.style,
    this.highlightWord,
    this.highlightStyle,
  });

  /// 文案
  final String? text;

  /// 文案样式
  final TextStyle? style;

  /// 高亮文案
  final String? highlightWord;

  /// 高亮文案样式
  final TextStyle? highlightStyle;

  @override
  Widget build(BuildContext context) {
    /// 通过分割文本找到需要高亮显示的部分
    List<TextSpan> spans = [];
    int start = 0;
    int index = (text ?? '').indexOf(highlightWord ?? '', start);

    while (index != -1) {
      /// 添加之前的普通文本
      if (index > start) {
        spans.add(TextSpan(
          text: text?.substring(start, index),
          style: TextStyle(color: Colors.black),
        ));
      }

      /// 添加高亮文本
      spans.add(TextSpan(
        text: highlightWord,
        style: highlightStyle,
      ));

      start = index + (highlightWord?.length ?? 0);
      index = (text ?? '').indexOf(highlightWord ?? '', start);
    }

    /// 添加最后的普通文本
    if (start < (text?.length ?? 0)) {
      spans.add(TextSpan(
        text: text?.substring(start),
        style: style,
      ));
    }

    return RichText(
      text: TextSpan(
        children: spans,
        style: style,
      ),
    );
  }
}
