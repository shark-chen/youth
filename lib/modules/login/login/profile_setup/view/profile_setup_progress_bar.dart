import 'package:kellychat/base/base_stateless_widget.dart';

/// FileName profile_setup_progress_bar
///
/// @Author 谌文
/// @Date 2024/7/8 14:34
///
/// @Description 顶部三步进度条
class ProfileSetupProgressBar extends BaseStatelessWidget {
  const ProfileSetupProgressBar({
    super.key,
    required this.currentStep,
  });

  /// 索引
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 64,
        child: Row(
          children: List.generate(
            3,
            (index) {
              final active = index <= currentStep;
              return Padding(
                padding: EdgeInsets.only(right: index < 2 ? 8 : 0),
                child: Container(
                  height: 6,
                  width: 16,
                  decoration: BoxDecoration(
                    color: active
                        ? ThemeColor.themeGreenColor
                        : ThemeColor.whiteColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
