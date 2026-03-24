import 'package:flutter/material.dart';
import 'scan_rectangle_component.dart';

/// FileName scan_animated_view
///
/// @Author 谌文
/// @Date 2023/12/5 19:00
///
/// @Description 动画UI
class ScanAnimatedWidget extends StatelessWidget {
  const ScanAnimatedWidget({
    Key? key,
    this.animation,
  }) : super(key: key);

  /// 动画
  final Animation? animation;

  @override
  Widget build(BuildContext context) {
    if (animation == null) {
      return Container(color: Colors.transparent);
    }
    return AnimatedBuilder(
      animation: animation!,
      builder: (context, child) {
        return CustomPaint(
          painter: ScanLinePaint(
              color: Colors.white, lineMoveValue: animation?.value),
          child: Container(),
        );
      },
    );
  }
}
