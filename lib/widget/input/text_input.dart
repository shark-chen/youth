import 'package:youth/base/base_page.dart';
import 'package:flutter/services.dart';

/// FileName text_input
///
/// @Author 谌文
/// @Date 2023/11/7 10:14
///
/// @Description 待边框的输入框-具有PDA能力的
class UITextInput extends StatelessWidget {
  UITextInput({
    Key? key,
    this.height = 48,
    this.color = Colors.white,
    this.radius = 5.0,
    this.style,
    this.hintStyle,
    this.borderColor = ThemeColor.lineColor,
    this.borderWidth = 1.0,
    this.padding,
    this.textAlign,
    this.hiddenKeyboard = false,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLength,
    this.showCounter = true,
    this.hint,
    this.prefixText,
    this.prefix,
    this.controller,
    this.focusNode,
    this.textInputAction,
    this.keyboardType,
    this.inputFormatters,
    this.onSubmitted,
    this.inputClickTap,
    this.selected = true,
    this.enabled,
    this.inputKey,
    this.contentPadding,
    this.onChanged,
    this.autocorrect = true,
    this.autofillHints = const <String>[],
    this.prefixIcon,
    this.suffixIcon,
    this.suffixText,
    this.suffixStyle,
    this.newShow = false,
  }) : super(key: key);

  /// 背景颜色 默认白色
  final Color? color;

  /// 输入框的高度
  final double? height;

  /// 圆角
  final double? radius;

  /// 边框颜色
  final Color? borderColor;

  /// 边框宽度
  final double? borderWidth;

  final TextAlign? textAlign;

  /// 输入框的字体大小颜色
  final TextStyle? style;

  /// 提示输入字体大小颜色
  final TextStyle? hintStyle;

  /// Empty space to inscribe inside the [decoration]. The [child], if any, is
  final EdgeInsetsGeometry? padding;

  final TextInputType? keyboardType;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  final TextInputAction? textInputAction;

  /// 搜索回调输入框问题
  final ValueChanged<String>? onSubmitted;

  /// 输入框提示语
  final String? hint;

  /// 左侧提示语
  final String? prefixText;
  final Widget? prefixIcon;
  final Widget? prefix;

  /// 输入框自定义图标
  final Widget? suffixIcon;
  final String? suffixText;
  final TextStyle? suffixStyle;

  /// 是否隐藏键盘， 默认不隐藏
  final bool? hiddenKeyboard;

  /// 输入框监控
  final TextEditingController? controller;

  final FocusNode? focusNode;

  /// 是否自动聚焦
  final bool? autofocus;

  /// 是否是可读
  final bool? readOnly;

  /// 输入框可输入最大长度
  final int? maxLength;

  /// 是否展示输入框底数字数计数
  final bool? showCounter;

  /// 是否是用户自己点击输入框回调
  final ValueChanged<bool>? inputClickTap;

  /// 是否默认选中 默认选中
  final bool? selected;

  /// 输入框是否可用
  final bool? enabled;

  final GlobalKey? inputKey;

  /// 输入框文本内边距
  final EdgeInsetsGeometry? contentPadding;

  /// 输入框值变化
  final ValueChanged<String?>? onChanged;

  /// {@macro flutter.widgets.editableText.autocorrect}
  final bool autocorrect;

  /// {@macro flutter.widgets.editableText.autofillHints}
  /// {@macro flutter.services.AutofillConfiguration.autofillHints}
  final Iterable<String>? autofillHints;

  /// 完全就是为了减少影响加的，公共类加了一行代码，知己上线怕，影响太大，所以加一个参数
  final bool newShow;

  @override
  Widget build(BuildContext context) {
    var container = Container(
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
            color: borderColor ?? ThemeColor.lineColor,
            width: borderWidth ?? 1),
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(radius ?? 6.0),
      ),
      padding: padding ?? EdgeInsets.only(left: 12, right: 12),
      child: ClipRRect(
        child: TextField(
          autofillHints: autofillHints,
          onChanged: onChanged,
          showCursor: true,
          maxLength: maxLength,
          clipBehavior: Clip.none,
          key: inputKey,
          style: style,
          autocorrect: autocorrect,
          textAlign: textAlign ?? TextAlign.left,
          textAlignVertical: TextAlignVertical.center,
          textInputAction: textInputAction ?? TextInputAction.search,
          focusNode: focusNode,
          onSubmitted: (value) {
            /// 有破PDA，扫描后会在内容后面加个空格，无语了，这里统一去除下
            controller?.text = value.trim();
            onSubmitted?.call(value.trim());
          },
          autofocus: autofocus ?? false,
          controller: controller,
          // showKeyboard: hiddenKeyboard == true ? false : true,
          readOnly: readOnly ?? false,
          enabled: enabled,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          onTap: () {
            if (selected == true) {
              controller?.selection = TextSelection(
                  baseOffset: 0, extentOffset: controller?.text.length ?? 0);
            }
            inputClickTap?.call(true);
          },
          decoration: InputDecoration(
            contentPadding: contentPadding,
            prefixText: prefixText,
            prefix: prefix,
            prefixIcon: prefixIcon,
            prefixIconConstraints: BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            suffixIcon: suffixIcon,
            suffixText: suffixText,
            suffixStyle: suffixStyle,
            isDense: true,
            prefixStyle: hintStyle ??
                TextStyle(
                    fontWeight: FontWeight.w500,
                    color: ThemeColor.ayzColor,
                    fontSize: style?.fontSize ?? 14),
            counterText: showCounter == true ? null : '',
            border: InputBorder.none,
            labelStyle: style,
            hintText: hint,
            hintStyle: hintStyle ??
                TextStyle(
                    fontWeight: FontWeight.w500,
                    color: ThemeColor.ayzColor,
                    fontSize: style?.fontSize ?? 14),
          ),
        ),
      ),
    );
    try {
      if (autofocus == true) {
        FocusScope.of(context).requestFocus(focusNode);
      }
      if (hiddenKeyboard == true) {
        Future.delayed(const Duration(),
            () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
      } else if (newShow == true) {
        Future.delayed(const Duration(),
            () => SystemChannels.textInput.invokeMethod('TextInput.show'));
      }
    } catch (_) {}
    return container;
  }
}
