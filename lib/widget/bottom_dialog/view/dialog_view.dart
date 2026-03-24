export 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../base/base_stateless_widget.dart';

/// FileName dialog_view
///
/// @Author 谌文
/// @Date 2024/2/27 14:46
///
/// @Description 底部
class DialogWidget extends BaseStatelessWidget {
  const DialogWidget({
    Key? key,
    this.title,
    this.titleStyle,
    this.list,
    this.cancelTap,
    this.confirmTap,
    this.minHeight = 100,
    this.customWidget,
    this.showBottomButton = true,
    this.showClose = false,
    this.isDismissible = true,
  }) : super(key: key);

  /// 标题
  final String? title;

  /// replace the closest enclosing [DefaultTextStyle].
  final TextStyle? titleStyle;

  /// 标题
  final List<String>? list;

  /// 取消事件
  final VoidCallback? cancelTap;

  /// 确定事件
  final VoidCallback? confirmTap;

  /// 最小高度
  final double? minHeight;

  /// 自定义view
  final Widget? customWidget;

  /// 是否展示底部按钮
  final bool? showBottomButton;

  /// 是否展示关闭按钮
  final bool? showClose;

  /// 点击背景是否关闭弹框
  final bool? isDismissible;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: isDismissible == true ? (cancelTap ?? Get.back) : null,
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        Container(
          padding: (Strings.isNotEmpty(title) || (showClose ?? true))
              ? EdgeInsets.only(top: 8)
              : EdgeInsets.only(top: 24),
          width: Get.width,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              KeyboardListener(
                focusNode: FocusNode(),
                autofocus: true,
                onKeyEvent: (rawKeyEvent) {
                  if (rawKeyEvent.runtimeType == KeyDownEvent &&
                      rawKeyEvent.logicalKey == LogicalKeyboardKey.enter) {
                    confirmTap?.call();
                  }
                },
                child: titleWidget(),
              ),

              SizedBox(height: 8),

              /// 列表
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: screenHeight * 0.35,
                    minHeight: minHeight ?? 100),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      customWidget ??
                          ConstrainedBox(
                            constraints: BoxConstraints(
                                maxHeight: screenHeight * 0.35,
                                minHeight: minHeight ?? 100),
                            child: ListView.builder(
                              itemCount: list?.length ?? 0,
                              padding: EdgeInsets.only(left: 16, right: 16),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 2, bottom: 2),
                                  child: Text(
                                    list?[index] ?? '',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: ThemeColor.mainTextColor),
                                  ),
                                );
                              },
                            ),
                          ),
                    ],
                  ),
                ),
              ),

              /// 列表部分
              Visibility(
                visible: showBottomButton ?? true,
                child: BottomButton(
                  showLine: false,
                  leftTitle: LocaleKeys.Cancel.tr,
                  leftTap: cancelTap,
                  rightTitle: LocaleKeys.Confirm.tr,
                  rightTap: confirmTap,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget titleWidget() {
    return Visibility(
      visible: Strings.isNotEmpty(title) || (showClose ?? true),
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 40),
            Expanded(child: Container()),
            Expanded(
              flex: 100,
              child: Text(
                textAlign: TextAlign.center,
                title ?? '',
                style: titleStyle ??
                    const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: ThemeColor.mainTextColor),
              ),
            ),
            Expanded(child: Container()),
            Visibility(
              visible: showClose ?? true,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                  cancelTap?.call();
                },
                child: const Icon(
                  Icons.close,
                  color: ThemeColor.mainTextColor,
                  size: 20,
                ),
              ),
            ),
            SizedBox(width: (showClose ?? true) ? 16 : 40),
          ],
        ),
      ),
    );
  }
}
