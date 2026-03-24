import 'package:flutter/material.dart';

/// FileName triangle_painter
///
/// @Author 谌文
/// @Date 2023/6/12 19:32
///
/// @Description 三角形
class TrianglePainter extends CustomPainter {
  final Color? color;

  TrianglePainter({this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(
        path,
        Paint()
          ..color = (color ?? Colors.white)
          ..style = PaintingStyle.fill
          ..strokeWidth = 2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
