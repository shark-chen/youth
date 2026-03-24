import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../generated/locales.g.dart';
import '../../utils/utils/theme_color.dart';

/// FileName search_input_appbar_view
///
/// @Author 谌文
/// @Date 2023/10/17 11:00
///
/// @Description 搜索
// ignore: must_be_immutable
class SearchAppBarWidget extends StatelessWidget {
  /// 输入框提示文字
  final String? hintText;

  /// 点击搜索回调
  final ValueChanged<String>? clickSearchCall;

  /// 输入框内容改变
  final ValueChanged<String>? onChanged;
  final VoidCallback? backCall;

  /// 点击键盘搜索
  final ValueChanged<String>? onSearch;

  TextEditingController? editingController;
  FocusNode? focusNode;

  SearchAppBarWidget({
    super.key,
    this.hintText,
    this.clickSearchCall,
    this.backCall,
    this.onSearch,
    this.focusNode,
    this.editingController,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: Get.width - 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: backCall,
            child: Image.asset("assets/image/common/common_back_arrow@3x.png",
                width: 24, height: 24),
          ),
          const SizedBox(width: 6),
          Container(
            height: 36,
            width: Get.width - 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: ThemeColor.bgGrayColor,
            ),
            child: Row(
              children: [
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    focusNode: focusNode,
                    onSubmitted: onSearch,
                    textAlign: TextAlign.start,
                    autofocus: true,
                    controller: editingController,
                    style: const TextStyle(
                        color: ThemeColor.mainTextColor, fontSize: 13.0),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hintText ?? LocaleKeys.PleaseEnterSKUTitle.tr,
                        hintStyle: const TextStyle(
                            color: ThemeColor.lightGrayColor, fontSize: 13.0)),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    alignment: Alignment.center,
                    height: 28,
                    constraints: const BoxConstraints(minWidth: 58),
                    decoration: BoxDecoration(
                      color: ThemeColor.blueBtnColor,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(LocaleKeys.Search.tr,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500)),
                  ),
                  onTap: () =>
                      clickSearchCall?.call(editingController?.text ?? ''),
                ),
                const SizedBox(width: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
