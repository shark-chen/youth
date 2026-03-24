import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../generated/locales.g.dart';
import '../../../utils/marco/marco.dart';
import '../../../utils/utils/theme_color.dart';
import '../text_input.dart';

/// FileName commodity_input
///
/// @Author 谌文
/// @Date 2023/11/24 16:21
///
/// @Description 确认输入框-带PDA能力的
class SureInput extends StatelessWidget {
  const SureInput({
    Key? key,
    this.editingController,
    this.focusNode,
    this.padding,
    this.style,
    this.hintStyle,
    this.contentPadding,
    this.color,
    this.hintText,
    this.sureText,
    this.onSubmitted,
    this.hiddenKeyboard,
    this.clicksInputCall,
    this.selected = true,
    this.autofocus = true,
    this.inputKey,
    this.sureDecoration,
    this.sureStyle,
    this.enabled = true,
    this.inPutBorderColor,
  }) : super(key: key);

  /// 数据框输入监控
  final TextEditingController? editingController;

  /// 输入框聚焦监控
  final FocusNode? focusNode;

  /// 输入框的字体大小颜色
  final TextStyle? style;

  /// 输入框的hint字体大小颜色
  final TextStyle? hintStyle;

  /// 输入SKU的缺省提示语言
  final String? hintText;

  /// 输入框文本内边距
  final EdgeInsetsGeometry? contentPadding;

  /// 确定按钮文字
  final String? sureText;

  /// null.
  final Color? color;

  /// 确定按钮装饰
  final Decoration? sureDecoration;

  /// 确认文字style
  final TextStyle? sureStyle;

  /// 点击确认按钮回调
  final ValueChanged<String?>? onSubmitted;

  /// 是否隐藏键盘， 默认不隐藏
  final bool? hiddenKeyboard;

  /// 是否是用户自己点击输入框回调
  final ValueChanged<bool>? clicksInputCall;

  /// 是否默认选中 默认选中
  final bool? selected;

  /// 是否自动聚焦
  final bool? autofocus;

  final EdgeInsetsGeometry? padding;

  final GlobalKey? inputKey;

  /// 输入框是否可用
  final bool? enabled;

  /// 边框颜色
  final Color? inPutBorderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 20),
      color: color ?? Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: UITextInput(
            contentPadding: contentPadding ?? EdgeInsets.zero,
            enabled: enabled,
            inputKey: inputKey,
            borderColor: inPutBorderColor ?? ThemeColor.gradeFiveGreyColor,
            focusNode: focusNode,
            hiddenKeyboard: hiddenKeyboard,
            controller: editingController,
            inputClickTap: clicksInputCall,
            selected: selected,
            height: 40,
            autofocus: autofocus,
            textInputAction: TextInputAction.search,
            style: style ??
                TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ThemeColor.mainTextColor),
            hint: hintText,
            onSubmitted: onSubmitted,
            hintStyle: hintStyle ??
                TextStyle(
                    fontWeight: FontWeight.w500,
                    color: ThemeColor.ayzColor,
                    fontSize: style?.fontSize ?? 16),
          )),
          const SizedBox(width: 16),

          /// 确定按钮
          GestureDetector(
            onTap: () {
              onSubmitted?.call(editingController?.text ?? '');
              if (isIOS) {
                FocusManager.instance.primaryFocus?.unfocus();
              } else {
                SystemChannels.textInput.invokeMethod('TextInput.hide');
              }
            },
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              height: 40,
              alignment: Alignment.center,
              decoration: sureDecoration ??
                  BoxDecoration(
                    color: ThemeColor.blueColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
              child: Text(
                sureText ?? LocaleKeys.Confirm.tr,
                style: sureStyle ??
                    const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
