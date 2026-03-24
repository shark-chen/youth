import 'custom_alert.dart';
import '../../generated/locales.g.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

/// FileName alert
///
/// @Author 谌文
/// @Date 2024/2/29 14:34
///
/// @Description 对话弹框
class Alert {
  /// 底部列表弹框
  /// physical: 是否是物理键返回
  /// context: 上下文
  /// title: 标题
  /// list: 弹框数据源
  static Future show({
    String? title,
    String? leftTitle,
    String? rightTitle,
    List<String?>? contentList,
    bool? physical,
    VoidCallback? cancelTap,
    VoidCallback? sureTap,
    Widget? customWidget,
    List<DialogAction>? actions,
  }) async {
    if (physical == true) {
      showCustomAlert(
        DialogMessageModel(
          contentList: contentList,
          customWidget: customWidget,
          title: title,
          actions: actions ??
              [
                DialogAction(
                    text: leftTitle ?? LocaleKeys.Cancel.tr,
                    color: "#000000",
                    onPressed: cancelTap),
                DialogAction(
                  text: rightTitle ?? LocaleKeys.Confirm.tr,
                  actionType: ActionType.done,
                  color: "#ff0000",
                  onPressed: sureTap,
                )
              ],
        ),
      );
    } else {
      await showCustomAlert(
        DialogMessageModel(
          contentList: contentList,
          customWidget: customWidget,
          title: title,
          actions: actions ??
              [
                DialogAction(
                    text: leftTitle ?? LocaleKeys.Cancel.tr,
                    color: "#000000",
                    onPressed: cancelTap),
                DialogAction(
                  text: rightTitle ?? LocaleKeys.Confirm.tr,
                  actionType: ActionType.done,
                  color: "#ff0000",
                  onPressed: sureTap,
                )
              ],
        ),
      );
    }
  }
}
