export 'package:flutter/material.dart';
import 'package:youth/base/base_page.dart';
import 'package:youth/widget/bottom_alert/view/sheet_view.dart';
import 'view/dialog_view.dart';

/// FileName bottom_dialog
///
/// @Author 谌文
/// @Date 2024/2/27 14:33
///
/// @Description 底部弹窗
class BottomDialog {
  /// 底部弹框
  /// context: 上下文
  /// title: 标题
  /// list: 弹框数据源
  /// customWidget: 自定义UI
  /// isDismissible: 点击背景是否关闭弹框, true: 点击背景关闭
  static Future show(
    BuildContext context, {
    String? title,
    TextStyle? titleStyle,
    List<String>? list,
    Widget? customWidget,
    bool? showBottomButton = true,
    bool? isDismissible = true,
    bool? showClose = false,
    VoidCallback? cancelTap,
    VoidCallback? confirmTap,
    double? minHeight = 100,
  }) async {
    return await showModalBottomSheet(
        isDismissible: isDismissible ?? true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return DialogWidget(
            title: title,
            titleStyle: titleStyle,
            list: list,
            customWidget: customWidget,
            cancelTap: cancelTap,
            confirmTap: confirmTap,
            showBottomButton: showBottomButton,
            showClose: showClose,
            isDismissible: isDismissible,
            minHeight: minHeight,
          );
        },
        context: context);
  }

  /// 中间位置列表弹框
  /// context: 上下文
  /// list: 弹框数据源
  /// customWidget: 自定义UI
  /// showBottomBtn： 是否展示底部按钮
  static Future centerShow<T extends BubbleModel>(
    BuildContext context, {
    String? title,
    double? height = 350,
    bool? isDismissible = true,
    List<T>? list,
    Function(int index, T t)? selectOnTap,
    Widget? customWidget,
    String? defaultTitle,
    bool? showBottomBtn,
    String? leftTitle,
    String? rightTitle,
    bool? showCloseBtn = true,
    VoidCallback? closeTap,
    VoidCallback? cancelTap,
    VoidCallback? confirmTap,
  }) {
    return showDialog(
        barrierDismissible: isDismissible ?? true,
        builder: (BuildContext context) {
          return SheetView(
            title: title,
            list: list,
            height: height,
            width: screenWidth * 0.5,
            customWidget: customWidget,
            defaultTitle: defaultTitle,
            showBottomBtn: showBottomBtn,
            leftTitle: leftTitle,
            rightTitle: rightTitle,
            showCloseBtn: showCloseBtn,
            closeTap: closeTap,
            cancelTap: cancelTap ?? Get.back,
            confirmTap: confirmTap,
            centrePop: true,
            selectOnTap: (int index, BubbleModel? model) {
              selectOnTap?.call(index, model as T);
              Get.back();
            },
          );
        },
        context: context);
  }
}
