import 'package:youth/base/base_stateless_widget.dart';

/// FileName: alert_double_title_view
///
/// @Author 谌文
/// @Date 2026/1/13 15:00
///
/// @Description 弹框双标题view
class AlertDoubleTitleWidget extends BaseStatelessWidget {
  const AlertDoubleTitleWidget({
    Key? key,
    this.index,
    this.title,
    this.secondTitle,
    this.tabTap,
    this.closeTap,
  }) : super(key: key);

  /// 选择的tab
  final int? index;

  /// 标题1
  final String? title;

  /// 标题2
  final String? secondTitle;

  /// tab点击
  final ValueChanged<int>? tabTap;

  /// 关闭按钮点击
  final VoidCallback? closeTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 40),
          Expanded(child: Container()),
          GestureDetector(
            onTap: () => tabTap?.call(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title ?? '',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: index == 0
                          ? ThemeColor.blueColor
                          : ThemeColor.mainTextColor),
                ),
                SizedBox(height: index == 0 ? 8 : 9.5),
                Visibility(
                  visible: index == 0,
                  child: Container(
                    height: 1.5,
                    width: 45,
                    color: ThemeColor.blueColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 30),
          GestureDetector(
            onTap: () => tabTap?.call(1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  secondTitle ?? '',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: index == 1
                          ? ThemeColor.blueColor
                          : ThemeColor.mainTextColor),
                ),
                SizedBox(height: index == 1 ? 8 : 9.5),
                Visibility(
                  visible: index == 1,
                  child: Container(
                    height: 1.5,
                    width: 60,
                    color: ThemeColor.blueColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Container()),
          GestureDetector(
            onTap: closeTap,
            child: const Icon(
              Icons.close,
              color: ThemeColor.mainTextColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
