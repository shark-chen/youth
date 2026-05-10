import 'package:kellychat/base/base_stateless_widget.dart';

/// FileName: doing_activity_stat_bar
///
/// @Description 正在做活动条：左侧 emoji +「正在 「标签」」+ 人数（万为单位绿色数字）+ 圆形加号
class DoingActivityStatCell extends BaseStatelessWidget {
  const DoingActivityStatCell({
    super.key,
    this.leadingEmoji = '',
    required this.activityName,
    required this.peopleCount,
    this.onAddTap,
  });

  /// 左侧表情（可由接口 [DoingHotTagsEntity.icon] 传入）
  final String leadingEmoji;

  /// 「」内展示的活动名
  final String activityName;

  /// 人数；≥10000 时显示为 x.xW
  final int peopleCount;

  /// 右侧 `+` 回调（通常用于选用该热门标签）
  final VoidCallback? onAddTap;

  /// 卡片背景（深灰）
  static const Color _cardBg = Color(0xFF1C1C1E);

  /// 加号按钮暗绿底
  static const Color _addCircleBg = Color(0xFF1A3D32);

  /// 将人数格式化为中文「万」缩写展示（如 27000 → 2.7W）
  static String formatPeopleCount(int n) {
    if (n < 10000) {
      return '$n';
    }
    final w = n / 10000.0;
    final s = (w == w.roundToDouble()) ? '${w.toInt()}' : w.toStringAsFixed(1);
    return '${s}W';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            leadingEmoji,
            style: const TextStyle(fontSize: 22, height: 1),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '正在 「$activityName」',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: ThemeColor.whiteColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 14, height: 1.25),
              children: [
                TextSpan(
                  text: formatPeopleCount(peopleCount),
                  style: const TextStyle(
                    color: ThemeColor.themeGreenColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: ' 人',
                  style: TextStyle(
                    color: ThemeColor.whiteColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Image.asset(
            'assets/image/common/circle_add@3x.png',
            width: 24,
            height: 24,
          ),
        ],
      ),
    );
  }
}
