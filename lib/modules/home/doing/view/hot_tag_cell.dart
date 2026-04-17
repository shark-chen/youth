import 'package:flutter/material.dart';

/// FileName: hot_tag_cell
///
/// @Author 谌文
/// @Date 2026/3/9 14:11
///
/// @Description 正在页热门标签胶囊 Cell
class HotTagCell extends StatelessWidget {
  const HotTagCell({
    super.key,
    this.text,
    this.onTap,
  });

  /// 文字
  final String? text;

  /// 点击事件
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 6, right: 6),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
          ),
        ),
        child: Text(
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          text ?? '' ,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
