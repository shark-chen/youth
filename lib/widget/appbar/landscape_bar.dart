import 'package:kellychat/base/base_stateless_widget.dart';

/// FileName: landscape_bar
///
/// @Author 谌文
/// @Date 2025/12/8 13:50
///
/// @Description
class LandscapeBar extends BaseStatelessWidget implements PreferredSizeWidget {
  const LandscapeBar({
    Key? key,
    required this.height,
    this.title,
  }) : super(key: key);

  /// 导航栏高度
  final double height;

  /// 标题
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Text(
        title ?? '',
        style: TextStyles(fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
