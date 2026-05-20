import 'dart:math';

import 'package:flutter/material.dart';

/// FileName: hot_tag_cell
///
/// @Author 谌文
/// @Date 2026/3/9 14:11
///
/// @Description 正在页热门标签胶囊 Cell（各自独立随机浮动）
class HotTagCell extends StatefulWidget {
  const HotTagCell({
    super.key,
    this.text,
    this.onTap,
    this.animationSeed,
  });

  /// 文字
  final String? text;

  /// 点击事件
  final VoidCallback? onTap;

  /// 动画随机种子（不传则用 [text] 的 hashCode）
  final int? animationSeed;

  /// 上下半幅（总范围 20）
  static const double floatRangeY = 10;

  /// 左右半幅（总范围 10，约为原幅度 1/4）
  static const double floatRangeX = 5;

  @override
  State<HotTagCell> createState() => _HotTagCellState();
}

class _HotTagCellState extends State<HotTagCell>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double _phaseY;
  late double _phaseX;

  @override
  void initState() {
    super.initState();
    final rnd = Random(
      widget.animationSeed ?? widget.text?.hashCode ?? widget.key.hashCode,
    );
    _phaseY = rnd.nextDouble() * 2 * pi;
    _phaseX = rnd.nextDouble() * 2 * pi;
    final durationMs = 4400 + rnd.nextInt(2800);
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: durationMs),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final angle = _controller.value * 2 * pi;
        final dy = HotTagCell.floatRangeY * sin(angle + _phaseY);
        final dx = HotTagCell.floatRangeX * sin(angle + _phaseX);
        return Transform.translate(
          offset: Offset(dx, dy),
          child: child,
        );
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: 40),
          padding: const EdgeInsets.only(left: 6, right: 6),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 2,
            ),
          ),
          child: Text(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            widget.text ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
