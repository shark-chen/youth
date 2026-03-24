import 'package:flutter/material.dart';
import '../../utils/utils/theme_color.dart';
import '../input/text_input.dart';

/// FileName search_view
///
/// @Author 谌文
/// @Date 2023/10/17 11:09
///
/// @Description 基础搜索框  - 圆角
class SearchBaseWidget extends StatelessWidget {
  SearchBaseWidget({
    Key? key,
    this.inputKey,
    this.height = 36,
    this.clickSearchCall,
    this.isIntPutEdit = true,
    this.onSubmitted,
    this.hint,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.hiddenKeyboard,
    this.rightWidget,
    this.inputClickTap,
  }) : super(key: key);

  /// 输入框key
  final Key? inputKey;

  /// 高度
  final double? height;

  final FocusNode? focusNode;

  /// 是否自动聚焦
  final bool? autofocus;

  /// 点击搜索回调
  final VoidCallback? clickSearchCall;

  /// 输入框是可以编辑, 可以编辑，则clickSearchCall没有回调
  final bool? isIntPutEdit;

  /// 搜索回调输入框问题
  final ValueChanged<String>? onSubmitted;

  /// 输入框提示语
  final String? hint;

  /// 输入框监控
  final TextEditingController? controller;

  /// 是否隐藏键盘， 默认不隐藏
  final bool? hiddenKeyboard;

  /// 右侧widget
  final Widget? rightWidget;

  /// 是否是用户自己点击输入框回调
  final ValueChanged<bool>? inputClickTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: clickSearchCall,
      child: Container(
        height: height ?? 36,
        padding: const EdgeInsets.only(left: 12, right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: ThemeColor.bgGrayColor,
        ),
        child: Row(
          children: [
            Image.asset("assets/image/common/common_search_icon@3x.png",
                width: 20, height: 20),
            const SizedBox(width: 6),
            isIntPutEdit == true
                ? Expanded(
                    child: Container(
                      height: height ?? 36,
                      child: UITextInput(
                        key: inputKey,
                        color: Colors.transparent,
                        textInputAction: TextInputAction.search,
                        padding: EdgeInsets.only(left: 0, right: 6),
                        focusNode: focusNode,
                        hiddenKeyboard: hiddenKeyboard,
                        onSubmitted: (value) {
                          /// 有破PDA，扫描后会在内容后面加个空格，无语了，这里统一去除下
                          controller?.text = value.trim();
                          onSubmitted?.call(value.trim());
                        },
                        autofocus: autofocus,
                        controller: controller,
                        hint: hint ?? '',
                        borderColor: Colors.transparent,
                        inputClickTap: inputClickTap,
                        style: const TextStyle(
                            color: ThemeColor.mainTextColor,
                            height: 1.0,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                : Expanded(
                    child: Text(
                      hint ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: ThemeColor.lightGrayColor, fontSize: 13.0),
                    ),
                  ),
            rightWidget ?? Container(),
          ],
        ),
      ),
    );
  }
}
