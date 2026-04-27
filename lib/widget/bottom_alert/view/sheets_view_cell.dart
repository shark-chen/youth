import 'package:kellychat/base/base_stateless_widget.dart';
import '../../../utils/extension/colors/color_util.dart';

/// FileName sheets_view_cell
///
/// @Author 谌文
/// @Date 2025/6/11 16:40
///
/// @Description 弹框多选cell
class SheetsViewCell extends BaseStatelessWidget {
  const SheetsViewCell({
    Key? key,
    this.title,
    this.color,
    this.selected,
    this.enabled,
    this.onTap,
  }) : super(key: key);

  /// 标题
  final String? title;

  /// 标题颜色
  final String? color;

  /// 是否选中
  final bool? selected;

  /// 是否可点击
  final bool? enabled;

  /// 点击事件
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        height: 48,
        child: Row(
          children: [
            Visibility(
              visible: Strings.isNotEmpty(color),
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: ColorUtil.parseColor(color ?? ''),
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  border: Border.all(
                      color: ColorUtil.parseColor(color ?? ''), width: 2),
                ),
              ),
            ),

            SizedBox(width: 5),

            /// 左侧标题
            Expanded(
              flex: 80,
              child: Text(
                title ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 14,
                    color: enabled == true
                        ? ThemeColor.otherTextColor
                        : ThemeColor.versionColor,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Expanded(child: Container(height: 46, color: Colors.white)),
            Visibility(
              visible: enabled == true,
              child: Image.asset(
                width: 18,
                height: 18,
                selected == true
                    ? "assets/image/icons/check@3x.png"
                    : "assets/image/icons/check_nor@3x.png",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
