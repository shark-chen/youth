import 'package:flutter/material.dart';

/// FileName ellipsis_unfold_text
///
/// @Author 谌文
/// @Date 2025/4/23 10:46
///
/// @Description 这是第一行文本，这是第二行文... [展开]
class EllipsisUnfoldText extends StatefulWidget {
  const EllipsisUnfoldText({
    required this.text,
    this.maxLines = 2,
    this.textStyle,
    this.expandStyle,
    this.expandText,
    this.collapseText,
    Key? key,
  }) : super(key: key);

  final String text;
  final int maxLines;
  final TextStyle? textStyle;
  final TextStyle? expandStyle;
  final String? expandText;
  final String? collapseText;

  @override
  _EllipsisWithExpandTextState createState() => _EllipsisWithExpandTextState();
}

class _EllipsisWithExpandTextState extends State<EllipsisUnfoldText> {
  bool _isExpanded = false;
  bool _needsExpandButton = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        /// 检查文本是否需要截断
        final textSpan = TextSpan(text: widget.text, style: widget.textStyle);
        final textPainter = TextPainter(
          text: textSpan,
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout(maxWidth: constraints.maxWidth);

        // 判断是否需要显示 "展开" 按钮
        _needsExpandButton = textPainter.didExceedMaxLines;

        return GestureDetector(
          onTap: () {
            if (_needsExpandButton) {
              setState(() => _isExpanded = !_isExpanded);
            }
          },
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: _isExpanded
                      ? widget.text
                      : _needsExpandButton
                      ? widget.text.substring(
                    0,
                    textPainter.getPositionForOffset(Offset(
                      constraints.maxWidth,
                      textPainter.size.height,
                    )).offset,
                  ) + '... '
                      : widget.text,
                  style: widget.textStyle,
                ),
                if (_needsExpandButton && !_isExpanded)
                  TextSpan(
                    text: widget.expandText,
                    style: widget.expandStyle ??
                        TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                if (_needsExpandButton && _isExpanded)
                  TextSpan(
                    text: ' ${widget.collapseText}',
                    style: widget.expandStyle ??
                        TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
              ],
            ),
            maxLines: _isExpanded ? null : widget.maxLines,
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
    );
  }
}

/// 字符时候展示了...
bool isTextOverflowed({
  required String text,
  required TextStyle style,
  required double maxWidth,
  int? maxLines,
}) {
  final textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: maxLines,
    textDirection: TextDirection.ltr,
  )..layout(maxWidth: maxWidth);
  return textPainter.didExceedMaxLines;
}
