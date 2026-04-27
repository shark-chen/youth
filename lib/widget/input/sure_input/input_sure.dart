import 'package:kellychat/utils/utils/click_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../utils/marco/marco.dart';
import '../../../utils/utils/theme_color.dart';
import '../text_input.dart';

/// FileName input_sure
///
/// @Author 谌文
/// @Date 2024/11/1 11:32
///
/// @Description 输入确定输入框 -带PDA能力的
class InputSure extends StatelessWidget {
  const InputSure({
    Key? key,
    this.controller,
    this.focusNode,
    this.padding,
    this.height = 44,
    this.radius = 6,
    this.borderWidth = 1.0,
    this.borderColor = ThemeColor.gradeFiveGreyColor,
    this.style,
    this.color,
    this.inputColor,
    this.hintText,
    this.sureText,
    this.onSubmitted,
    this.hiddenKeyboard = false,
    this.inputFormatters,
    this.keyboardType,
    this.textInputAction,
    this.contentPadding,
    this.inputClickTap,
    this.selected = true,
    this.autofocus = true,
    this.inputKey,
    this.sureDecoration,
    this.sureStyle,
    this.customSureWidget,
    this.enabled,
  }) : super(key: key);

  /// 数据框输入监控
  final TextEditingController? controller;

  /// 输入框聚焦监控
  final FocusNode? focusNode;

  /// 输入框的字体大小颜色
  final TextStyle? style;

  /// 输入框部分的高度
  final double? height;

  /// 输入SKU的缺省提示语言
  final String? hintText;

  /// 确定按钮文字
  final String? sureText;

  /// null.
  final Color? color;

  /// 输入框的颜色.
  final Color? inputColor;

  /// 圆角
  final double? radius;

  /// 边框颜色
  final Color? borderColor;

  /// 边框宽度
  final double? borderWidth;

  /// 确定按钮装饰
  final Decoration? sureDecoration;

  /// 确认文字style
  final TextStyle? sureStyle;

  /// 点击确认按钮回调
  final ValueChanged<String?>? onSubmitted;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  final TextInputType? keyboardType;

  final TextInputAction? textInputAction;

  /// 是否隐藏键盘， 默认不隐藏
  final bool? hiddenKeyboard;

  /// 是否是用户自己点击输入框回调
  final ValueChanged<bool>? inputClickTap;

  /// 是否默认选中 默认选中
  final bool? selected;

  /// 是否自动聚焦
  final bool? autofocus;

  final EdgeInsetsGeometry? padding;

  final GlobalKey? inputKey;

  /// 输入框文本内边距
  final EdgeInsetsGeometry? contentPadding;

  /// 自定义确定按钮
  final Widget? customSureWidget;

  /// 输入框是否可用
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          const EdgeInsets.only(left: 12, right: 12, top: 0, bottom: 0),
      color: color ?? Colors.transparent,
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: borderColor ?? ThemeColor.lineColor,
              width: borderWidth ?? 1),
          color: inputColor ?? Colors.white,
          borderRadius: BorderRadius.circular(radius ?? 6.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: UITextInput(
                enabled: enabled,
                color: inputColor,
                borderWidth: 0,
                inputKey: inputKey,
                focusNode: focusNode,
                hiddenKeyboard: hiddenKeyboard,
                keyboardType: keyboardType,
                controller: controller,
                inputClickTap: inputClickTap,
                selected: selected,
                height: height,
                autofocus: autofocus,
                inputFormatters: inputFormatters,
                textInputAction: textInputAction ?? TextInputAction.search,
                borderColor: Colors.transparent,
                radius: radius,
                contentPadding: contentPadding,
                style: style ??
                    TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: ThemeColor.mainTextColor),
                hint: hintText,
                onSubmitted: onSubmitted,
              ),
            ),

            /// 确定按钮
            customSureWidget ??
                GestureDetector(
                  onTap: ClickUtils.debounce(
                    () {
                      try {
                        if (isIOS) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        } else {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                        }
                      } catch (_) {}
                      onSubmitted?.call(controller?.text ?? '');
                    },
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 11, right: 11, top: 4, bottom: 4),
                    height: (height ?? 44) - 8,
                    alignment: Alignment.center,
                    decoration: sureDecoration ??
                        BoxDecoration(
                          color: ThemeColor.blueColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                    child: Image.asset(
                        color: ThemeColor.whiteColor,
                        "assets/image/common/common_search_icon@3x.png",
                        width: 20,
                        height: 20),
                  ),
                ),
            SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}
