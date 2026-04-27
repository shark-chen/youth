import 'package:kellychat/base/base_controller.dart';
import 'package:kellychat/modules/modules.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

/// ListView组件的基础item
class BaseListItem extends StatelessWidget {
  /// 标题
  final String title;

  /// 标题文字样式
  final TextStyle? textStyle;

  /// 边距
  final EdgeInsetsGeometry? padding;

  /// 内容
  final String? content;

  /// 自定义内容
  final Widget? contentWidget;

  /// 内容最大行数
  final int? contentMaxLines;

  /// 内容文字样式
  final TextStyle? contentStyle;

  /// 底部分割线
  final bool line;

  /// 底部分割线
  final Color? splitLineColor;

  /// of a particular [ShapeDecoration], consider using a [ClipPath] widget.
  final Decoration? decoration;

  /// item的高
  final double? height;

  /// 右边
  final double? right;

  /// 是否展示箭头
  final bool? showArrow;

  /// 是否展示选中
  final bool? selected;

  /// 点击回调
  final VoidCallback? onTap;

  /// 是否展示复制
  final bool? showCopy;

  /// 是否展示开关按钮
  final bool? showSwitch;

  /// 开关按钮是否是打开状态
  final bool? switchOpen;

  /// 开关按钮点击
  final ValueChanged<bool>? switchTap;

  const BaseListItem({
    super.key,
    required this.title,
    this.content,
    this.contentMaxLines = 1,
    this.height = 48,
    this.right,
    this.padding,
    this.showArrow,
    this.selected = false,
    this.decoration,
    this.textStyle,
    this.contentStyle,
    this.splitLineColor = ThemeColor.lineColor,
    this.line = true,
    this.onTap,
    this.showCopy,
    this.showSwitch,
    this.switchOpen,
    this.switchTap,
    this.contentWidget,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: decoration ?? BoxDecoration(color: Colors.white),
        padding: padding ?? const EdgeInsets.only(left: 16),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(right: right ?? 16),
              height: (height ?? 48) - (line ? 1 : 0.0),
              child: Row(
                children: [
                  /// 左侧标题
                  Expanded(
                    flex: 10,
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textStyle ??
                          const TextStyle(
                              fontSize: 14,
                              color: ThemeColor.mainTextColor,
                              fontWeight: FontWeight.w400),
                    ),
                  ),
                  Expanded(child: Container()),

                  /// 右侧内容
                  contentWidget ??
                      Visibility(
                        visible: Strings.isNotEmpty(content),
                        child: Expanded(
                          flex: 15,
                          child: Text(
                            maxLines: contentMaxLines,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                            content ?? '',
                            style: contentStyle ??
                                const TextStyle(
                                    fontSize: 14,
                                    color: ThemeColor.otherTextColor,
                                    fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),

                  /// 是否展示右侧复制按钮
                  Visibility(
                    visible: Strings.isNotEmpty(content) && showCopy == true,
                    child: _buildCopyWidget(content),
                  ),

                  /// 是否展示选择开关
                  Visibility(
                    visible: showSwitch == true,
                    child: SizedBox(
                      height: 36,
                      child: Transform.scale(
                        scale: 0.8,
                        child: CupertinoSwitch(
                          value: switchOpen == true,
                          onChanged: switchTap,
                        ),
                      ),
                    ),
                  ),

                  /// 选中图标
                  Visibility(
                      visible: selected ?? false,
                      child: const Icon(Icons.check,
                          size: 25, color: ThemeColor.blueColor)),

                  /// 右箭头图标
                  Visibility(
                      visible: showArrow ?? Strings.isNotEmpty(content),
                      child: Image.asset(
                          "assets/image/common/common_right_arrow@3x.png",
                          width: 16,
                          height: 16,
                          color: ThemeColor.secondaryTextColor)),
                ],
              ),
            ),

            /// 分割线
            Container(
                height: line ? 1 : 0.0,
                color: splitLineColor ?? ThemeColor.lineColor)
          ],
        ),
      ),
    );
  }

  Widget _buildCopyWidget(String? content) {
    return GestureDetector(
      onTap: () {
        EasyLoading.showToast(LocaleKeys.copySuccessfully.tr);
        Clipboard.setData(ClipboardData(text: content ?? ''));
      },
      child: Row(
        children: [
          const SizedBox(width: 8),
          Image.asset('assets/image/common/common_copy@3x.png',
              color: ThemeColor.darkBlueColor, width: 24, height: 24),
        ],
      ),
    );
  }
}
