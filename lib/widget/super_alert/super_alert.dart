import 'view/super_alert_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'view/super_result_widget.dart';

/// FileName super_alert
///
/// @Author 谌文
/// @Date 2024/3/4 20:49
///
/// @Description 有成功有失败列表弹框
class SuperAlert {
  /// 底部列表弹框
  /// context: 上下文
  /// title: 标题
  /// list: 弹框数据源
  static Future show({
    String? title,
    String? subTitle,
    List<String>? contents,
    String? subTwoTitle,
    List<String>? subContents,
    String? leftTitle,
    VoidCallback? leftTap,
    String? rightTitle,
    VoidCallback? rightTap,
  }) async {
    return await showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) => SuperAlertWidget(
        title: title,
        subTitle: subTitle,
        contents: contents,
        subTwoTitle: subTwoTitle,
        subContents: subContents,
        leftTitle: leftTitle,
        leftTap: leftTap,
        rightTitle: rightTitle,
        rightTap: rightTap,
      ),
    );
  }

  /// 中间位置弹框
  /// context: 上下文
  /// title: 标题
  /// list: 弹框数据源
  static Future showResult({
    String? title,
    bool? succeed = true,
    String? leftTitle,
    VoidCallback? leftTap,
    String? rightTitle,
    VoidCallback? rightTap,
  }) async {
    return await showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) => SuperResultWidget(
        title: title,
        succeed: succeed,
        leftTitle: leftTitle,
        leftTap: leftTap,
        rightTitle: rightTitle,
        rightTap: rightTap,
      ),
    );
  }
}
