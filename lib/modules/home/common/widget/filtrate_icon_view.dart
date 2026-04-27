import 'package:kellychat/base/base_stateless_widget.dart';

/// FileName filtrate_icon_view
///
/// @Author 谌文
/// @Date 2025/4/10 14:25
///
/// @Description 筛选图标view
class FiltrateIconWidget extends BaseStatelessWidget {
  const FiltrateIconWidget({
    Key? key,
    this.select,
    this.onTap,
  }) : super(key: key);

  /// 是否是选中状态
  final bool? select;

  /// 点击事件
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    /// 筛选框
    return GestureDetector(
      child: Container(
        color: Colors.white,
        width: 36,
        height: 36,
        padding: const EdgeInsets.only(top: 6, bottom: 6),
        child: Image.asset(
          "assets/image/common/common_filter_v2@3x.png",
          width: 24,
          height: 24,
          color: select == true
              ? ThemeColor.darkBlueColor
              : ThemeColor.secondaryTextColor,
        ),
      ),
      onTap: onTap,
    );
  }
}
