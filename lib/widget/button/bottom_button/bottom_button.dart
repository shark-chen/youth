import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/extension/strings/strings.dart';
import '../../../utils/utils/click_utils.dart';
import '../../../utils/extension/text_styles.dart';
import '../../../utils/marco/marco.dart';
import '../../../utils/utils/theme_color.dart';

/// FileName bottom_button
///
/// @Author 谌文
/// @Date 2023/10/18 16:39
///
/// @Description 底部按钮
class BottomButton extends StatelessWidget {
  const BottomButton({
    Key? key,
    this.leftTitle,
    this.leftTitleColor,
    this.leftIcon,
    this.leftMargin = 16,
    this.leftTap,
    this.leftDecoration,
    this.leftEnable = true,
    this.rightTitle,
    this.rightTitleColor,
    this.rightIcon,
    this.rightMargin = 16,
    this.margin,
    this.rightTap,
    this.rightDecoration,
    this.rightEnable = true,
    this.width,
    this.height,
    this.color = Colors.white,
    this.circular = 5,
    this.buttonSpace = 9,
    this.showLine = true,
    this.wipePhoneXLeave = false,
    this.bottomPad,
    this.leftBtnFlex,
    this.rightBtnFlex,
    this.buttonWidget,
  }) : super(key: key);

  /// 左边标题
  final String? leftTitle;

  /// 左边标题字体颜色
  final Color? leftTitleColor;

  /// 左侧图标icon
  final Icon? leftIcon;

  /// 按钮左边距
  final double? leftMargin;

  /// Empty space to surround the [decoration] and [child].
  final EdgeInsetsGeometry? margin;

  /// 左边回调
  final VoidCallback? leftTap;

  /// 边框描述
  final BoxDecoration? leftDecoration;

  /// 左侧侧按钮是否可以点击
  final bool? leftEnable;

  /// 右边标题
  final String? rightTitle;

  /// 右边标题字体颜色
  final Color? rightTitleColor;

  /// 右侧图标icon
  final Icon? rightIcon;

  /// 按钮右边距
  final double? rightMargin;

  /// 右边回调
  final VoidCallback? rightTap;

  /// 边框描述
  final BoxDecoration? rightDecoration;

  /// 右侧按钮是否可以点击
  final bool? rightEnable;

  /// 宽度 默认屏幕框
  final double? width;

  /// 高度
  final double? height;

  /// 圆角
  final double? circular;

  /// 按钮之间的间隔
  final double? buttonSpace;

  /// 顶部分割线 默认显示
  final bool? showLine;

  /// 是否需要去除iPhoneX底部留白
  final bool? wipePhoneXLeave;

  /// 背景颜色
  final Color? color;

  /// 底部高度
  final double? bottomPad;

  /// 左按钮比例
  final int? leftBtnFlex;

  /// 右按钮比例
  final int? rightBtnFlex;

  /// 自定义 button
  final Widget? buttonWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? (72 + (bottomPad ?? bottomPadding)),
      width: (width ?? Get.width),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        border: Border(
          top: BorderSide(
              color: (showLine ?? true)
                  ? ThemeColor.lineColor
                  : Colors.transparent,
              width: 1),
        ),
      ),
      child: Container(
        height: 48,
        margin: margin ?? EdgeInsets.only(
            left: leftMargin ?? 16,
            right: rightMargin ?? 16,
            top: 12,
            bottom:
                (((height ?? 0) > 0) ? 0 : (bottomPad ?? bottomPadding)) + 12),
        child: buttonWidget ?? Row(
          children: [
            /// 左侧按钮
            Visibility(
              visible: (leftTitle?.length ?? 0) > 0,
              child: Expanded(
                flex: leftBtnFlex ?? 1,
                child: Container(
                  decoration: leftDecoration ??
                      BoxDecoration(
                        border:
                            Border.all(color: ThemeColor.threeDColor, width: 1),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                  child: leftIcon == null
                      ? textButton(
                          title: leftTitle,
                          enable: leftEnable,
                          titleColor:
                              leftTitleColor ?? ThemeColor.mainTextColor,
                          onTap: leftTap)
                      : iconButton(
                          title: leftTitle,
                          enable: leftEnable,
                          icon: leftIcon,
                          titleColor: leftTitleColor,
                          onTap: leftTap,
                        ),
                ),
              ),
            ),
            Visibility(
                visible: Strings.isNotEmpty(leftTitle) &&
                    Strings.isNotEmpty(rightTitle),
                child: const SizedBox(width: 9)),

            /// 右侧按钮
            Visibility(
              visible: (rightTitle?.length ?? 0) > 0,
              child: Expanded(
                flex: rightBtnFlex ?? 1,
                child: Container(
                  decoration: rightDecoration ??
                      BoxDecoration(
                        color: ThemeColor.blueColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                  child: rightIcon == null
                      ? textButton(
                          title: rightTitle,
                          enable: rightEnable,
                          titleColor: rightTitleColor,
                          onTap: rightTap)
                      : iconButton(
                          title: rightTitle,
                          enable: rightEnable,
                          icon: rightIcon,
                          titleColor: rightTitleColor,
                          onTap: rightTap,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 图标按钮
  Widget iconButton({
    String? title,
    Color? titleColor,
    Icon? icon,
    bool? enable,
    VoidCallback? onTap,
  }) {
    return TextButton.icon(
      style:
          ButtonStyle(overlayColor: MaterialStateProperty.resolveWith((states) {
        return Colors.transparent;
      })),
      icon: icon ?? const Icon(Icons.camera_alt, color: Colors.white),
      label: AutoSizeText(
        overflow: TextOverflow.ellipsis,
        minFontSize: 6,
        maxLines: 1,
        title ?? '',
        style: TextStyles(
            color: titleColor ?? Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500),
      ),
      onPressed: ClickUtils.debounce(enable == true ? onTap : null, 500),
    );
  }

  /// 字体按钮
  Widget textButton({
    String? title,
    Color? titleColor,
    bool? enable,
    VoidCallback? onTap,
  }) {
    return TextButton(
      style:
          ButtonStyle(overlayColor: MaterialStateProperty.resolveWith((states) {
        return Colors.transparent;
      })),
      onPressed: ClickUtils.debounce(enable == true ? onTap : null, 500),
      child: AutoSizeText(
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        minFontSize: 8,
        maxLines: 2,
        title ?? '',
        style: TextStyles(
            color: titleColor ?? Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
