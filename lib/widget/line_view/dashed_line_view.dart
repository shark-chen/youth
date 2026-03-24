import 'package:flutter/material.dart';

/// FileName dashed_line_view
///
/// @Author 谌文
/// @Date 2024/10/17 18:43
///
/// @Description 虚线
class DashedLineWidget extends StatelessWidget {
  DashedLineWidget({
    required this.size,
    this.color,
    this.dashWidth = 5,
    this.dashSpace = 3,
  });

  /// 线条的size
  final Size size;

  /// 线条的颜色
  final Color? color;

  /// 设置虚线的长度
  final double? dashWidth;

  /// 设置虚线的间隔
  final double? dashSpace;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size,
      painter: DashedLinePainter(
          color: color, dashWidth: dashWidth, dashSpace: dashSpace),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  DashedLinePainter({
    this.color,
    this.dashWidth = 5,
    this.dashSpace = 3,
  });

  /// 线条的颜色
  final Color? color;

  /// 设置虚线的长度
  final double? dashWidth;

  /// 设置虚线的间隔
  final double? dashSpace;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color ?? Colors.black87 // 虚线的颜色
      ..strokeWidth = size.height // 线条宽度
      ..style = PaintingStyle.stroke;

    double dashWidth = 5, dashSpace = 3; // 设置虚线的长度和间隔
    double startX = 0;
    final path = Path();

    while (startX < size.width) {
      path.moveTo(startX, 0);
      path.lineTo(startX + dashWidth, 0);
      startX += dashWidth + dashSpace;
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
