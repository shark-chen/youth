import 'package:youth/tripartite_library/camera/camera_engine/camera_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../generated/locales.g.dart';
import '../../utils/extension/strings/strings.dart';
import '../../utils/utils/theme_color.dart';

enum DefaultSpaceType {
  netError,
  noData,
}

/// 搜索无内容提示view
class DefaultSpaceWidget extends StatelessWidget {
  const DefaultSpaceWidget({
    super.key,
    this.prompt,
    this.showRefreshBtn = false,
    this.refreshTitle,
    this.titleStyle,
    this.textAlign,
    this.color,
    this.logo,
    this.showLogo = true,
    this.spaceType,
    this.onTap,
  });

  /// 提示语言
  final String? prompt;

  /// 点击刷新回调
  final VoidCallback? onTap;

  /// 是否展示 刷新按钮, 默认不显示
  final bool? showRefreshBtn;

  /// 刷新按钮文案, 默认文案 重试
  final String? refreshTitle;

  /// 标题字体
  final TextStyle? titleStyle;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// 样式，只对图片起作用，不同模式会展示不同的默认图片
  final DefaultSpaceType? spaceType;

  /// 图片, 设置才会生效，不设置会使用默认的，设置了图片，spaceType就不生效了
  final String? logo;
  final bool? showLogo;

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: color ?? ThemeColor.thinGrayColor,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// 资源图片,spaceType：不同模式会展示不同的默认图片， 设置了logo图片，spaceType就不生效了，
            Visibility(
              visible: showLogo == true,
              child: Image.asset(
                  (Strings.isNotEmpty(logo))
                      ? (logo ?? '')
                      : (((spaceType ?? DefaultSpaceType.noData) ==
                              DefaultSpaceType.noData)
                          ? 'assets/image/icons/resource_empty@3x.png'
                          : 'assets/image/icons/network_error@3x.png'),
                  width: 180,
                  height: 130, errorBuilder: (
                BuildContext context,
                Object error,
                StackTrace? stackTrace,
              ) {
                return Image.asset(
                    (((spaceType ?? DefaultSpaceType.noData) ==
                            DefaultSpaceType.noData)
                        ? 'assets/image/icons/resource_empty@3x.png'
                        : 'assets/image/icons/network_error@3x.png'),
                    width: 180,
                    height: 130);
              }),
            ),
            const SizedBox(height: 10),

            /// 提示文案
            Container(
              padding: const EdgeInsets.only(left: 60, right: 60),
              child: Text(
                  prompt ??
                      ((spaceType == DefaultSpaceType.noData)
                          ? LocaleKeys.NoData.tr
                          : LocaleKeys.NetworkError.tr),
                  style: titleStyle ??
                      const TextStyle(
                          color: ThemeColor.secondaryTextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 13),
                  textAlign: textAlign ?? TextAlign.center),
            ),
            const SizedBox(height: 24),

            /// 刷新按钮
            (showRefreshBtn ?? false)
                ? Container(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 3, bottom: 3),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ThemeColor.blueBtnColor,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(refreshTitle ?? LocaleKeys.TryAgain.tr,
                        textAlign: TextAlign.center, // 居中对齐
                        style: const TextStyle(
                            color: ThemeColor.blueBtnColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14)))
                : Container(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
