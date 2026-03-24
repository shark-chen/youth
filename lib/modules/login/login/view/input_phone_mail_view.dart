import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../utils/utils/theme_color.dart';
import '../../view/verify_error_view.dart';

/// FileName input_phone_view
///
/// @Author 谌文
/// @Date 2024/7/9 11:30
///
/// @Description 手机号输入验证
class InputPhoneMailWidget extends StatelessWidget {
  const InputPhoneMailWidget({
    Key? key,
    this.title,
    this.error,
    this.hint,
    this.showArea = false,
    this.onTap,
    this.inputTap,
    this.onFieldSubmittedTap,
    this.controller,
    this.focusNode,
    this.inputFormatters,
    this.keyboardType,
  }) : super(key: key);

  /// 标题
  final String? title;

  /// 错误
  final String? error;

  /// 是否展示区号
  final bool? showArea;

  /// 点击事件
  final VoidCallback? onTap;

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
          decoration: BoxDecoration(
            border: Border.all(color: ThemeColor.lineColor, width: 1),
            color: ThemeColor.graynessBgColor,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            children: [
              Visibility(
                visible: showArea ?? false,
                child: GestureDetector(
                  onTap: onTap,
                  child: Container(
                    width: 84,
                    color: ThemeColor.loginFormBackColor,
                    height: 45,
                    child: Row(
                      children: [
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            textAlign: TextAlign.center,
                            title ?? '',
                            style: const TextStyle(
                                color: ThemeColor.mainTextColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                        ),
                        Image.asset(
                            "assets/image/order/order_black_arrows_down@3x.png",
                            width: 12,
                            height: 12),
                        const SizedBox(width: 12),
                        Container(
                            height: 22,
                            width: 1,
                            color: ThemeColor.threeDColor),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: 44,
                  padding: EdgeInsets.only(left: 12),
                  child: TextFormField(
                    onFieldSubmitted: onFieldSubmittedTap,
                    autocorrect: false,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: ThemeColor.mainTextColor,
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
                          color: ThemeColor.secondaryTextColor,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        VerifyErrorWidget(title: error),
      ],
    );
  }
}
