import 'package:kellychat/base/base_stateless_widget.dart';

/// FileName progress_widget
///
/// @Author 谌文
/// @Date 2025/2/25 09:47
///
/// @Description 进度条view
class ProgressWidget extends BaseStatelessWidget {
  const ProgressWidget({
    Key? key,
    this.ratio = 0.3,
    this.height,
    this.width,
    this.progressColor = ThemeColor.greenColor,
    this.progressBgColor = ThemeColor.lineColor,
    this.circular = 5,
  }) : super(key: key);

  /// 进度比例 0 - 1之间的值
  final double? ratio;

  /// 进度条的高度
  final double? height;

  /// 进度条的宽度
  final double? width;

  /// 进度条颜色
  final Color? progressColor;

  /// 进度条背景颜色
  final Color? progressBgColor;

  /// 圆角
  final double? circular;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height ?? 8,
          decoration: BoxDecoration(
            color: progressBgColor ?? ThemeColor.lineColor,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
        Container(
          width: (ratio ?? 0) * (width ?? (Get.width - 56.0)),
          height: height ?? 8,
          decoration: BoxDecoration(
            color: progressColor,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
        ),
      ],
    );
  }
}
