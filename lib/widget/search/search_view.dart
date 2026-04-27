import 'package:kellychat/tripartite_library/tripartite_library.dart';
import 'package:kellychat/utils/utils/theme_color.dart';
import 'search_base_view.dart';

/// FileName search_view
///
/// @Author 谌文
/// @Date 2023/10/17 11:09
///
/// @Description 基础搜索加左右白色留白
/// 搜索输入框
// ignore: must_be_immutable
class SearchInputWidget extends SearchBaseWidget {
  SearchInputWidget({
    super.key,
    this.totalHeight = 50.0,
    this.topLineColor,
    this.bottomLineColor,
    super.inputKey,
    super.hint,
    super.isIntPutEdit,
    super.controller,
    super.autofocus,
    super.hiddenKeyboard,
    super.focusNode,
    super.clickSearchCall,
    super.onSubmitted,
    super.rightWidget,
    super.height = 36,
    this.padding,
  });

  /// 高度
  final double? totalHeight;

  /// 顶部分割线的颜色
  final Color? topLineColor;

  /// 底部分割线的颜色
  final Color? bottomLineColor;

  /// see [Decoration.padding].
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: topLineColor ?? ThemeColor.lackLineColor,
                width: 1,
              ),
            ),
          ),
          height: ((totalHeight ?? 50) - (bottomLineColor != null ? 1 : 0)),
          padding: padding ??
              EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: ((totalHeight ?? 50) - (height ?? 37)) * 0.5,
                  bottom: ((totalHeight ?? 50) - (height ?? 37)) * 0.5),
          child: super.build(context),
        ),
        Visibility(
          visible: bottomLineColor != null,
          child: Divider(
              color: bottomLineColor ?? ThemeColor.lineColor, height: 1),
        ),
      ],
    );
  }
}
