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
    this.error,
    this.controller,
    this.focusNode,
    this.onFieldSubmittedTap,
    this.sendSmsTitle,
    this.sendSmsEnable,
    this.sendSmsTap,
  }) : super(key: key);

  /// 输入框提示语
  final String? hint;

  /// 错误
  final String? error;

  /// 输入框监控
  final TextEditingController? controller;

  /// FocusNode
  final FocusNode? focusNode;

  /// 点击事件
  final ValueChanged? onFieldSubmittedTap;

  /// 发送验证码标题
  final String? sendSmsTitle;

  /// 发送验证码是否可用
  final bool? sendSmsEnable;

  /// 发送验证码点击
  final VoidCallback? sendSmsTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
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
            LengthLimitingTextInputFormatter(9),
          ],
          maxLength: 30,
          decoration: InputDecoration(
            counterText: '',
            hintText: hint,
            filled: true,
            isDense: true,
            fillColor: ThemeColor.inputBgColor,
            hintStyle: TextStyle(
                height: 1.0,
                fontWeight: FontWeight.w500,
                color: ThemeColor.whiteColor.withOpacity(0.4),
                fontSize: 16),
            contentPadding: EdgeInsets.only(left: 16, top: 12, bottom: 12),
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
            suffixIcon: Align(
              alignment: Alignment.centerRight,
              widthFactor: 1,
              child: GestureDetector(
                onTap: sendSmsTap,
                child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Text(
                    sendSmsTitle ?? '发送验证码',
                    style: TextStyles(
                      color: true == sendSmsEnable
                          ? ThemeColor.themeGreenColor
                          : ThemeColor.white6Color,
                    ),
                  ),
                ),
              ),
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
