import 'dart:ui' show ImageFilter;
import 'package:kellychat/base/base_stateless_widget.dart';
import 'package:kellychat/widget/button/icon_button/icon_button.dart';
import 'edit_mine_card.dart';

/// FileName: edit_tags_section
///
/// @Author 谌文
/// @Date 2026/4/12 22:51
///
/// @Description 标签：标题、说明、长按拖动排序
class EditTagsSection extends BaseStatelessWidget {
  const EditTagsSection({
    super.key,
    required this.tags,
    required this.onReorder,
    required this.onAdd,
    this.maxTags = 10,
    this.profileCardTagCount = 3,
  });

  /// 标签
  final List<String> tags;

  /// 标签拖拽
  final void Function(int oldIndex, int newIndex) onReorder;

  /// 添加标签
  final VoidCallback onAdd;

  /// 最大可添加标签数量
  final int maxTags;

  /// 前几张将展示在资料卡上
  final int profileCardTagCount;

  @override
  Widget build(BuildContext context) {
    return EditMineCard(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '标签',
                  style: TextStyle(
                    color: ThemeColor.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                if (tags.length < maxTags)
                  Container(
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.only(left: 12, right: 14, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                      color: ThemeColor.whiteColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: ButtonIcon(
                      onTap: onAdd,
                      title: '添加',
                      style: TextStyles(color: ThemeColor.white6Color),
                      path: 'assets/image/common/add@3x.png',
                      iconSize: Size(16, 16),
                    ),
                  )
              ],
            ),
            const SizedBox(height: 6),
            Text(
              '长按拖动排序，最多$maxTags个，前$profileCardTagCount个将展示在资料卡',
              style: TextStyle(
                color: ThemeColor.secondaryTextColor,
                fontSize: 12,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 10),
            if (tags.isEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  '暂无标签，点击右上角添加',
                  style: TextStyle(
                    color: ThemeColor.secondaryTextColor,
                    fontSize: 13,
                  ),
                ),
              )
            else
              ReorderableListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                buildDefaultDragHandles: false,
                onReorder: onReorder,
                proxyDecorator: (
                  Widget child,
                  int index,
                  Animation<double> animation,
                ) {
                  return AnimatedBuilder(
                    animation: animation,
                    builder: (BuildContext context, Widget? child) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: ThemeColor.blackColor.withOpacity(0.48),
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                color: ThemeColor.whiteColor.withOpacity(0.14),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      ThemeColor.blackColor.withOpacity(0.35),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: child,
                          ),
                        ),
                      );
                    },
                    child: child,
                  );
                },
                children: [
                  for (var i = 0; i < tags.length; i++)
                    _TagRow(
                      key: ValueKey('tag-$i-${tags[i]}'),
                      label: tags[i],
                      index: i,
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

/// 标签- cell
class _TagRow extends StatelessWidget {
  const _TagRow({
    super.key,
    required this.label,
    required this.index,
  });

  final String label;
  final int index;

  @override
  Widget build(BuildContext context) {
    /// 标签行在 ReorderableListView 里会拿到满宽；用 Align + mainAxisSize.min 按内容收缩；长文案再限宽省略
    final maxLabelWidth =
        (MediaQuery.sizeOf(context).width - 100).clamp(48.0, 280.0);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ReorderableDelayedDragStartListener(
          index: index,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: ThemeColor.whiteColor.withOpacity(0.05),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxLabelWidth),
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: ThemeColor.whiteColor,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Icon(
                  Icons.close,
                  color: ThemeColor.whiteColor.withOpacity(0.8),
                  size: 14,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
