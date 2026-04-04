import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../generated/locales.g.dart';
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
    this.onTap,
  }) : super(key: key);

  /// 是否同意
  final bool? selected;

  /// 选择同意协议点击
  final ValueChanged<bool?>? selectTap;

  /// 点击协议
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Checkbox(
              checkColor: ThemeColor.themeGreenColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(14)),
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity),
              onChanged: selectTap,
              value: selected,
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
                    text: " ${'《用户协议》、《隐私政策》、《未成年人个人信息保护规则》'.tr}",
                    style: const TextStyle(
                      fontSize: 13,
                      color: ThemeColor.themeGreenColor,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = onTap,
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
