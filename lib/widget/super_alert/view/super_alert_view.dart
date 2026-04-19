import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';

import '../../../base/base_stateless_widget.dart';

/// FileName super_view
///
/// @Author 谌文
/// @Date 2024/3/4 20:53
///
/// @Description 弹框view
class SuperAlertWidget extends StatelessWidget {
  const SuperAlertWidget({
    Key? key,
    this.title,
    this.subTitle,
    this.contents,
    this.subTwoTitle,
    this.subContents,
    this.leftTitle,
    this.leftTap,
    this.rightTitle,
    this.rightTap,
  }) : super(key: key);

  /// 标题
  final String? title;

  /// 副标题
  final String? subTitle;

  /// 内容List
  final List<String>? contents;

  /// 副标题
  final String? subTwoTitle;

  /// 副内容List
  final List<String>? subContents;

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
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 正标题
                Text(
                  title ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: ThemeColor.mainTextColor),
                ),
                const SizedBox(height: 8),

                /// 副标题
                Text(
                  subTitle ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: ThemeColor.greenColor),
                ),

                /// 成功提示内容
                Container(
                  constraints: const BoxConstraints(maxHeight: 80),
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return Text(
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        contents?[index] ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: ThemeColor.mainTextColor),
                      );
                    },
                    itemCount: contents?.length ?? 0,
                  ),
                ),

                const SizedBox(height: 16),

                /// 第二个副标题
                Text(
                  subTwoTitle ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: ThemeColor.brightRedColor),
                ),

                /// 错误提示内容
                Container(
                  constraints: const BoxConstraints(maxHeight: 80),
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return Text(
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        subContents?[index] ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: ThemeColor.mainTextColor),
                      );
                    },
                    itemCount: subContents?.length ?? 0,
                  ),
                ),
                const SizedBox(height: 20),

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
