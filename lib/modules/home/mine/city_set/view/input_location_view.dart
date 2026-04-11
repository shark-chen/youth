import 'package:flutter/services.dart';
import 'package:youth/base/base_stateless_widget.dart';
import 'package:youth/modules/login/view/verify_error_view.dart';

/// FileName: input_location_view
///
/// @Author 谌文
/// @Date 2026/3/26 22:40
///
/// @Description 地区位置选择输入框
class InputLocationWidget extends BaseStatelessWidget {
  const InputLocationWidget({
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
    return Container(
      alignment: Alignment.center,
      height: 48,
      decoration: BoxDecoration(
        color: ThemeColor.inputBgColor,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: EdgeInsets.only(left: 18),
      margin: EdgeInsets.only(left: 24, right: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.locationDot,
            color: ThemeColor.iconBlackColor,
            size: 20,
          ),
          SizedBox(width: 8),
          Expanded(
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
                    color: ThemeColor.whiteColor.withOpacity(0.6),
                    fontSize: 16),
              ),
            ),
          ),
          FaIcon(
            FontAwesomeIcons.locationCrosshairs,
            color: ThemeColor.themeGreenColor,
            size: 22,
          ),
          SizedBox(width: 16),
          Visibility(
            visible: Strings.isNotEmpty(error),
            child: VerifyErrorWidget(title: error),
          ),
        ],
      ),
    );
  }
}
