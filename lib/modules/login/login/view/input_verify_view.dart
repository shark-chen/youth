import 'package:flutter/material.dart';
import '../../../../utils/utils/theme_color.dart';
import '../../../../widget/input/text_input.dart';
import '../../view/verify_error_view.dart';

/// FileName input_verify_view
///
/// @Author 谌文
/// @Date 2024/7/8 15:52
///
/// @Description 登录校验输入框
class InputVerifyWidget extends StatelessWidget {
  const InputVerifyWidget({
    Key? key,
    this.hint,
    this.controller,
    this.error,
    this.onTap,
  }) : super(key: key);

  /// 输入框监控
  final TextEditingController? controller;

  /// 输入框提示语
  final String? hint;

  /// 错误
  final String? error;

  /// 点击输入框
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UITextInput(
          radius: 6,
          selected: false,
          autocorrect: false,
          height: 44,
          hint: hint,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              color: ThemeColor.mainTextColor,
              fontSize: 16),
          hintStyle: TextStyle(
              height: 1.0,
              fontWeight: FontWeight.w500,
              color: ThemeColor.secondaryTextColor,
              fontSize: 16),
          controller: controller,
          color: ThemeColor.graynessBgColor,
          inputClickTap: (_) => onTap?.call(),
        ),
        VerifyErrorWidget(title: error)
      ],
    );
  }
}
