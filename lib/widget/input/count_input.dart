import 'package:youth/base/base_controller.dart';

/// FileName count_input
///
/// @Author 谌文
/// @Date 2023/12/7 10:23
///
/// @Description 计数输入框
class CountInput extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _CountInput createState() => _CountInput();

  const CountInput({
    Key? key,
    this.color,
    this.height,
    this.maxHeight,
    this.maxLength,
    this.hint,
    this.autofocus = false,
    this.style,
    this.labelStyle,
    this.hintStyle,
    this.textAlign = TextAlign.left,
    this.controller,
    this.focusNode,
    this.onSubmitted,
    this.radius = 5.0,
    this.borderColor = ThemeColor.lineColor,
    this.borderWidth = 1,
  }) : super(key: key);

  /// 背景颜色
  final Color? color;

  /// 输入框的高度
  final double? height;

  /// 输入框最大高度
  final double? maxHeight;

  /// 最大字数
  final int? maxLength;

  /// 输入框提示语
  final String? hint;

  /// 是否自动聚焦
  final bool? autofocus;

  /// 输入框的字体大小颜色
  final TextStyle? style;

  /// 输入框的缺省字体大小颜色
  final TextStyle? labelStyle;

  /// 提示输入字体大小颜色
  final TextStyle? hintStyle;

  /// 文字对齐
  final TextAlign? textAlign;

  /// 输入框监控
  final TextEditingController? controller;

  final FocusNode? focusNode;

  /// 搜索回调输入框问题
  final ValueChanged<String>? onSubmitted;

  /// 圆角
  final double? radius;

  /// 边框颜色
  final Color? borderColor;

  /// 边框宽度
  final double? borderWidth;
}

class _CountInput extends State<CountInput> {
  /// 统计输入字符数
  int _textLength = 0;

  @override
  initState() {
    super.initState();
    if (widget.maxLength != null) {
      widget.controller?.addListener(_handleTextChange);
    }
  }

  @override
  void dispose() {
    // if (widget.maxLength != null) {
    //   widget.controller?.dispose();
    // }
    super.dispose();
  }

  void _handleTextChange() {
    setState(() {
      _textLength = widget.controller?.text.length ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        constraints: BoxConstraints(
          minHeight: widget.height ?? 45,
          maxHeight: widget.maxHeight ?? double.infinity,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.borderColor ?? Colors.grey, // 使用指定的边框颜色或默认灰色
            width: widget.borderWidth ?? 1,
          ),
          color: widget.color ?? Colors.white,
          borderRadius: BorderRadius.circular(widget.radius ?? 5.0),
        ),
        padding: EdgeInsets.only(
            left: 10, right: 6, bottom: (widget.maxLength != null ? 24 : 0)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextField(
                autofocus: widget.autofocus ?? false,
                maxLines: null,
                style: widget.style ??
                    const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 14),
                maxLength: widget.maxLength,
                textAlign: widget.textAlign ?? TextAlign.left,
                focusNode: widget.focusNode,
                onSubmitted: widget.onSubmitted,
                controller: widget.controller,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: -4, bottom: 0),
                    border: InputBorder.none,
                    labelStyle: widget.labelStyle,
                    hintText: widget.hint,
                    hintStyle: widget.hintStyle ??
                        const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                    counter: const Offstage()),
              )
            ],
          ),
        ),
      ),

      /// 字数计数器
      Visibility(
        visible: widget.maxLength != null,
        child: Positioned(
          bottom: 6,
          right: 12,
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              '${_textLength.toString()}/${widget.maxLength}',
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
