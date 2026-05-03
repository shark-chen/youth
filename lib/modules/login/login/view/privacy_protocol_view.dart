import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kellychat/base/base_controller.dart';
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
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: SizedBox(
              width: 16,
              height: 16,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Checkbox(
                  checkColor: ThemeColor.themeBlackColor,
                  fillColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return ThemeColor.neonMintCheckboxFillColor;
                    }
                    return Colors.transparent;
                  }),
                  shape: const CircleBorder(),
                  side: const BorderSide(
                    color: ThemeColor.themeA2Color,
                    width: 1.2,
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity),
                  onChanged: selectTap,
                  value: selected,
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
