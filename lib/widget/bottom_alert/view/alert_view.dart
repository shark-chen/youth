import 'package:youth/base/base_stateless_widget.dart';
import 'package:flutter/services.dart';

/// FileName result_view
///
/// @Author 谌文
/// @Date 2025/2/21 14:16
///
/// @Description 操作结果view
class AlertWidget extends BaseStatelessWidget {
  const AlertWidget({
    Key? key,
    this.title,
    this.titleBottomLine = false,
    this.titleStyle,
    this.content,
    this.showCloseBtn = true,
    this.closeTap,
    this.leftTitle,
    this.leftTap,
    this.rightTitle,
    this.rightTap,
    this.customWidget,
    this.minHeight = 100,
    this.maxHeight,
    this.isDismissible = true,
    this.scrollController,
    this.topPadding,
  }) : super(key: key);

  /// 标题
  final String? title;

  /// 是否显示标题底部的下划线
  final bool? titleBottomLine;

  /// 标题字体
  final TextStyle? titleStyle;

  /// 内容
  final String? content;

  /// 是否展示关闭按钮
  final bool? showCloseBtn;

  /// 关闭按钮点击
  final VoidCallback? closeTap;

  /// 底部按钮左边标题文案
  final String? leftTitle;

  /// 左边按钮点击
  final VoidCallback? leftTap;

  /// 底部按钮右边边标题文案
  final String? rightTitle;

  /// 右边按钮点击
  final VoidCallback? rightTap;

  /// 自定义UI
  final Widget? customWidget;

  /// 最小高度
  final double? minHeight;

  /// 最大高度
  final double? maxHeight;

  /// 点击背景是否关闭弹框
  final bool? isDismissible;

  /// 滚动控制
  final ScrollController? scrollController;

  /// see [Decoration.padding].
  final EdgeInsetsGeometry? topPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: isDismissible == true ? (closeTap ?? Get.back) : null,
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        Container(
          padding: topPadding ??
              ((Strings.isNotEmpty(title) || (showCloseBtn ?? true))
                  ? EdgeInsets.only(top: 8)
                  : EdgeInsets.only(top: 24)),
          width: Get.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              /// 标题，兼容PDA按enter键盘
              KeyboardListener(
                focusNode: FocusNode(),
                autofocus: true,
                onKeyEvent: (rawKeyEvent) {
                  if (rawKeyEvent.runtimeType == KeyDownEvent &&
                      rawKeyEvent.logicalKey == LogicalKeyboardKey.enter) {}
                },
                child: titleWidget(),
              ),

              /// 可滚动
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: maxHeight ?? screenHeight * 0.45,
                    minHeight: minHeight ?? 100),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [customWidget ?? Container()],
                  ),
                ),
              ),

              SizedBox(height: 8),

              /// 底部确定按钮
              Visibility(
                visible: (Strings.isNotEmpty(leftTitle) ||
                    leftTap != null ||
                    Strings.isNotEmpty(rightTitle) ||
                    rightTap != null),
                child: BottomButton(
                  showLine: false,
                  leftTitle: leftTitle ??
                      (leftTap != null ? LocaleKeys.Cancel.tr : ''),
                  leftTap: leftTap,
                  rightTitle: rightTitle ??
                      (rightTap != null ? LocaleKeys.Confirm.tr : ''),
                  rightTap: rightTap,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget titleWidget() {
    return Visibility(
      visible: Strings.isNotEmpty(title) || (showCloseBtn ?? true),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          border: titleBottomLine == true
              ? Border(
                  bottom: BorderSide(color: ThemeColor.lineColor, width: 1.0),
                )
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 40),
            Expanded(child: Container()),
            Expanded(
              flex: 100,
              child: Text(
                title ?? '',
                textAlign: TextAlign.center,
                style: titleStyle ??
                    const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: ThemeColor.mainTextColor),
              ),
            ),
            Expanded(child: Container()),
            Visibility(
              visible: showCloseBtn ?? true,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                  closeTap?.call();
                },
                child: const Icon(
                  Icons.close,
                  color: ThemeColor.mainTextColor,
                  size: 20,
                ),
              ),
            ),
            SizedBox(width: (showCloseBtn ?? true) ? 16 : 40),
          ],
        ),
      ),
    );
  }
}
