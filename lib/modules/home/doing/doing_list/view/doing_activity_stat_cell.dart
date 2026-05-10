import 'package:kellychat/base/base_stateless_widget.dart';

/// FileName: doing_activity_stat_cell
///
/// @Description 正在做活动条：左侧 emoji +「正在 「标签」」+ 人数（万为单位绿色数字）+ 圆形加号
class DoingActivityStatCell extends BaseStatelessWidget {
  const DoingActivityStatCell({
    super.key,
    this.leadingEmoji = '',
    required this.activityName,
    required this.peopleCountLabel,
    this.onAddTap,
  });

  /// 左侧表情（可由接口 [DoingHotTagsEntity.icon] 传入）
  final String leadingEmoji;

  /// 「」内展示的活动名（用户设置的正在做事项名称）
  final String activityName;

  /// 人数展示前半段（绿色），由 [DoingListVM.formatHotTagPeopleCount] 写入实体的 [DoingHotTagsEntity.peopleCountDisplay]
  final String peopleCountLabel;

  /// 右侧添加 icon 点击（选用该热门标签）
  final VoidCallback? onAddTap;

  /// 卡片背景（深灰）
  static const Color _cardBg = Color(0xFF1C1C1E);

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
          if (leadingEmoji.isNotEmpty) ...[
            Text(
              leadingEmoji,
              style: const TextStyle(fontSize: 22, height: 1),
            ),
            const SizedBox(width: 8),
          ],
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
                  text: peopleCountLabel,
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
          GestureDetector(
            onTap: onAddTap,
            behavior: HitTestBehavior.opaque,
            child: Image.asset(
              'assets/image/common/circle_add@3x.png',
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
    );
  }
}
