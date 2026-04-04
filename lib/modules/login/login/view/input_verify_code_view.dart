import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youth/utils/extension/strings/strings.dart';
import 'package:youth/utils/extension/text_styles.dart';
import '../../../../generated/locales.g.dart';
import '../../../../utils/utils/theme_color.dart';
import '../../../../widget/button/icon_button/icon_button.dart';
import '../../view/verify_error_view.dart';
import 'package:get/get.dart';

/// FileName input_verify_code_view
///
/// @Author 谌文
/// @Date 2024/7/8 16:38
///
/// @Description 输入框带验证码
class InputVerifyCodeWidget extends StatelessWidget {
  const InputVerifyCodeWidget({
    Key? key,
    this.hint,
    this.controller,
    this.error,
    this.focusNode,
    this.onFieldSubmittedTap,
    this.onTap,
    this.verifyCode,
  }) : super(key: key);

  /// 输入框监控
  final TextEditingController? controller;

  /// 输入框提示语
  final String? hint;

  /// 错误
  final String? error;

  /// 点击
  final VoidCallback? onTap;

  /// FocusNode
  final FocusNode? focusNode;

  /// 验证码
  final Uint8List? verifyCode;

  /// 点击事件
  final ValueChanged? onFieldSubmittedTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: ThemeColor.inputBgColor,
            borderRadius: BorderRadius.circular(24.0),
          ),
          padding: EdgeInsets.only(left: 18),
          child: Row(
            children: [
              /// 验证码输入框
              Expanded(
                child: TextFormField(
                  focusNode: focusNode,
                  onFieldSubmitted: onFieldSubmittedTap,
                  autocorrect: false,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ThemeColor.whiteColor,
                      fontSize: 16),
                  controller: controller,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                    LengthLimitingTextInputFormatter(8),
                  ],
                  maxLength: 30,
                  decoration: InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: TextStyle(
                        height: 1.0,
                        fontWeight: FontWeight.w500,
                        color: ThemeColor.whiteColor.withOpacity(0.4),
                        fontSize: 16),
                  ),
                ),
              ),

              /// 发送验证码
              GestureDetector(
                onTap: onTap,
                child: Container(
                  color: Colors.transparent,
                  height: 48,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 12, right: 20),
                  child: Text(
                    '发送验证码',
                    style: TextStyles(
                      color: ThemeColor.themeGreenColor,
                    ),
                  ),
                ),
              ),
            ],
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
