import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kellychat/utils/utils/theme_color.dart';

class PrivacyProtocolBottomSheet extends StatelessWidget {
  const PrivacyProtocolBottomSheet({
    super.key,
    required this.onTapUserAgreement,
    required this.onTapPrivacyPolicy,
    required this.onTapMinorProtection,
    required this.onDisagree,
    required this.onAgree,
  });

  final VoidCallback onTapUserAgreement;
  final VoidCallback onTapPrivacyPolicy;
  final VoidCallback onTapMinorProtection;
  final VoidCallback onDisagree;
  final VoidCallback onAgree;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 6),
        child: Container(
          height: 176,
          padding: const EdgeInsets.only(left: 24, top: 32, right: 24),
          decoration: BoxDecoration(
            color: ThemeColor.doingListCellBgColor,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: '${'我已阅读并同意'.tr} ',
                  style: const TextStyle(
                    fontSize: 14,
                    color: ThemeColor.themeA2Color,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '《用户协议》'.tr,
                      style: const TextStyle(
                        fontSize: 14,
                        color: ThemeColor.themeGreenColor,
                        fontWeight: FontWeight.w500,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = onTapUserAgreement,
                    ),
                    const TextSpan(
                      text: '、',
                      style: TextStyle(fontSize: 13, color: ThemeColor.themeA2Color),
                    ),
                    TextSpan(
                      text: '《隐私政策》'.tr,
                      style: const TextStyle(
                        fontSize: 14,
                        color: ThemeColor.themeGreenColor,
                        fontWeight: FontWeight.w500,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = onTapPrivacyPolicy,
                    ),
                    const TextSpan(
                      text: '、',
                      style: TextStyle(fontSize: 14, color: ThemeColor.themeA2Color),
                    ),
                    TextSpan(
                      text: '《未成年人个人信息保护规则》'.tr,
                      style: const TextStyle(
                        fontSize: 14,
                        color: ThemeColor.themeGreenColor,
                        fontWeight: FontWeight.w500,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = onTapMinorProtection,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: _SheetButton(
                      title: '不同意'.tr,
                      backgroundColor: ThemeColor.whiteColor.withOpacity(0.2),
                      textColor: Colors.white,
                      onTap: onDisagree,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SheetButton(
                      title: '同意'.tr,
                      backgroundColor: ThemeColor.themeGreenColor,
                      textColor: ThemeColor.themeColor,
                      onTap: onAgree,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SheetButton extends StatelessWidget {
  const _SheetButton({
    required this.title,
    required this.backgroundColor,
    required this.textColor,
    required this.onTap,
  });

  final String title;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          height: 42,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

