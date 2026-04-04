import 'package:youth/base/base_stateless_widget.dart';
import 'package:flutter/services.dart';
import 'package:youth/utils/extension/input_formatter/zero_input_formatter.dart';

/// 加减输入框
// ignore: must_be_immutable
class IncreaseDecreaseInput extends BaseStatelessWidget {
  IncreaseDecreaseInput({
    super.key,
    required this.num,
    this.editingController,
    this.focusNode,
    this.height = 24,
    this.onTap,
    this.bgIconColor,
    this.iconTapUsable = true,
    this.actionPadding,
    this.actionSize,
    this.actionDecoration,
    this.inputWidth,
    this.inputStyle,
    this.inputWidthIsAuto,
    this.inputFormatters,
  });

  /// 数量
  final String? num;
  final double? height;
  final TextEditingController? editingController;
  final FocusNode? focusNode;

  /// 加减操作项的 padding
  final EdgeInsetsGeometry? actionPadding;

  /// 加减操作项的尺寸，正方形，此字段应用于宽高
  final double? actionSize;

  /// 加减操作项的盒子装饰
  final Decoration? actionDecoration;

  /// 输入框的宽度
  final double? inputWidth;

  /// 输入框样式
  final TextStyle? inputStyle;

  /// 输入框的宽度是否自动撑开
  final bool? inputWidthIsAuto;

  final VoidCallback? onTap;

  /// icon背景颜色
  final Color? bgIconColor;

  /// icon不可点击
  final bool? iconTapUsable;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    final iptBasic = Container(
      width: inputWidth ?? 56,
      height: height ?? 26,
      alignment: Alignment.center,
      child: TextField(
        controller: editingController,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.datetime,
        inputFormatters: inputFormatters ?? [
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        ],
        style: inputStyle ?? const TextStyle(
          color: ThemeColor.mainTextColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        onTap: () {
          if (Strings.isNotEmpty(editingController?.text)) {
            editingController?.selection = TextSelection.fromPosition(
                TextPosition(offset: editingController?.text.length ?? 0));
          }
          onTap?.call();
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          fillColor: Colors.white,
          filled: true,
          isDense: true,
          contentPadding: EdgeInsets.all(4),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );

    final iptWidget = inputWidthIsAuto == true
        ? Expanded(
            child: iptBasic,
          )
        : iptBasic;

    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: ThemeColor.gradeFiveGreyColor, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            child: Container(
              padding: actionPadding ?? const EdgeInsets.all(2),
              width: actionSize ?? 24,
              height: actionSize ?? 24,
              color: bgIconColor,
              decoration: actionDecoration,
              child: Image.asset(
                color: iconTapUsable == true ? null : ThemeColor.threeDColor,
                fit: BoxFit.contain,
                'assets/image/icons/decrease@2x.png',
                width: 18,
                height: 18,
              ),
            ),
            onTap: () {
              if (iconTapUsable != true) return;
              int num = (int.tryParse(editingController?.text ?? '0') ?? 0) - 1;
              editingController?.text = "${num > 0 ? num : 0}";
              if (Strings.isNotEmpty(editingController?.text)) {
                editingController?.selection = TextSelection.fromPosition(
                    TextPosition(offset: editingController?.text.length ?? 0));
              }
            },
          ),
          Container(
            width: 1,
            height: height ?? 24,
            color: ThemeColor.gradeFiveGreyColor,
          ),
          iptWidget,
          Container(
            width: 1,
            height: height ?? 24,
            color: ThemeColor.gradeFiveGreyColor,
          ),
          GestureDetector(
            child: Container(
              color: bgIconColor,
              padding: actionPadding ?? const EdgeInsets.all(2),
              width: actionSize ?? 24,
              height: actionSize ?? 24,
              decoration: actionDecoration,
              child: Image.asset(
                fit: BoxFit.fill,
                'assets/image/icons/increase@2x.png',
                width: 18,
                height: 18,
              ),
            ),
            onTap: () {
              editingController?.text =
                  "${(int.tryParse(editingController?.text ?? '0') ?? 0) + 1}";
              if (Strings.isNotEmpty(editingController?.text)) {
                editingController?.selection = TextSelection.fromPosition(
                    TextPosition(offset: editingController?.text.length ?? 0));
              }
            },
          )
        ],
      ),
    );
  }
}
