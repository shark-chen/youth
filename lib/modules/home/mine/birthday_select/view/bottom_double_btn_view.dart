import 'package:youth/base/base_stateless_widget.dart';

/// FileName: bottom_double_btn_view
///
/// @Author 谌文
/// @Date 2026/4/6 23:05
///
/// @Description 底部 左右按钮-view
class BottomDoubleBtnWidget extends BaseStatelessWidget {
  const BottomDoubleBtnWidget({
    Key? key,
    this.leftTitle,
    this.leftTap,
    this.rightTitle,
    this.rightTap,
  }) : super(key: key);

  /// 左侧标题
  final String? leftTitle;

  /// 左侧标题点击
  final VoidCallback? leftTap;

  /// 右侧标题
  final String? rightTitle;

  /// 右侧标题点击
  final VoidCallback? rightTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: SizedBox(
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.12),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              onPressed: leftTap,
              child: Text(
                leftTitle ?? '',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          flex: 3,
          child: SizedBox(
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeColor.themeGreenColor,
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              onPressed: rightTap,
              child: Text(
                rightTitle ?? '',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
