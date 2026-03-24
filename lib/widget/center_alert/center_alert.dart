import 'package:flutter/material.dart';
import 'view/center_alert_view.dart';

/// FileName: center_alert
///
/// @Author 谌文
/// @Date 2026/1/22 18:38
///
/// @Description 中间弹框
class CenterAlert {
  static Future show(
    BuildContext context, {
    bool? barrierDismissible = true,
    String? title,
    String? content,
    String? leftTitle,
    String? rightTitle,
    VoidCallback? leftTap,
    VoidCallback? rightTap,
  }) async {
    await showDialog(
      barrierDismissible: barrierDismissible ?? false,
      context: context,
      builder: (BuildContext context) {
        return CenterAlertWidget(
          title: title,
          content: content,
          leftTitle: leftTitle,
          rightTitle: rightTitle,
          leftTap: leftTap,
          rightTap: rightTap,
        );
      },
    );
  }
}
