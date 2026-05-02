import 'package:flutter/material.dart';
import 'package:kellychat/base/base_page.dart';
import 'package:kellychat/utils/utils/theme_color.dart';

import 'edit_mine_card.dart';

/// 标签：标题、说明、长按拖动排序（[ReorderableListView]）
class EditTagsSection extends StatelessWidget {
  const EditTagsSection({
    super.key,
    required this.tags,
    required this.onReorder,
    required this.onAdd,
    this.maxTags = 10,
    this.profileCardTagCount = 3,
  });

  final List<String> tags;
  final void Function(int oldIndex, int newIndex) onReorder;
  final VoidCallback onAdd;
  final int maxTags;
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: IntrinsicWidth(
          child: ReorderableDelayedDragStartListener(
            index: index,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: ThemeColor.whiteColor.withOpacity(0.05),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      label,
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
      ),
    );
  }
}
