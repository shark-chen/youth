import 'package:auto_size_text/auto_size_text.dart';
import 'package:kellychat/base/base_stateless_widget.dart';
import 'package:flutter/services.dart';

/// FileName super_result_widget
///
/// @Author 谌文
/// @Date 2025/3/27 19:58
///
/// @Description
class SuperResultWidget extends BaseStatelessWidget {
  const SuperResultWidget({
    Key? key,
    this.title,
    this.succeed = true,
    this.leftTitle,
    this.leftTap,
    this.rightTitle,
    this.rightTap,
  }) : super(key: key);

  /// 标题
  final String? title;

  /// 成功失败
  final bool? succeed;

  /// 左边按钮标题
  final String? leftTitle;

  /// 确定点击按钮事件
  final VoidCallback? leftTap;

  /// 右边按钮标题
  final String? rightTitle;

  /// 确定点击按钮事件
  final VoidCallback? rightTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Expanded(child: Container()),
          Container(
            width: screenWidth - 80,
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// 图标
                Image.asset(
                    succeed == true
                        ? 'assets/image/common/toast_success@3x.png'
                        : 'assets/image/icons/toast_error@3x.png',
                    width: 42,
                    height: 42),
                const SizedBox(height: 20),

                /// 正标题
                Text(
                  title ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: ThemeColor.mainTextColor),
                ),
                const SizedBox(height: 24),

                /// 底部的确定取消按钮
                Row(
                  children: [
                    Visibility(
                      visible: Strings.isNotEmpty(leftTitle),
                      child: Container(
                        width: screenWidth / 2 - 65,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: ThemeColor.threeDColor, width: 1),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextButton(
                          style: ButtonStyle(overlayColor:
                              MaterialStateProperty.resolveWith((states) {
                            return Colors.transparent;
                          })),
                          onPressed: leftTap ?? Get.back,
                          child: AutoSizeText(
                            maxLines: 1,
                            leftTitle ?? LocaleKeys.Cancel.tr,
                            style: const TextStyle(
                                color: ThemeColor.mainTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: Strings.isNotEmpty(leftTitle),
                      child: const SizedBox(width: 10),
                    ),
                    Container(
                      width: Strings.isNotEmpty(leftTitle)
                          ? screenWidth / 2 - 65
                          : screenWidth - 120,
                      decoration: BoxDecoration(
                        color: ThemeColor.blueColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextButton(
                        style: ButtonStyle(overlayColor:
                            MaterialStateProperty.resolveWith((states) {
                          return Colors.transparent;
                        })),
                        onPressed: () {
                          Get.back();
                          rightTap?.call();
                        },
                        child: KeyboardListener(
                          focusNode: FocusNode(),
                          autofocus: true,
                          onKeyEvent: (rawKeyEvent) {
                            if (rawKeyEvent.runtimeType == KeyDownEvent &&
                                rawKeyEvent.logicalKey ==
                                    LogicalKeyboardKey.enter) {
                              rightTap?.call();
                            }
                          },
                          child: AutoSizeText(
                            maxLines: 1,
                            rightTitle ?? LocaleKeys.Confirm.tr,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
