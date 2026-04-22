import 'package:flutter/services.dart';
import 'package:youth/base/base_stateless_widget.dart';
import 'package:youth/utils/extension/input_formatter/zero_input_formatter.dart';
import '../../view/verify_error_view.dart';

/// FileName input_phone_view
///
/// @Author 谌文
/// @Date 2024/7/9 11:30
///
/// @Description 手机号输入验证
class InputPhoneMailWidget extends BaseStatelessWidget {
  const InputPhoneMailWidget({
    Key? key,
    this.error,
    this.hint,
    this.inputTap,
    this.onFieldSubmittedTap,
    this.controller,
    this.focusNode,
    this.inputFormatters,
    this.keyboardType,
  }) : super(key: key);

  /// 错误
  final String? error;

  /// 输入框点击
  final VoidCallback? inputTap;

  /// 输入框点击
  final ValueChanged? onFieldSubmittedTap;

  /// 输入框监控
  final TextEditingController? controller;

  /// FocusNode
  final FocusNode? focusNode;

  /// 输入框提示语
  final String? hint;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          onFieldSubmitted: onFieldSubmittedTap,
          autocorrect: false,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: ThemeColor.whiteColor,
              fontSize: 16),
          controller: controller,
          focusNode: focusNode,
          keyboardType: TextInputType.number,
          maxLength: 50,
          onTap: inputTap,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
            LengthLimitingTextInputFormatter(11),
            ZeroInputFormatter(),
          ],
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            counterText: '',
            fillColor: ThemeColor.inputBgColor,
            hintText: hint,
            hintStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: ThemeColor.whiteColor.withOpacity(0.4),
                fontSize: 16),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ThemeColor.themeGreenColor.withOpacity(0.3),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),
        Visibility(
          visible: Strings.isNotEmpty(error),
          child: VerifyErrorWidget(title: error),
        ),
      ],
    );
  }
}
