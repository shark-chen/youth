import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/utils/theme_color.dart';

/// FileName privacy_protocol_view
///
/// @Author 谌文
/// @Date 2024/7/9 10:26
///
/// @Description 隐私协议view
class PrivacyProtocolWidget extends StatelessWidget {
  const PrivacyProtocolWidget({
    Key? key,
    this.selected = false,
    this.selectTap,
    this.onTapUserAgreement,
    this.onTapPrivacyPolicy,
    this.onTapMinorProtection,
  }) : super(key: key);

  /// 是否同意
  final bool? selected;

  /// 选择同意协议点击
  final ValueChanged<bool?>? selectTap;

  /// 点击协议
  final VoidCallback? onTapUserAgreement;
  final VoidCallback? onTapPrivacyPolicy;
  final VoidCallback? onTapMinorProtection;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            checked: selected == true,
            child: Padding(
              padding: EdgeInsets.only(top: 1),
              child: SizedBox(
                width: 14,
                height: 14,
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: selectTap == null
                        ? null
                        : () {
                            selectTap!.call(!(selected == true));
                          },
                    customBorder: const CircleBorder(),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selected == true
                            ? ThemeColor.neonMintCheckboxFillColor
                            : Colors.transparent,
                        border: Border.all(
                          color: selected == true
                              ? Colors.transparent
                              : ThemeColor.themeA2Color,
                          width: 1.2,
                        ),
                      ),
                      child: selected == true
                          ? Center(
                              child: Icon(
                                Icons.check_rounded,
                                size: 12,
                                color: ThemeColor.themeBlackColor,
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 4),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: '我已阅读并同意',
                style: const TextStyle(
                    fontSize: 12, color: ThemeColor.themeA2Color),
                children: <TextSpan>[
                  TextSpan(
                    text: " ${'《用户协议》'.tr}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: ThemeColor.themeGreenColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = onTapUserAgreement,
                  ),
                  const TextSpan(
                    text: '、',
                    style: TextStyle(
                      fontSize: 12,
                      color: ThemeColor.themeA2Color,
                    ),
                  ),
                  TextSpan(
                    text: '《隐私政策》'.tr,
                    style: const TextStyle(
                      fontSize: 12,
                      color: ThemeColor.themeGreenColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = onTapPrivacyPolicy,
                  ),
                  const TextSpan(
                    text: '、',
                    style: TextStyle(
                      fontSize: 12,
                      color: ThemeColor.themeA2Color,
                    ),
                  ),
                  TextSpan(
                    text: '《未成年人个人信息保护规则》'.tr,
                    style: const TextStyle(
                      fontSize: 12,
                      color: ThemeColor.themeGreenColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = onTapMinorProtection,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
