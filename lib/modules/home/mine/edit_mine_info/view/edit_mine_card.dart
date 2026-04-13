import 'package:flutter/material.dart';
import 'package:youth/utils/utils/theme_color.dart';

/// 编辑资料页统一圆角卡片容器
class EditMineCard extends StatelessWidget {
  const EditMineCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ThemeColor.doingListCellBgColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: child,
    );
  }
}
