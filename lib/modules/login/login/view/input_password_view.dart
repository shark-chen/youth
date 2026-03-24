import 'package:flutter/material.dart';
import '../../../../utils/utils/theme_color.dart';
import '../../view/verify_error_view.dart';

/// FileName input_password_view
///
/// @Author 谌文
/// @Date 2024/7/9 15:04
///
/// @Description 密码输入
class InputPasswordWidget extends StatelessWidget {
  const InputPasswordWidget({
    Key? key,
    this.hint,
    this.controller,
    this.obscureText = true,
    this.error,
    this.focusNode,
    this.onFieldSubmittedTap,
    this.onTap,
  }) : super(key: key);

  /// 输入框监控
  final TextEditingController? controller;

  /// 输入框提示语
  final String? hint;

  /// 错误
  final String? error;

  /// 是否是隐藏密码
  final bool? obscureText;

  /// FocusNode
  final FocusNode? focusNode;

  /// 点击事件
  final VoidCallback? onTap;

  /// 点击事件
  final ValueChanged? onFieldSubmittedTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 44,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: ThemeColor.graynessBgColor,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 12),
            child: TextFormField(
              focusNode: focusNode,
              onFieldSubmitted: onFieldSubmittedTap,
              autocorrect: false,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: ThemeColor.mainTextColor,
                  fontSize: 16),
              controller: controller,
              keyboardType: TextInputType.visiblePassword,
              maxLength: 30,
              obscureText: obscureText ?? true,
              decoration: InputDecoration(
                counterText: '',
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: ThemeColor.secondaryTextColor,
                    fontSize: 16),
                suffixIcon: IconButton(
                  alignment: Alignment.centerRight,
                  icon: SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset(
                        obscureText == true
                            ? 'assets/image/icons/hide@2x.png'
                            : 'assets/image/icons/show@2x.png',
                        width: 24,
                        height: 24),
                  ),
                  onPressed: onTap,
                ),
              ),
            ),
          ),
        ),
        VerifyErrorWidget(title: error)
      ],
    );
  }
}
