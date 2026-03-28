import 'package:flutter/services.dart';
import 'package:youth/base/base_stateless_widget.dart';
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
        Container(
          alignment: Alignment.centerLeft,
          height: 48,
          decoration: BoxDecoration(
            color: ThemeColor.inputBgColor,
            borderRadius: BorderRadius.circular(24),
          ),
          padding: EdgeInsets.only(left: 18),
          child: TextFormField(
            onFieldSubmitted: onFieldSubmittedTap,
            autocorrect: false,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: ThemeColor.whiteColor,
                fontSize: 16),
            controller: controller,
            focusNode: focusNode,
            keyboardType: TextInputType.visiblePassword,
            maxLength: 50,
            onTap: inputTap,
            decoration: InputDecoration(
              isDense: true,
              counterText: '',
              border: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: ThemeColor.whiteColor.withOpacity(0.4),
                  fontSize: 16),
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
