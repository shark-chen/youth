import 'package:flutter/material.dart';

class ScanLinePaint extends CustomPainter {
  /// 百分比值，0 ~ 1，然后计算Y坐标
  final double lineMoveValue;
  Color? color;

  ScanLinePaint({required this.lineMoveValue, this.color});

  @override
  void paint(Canvas canvas, Size size) {
    /// 绘制罩层 画笔
    Paint paint = Paint()
      ..style = PaintingStyle.fill // 画笔的模式，填充
      ..color = color ?? Colors.white
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.square; // 解决因为线宽导致交界处不是直角的问题

    var height = size.height * 0.7;
    /**
     * 画框
     */
    Offset p1 = const Offset(20, 80);
    Offset p2 = Offset(20, height);
    Offset p3 = Offset(size.width - 20, 80);
    Offset p4 = Offset(size.width - 20, height);
    Offset o1 = const Offset(0, 25);
    Offset o2 = const Offset(25, 0);
    canvas.drawLine(p1, p1 + o1, paint);
    canvas.drawLine(p1, p1 + o2, paint);

    canvas.drawLine(p2, p2 - o1, paint);
    canvas.drawLine(p2, p2 + o2, paint);

    canvas.drawLine(p3, p3 + o1, paint);
    canvas.drawLine(p3, p3 - o2, paint);

    canvas.drawLine(p4, p4 - o1, paint);
    canvas.drawLine(p4, p4 - o2, paint);

    paint.strokeWidth = 5;
    paint.color = Colors.deepPurple;

    /// 扫描线的移动值
    var lineY = (height + 80) * lineMoveValue;

    /// 10 为线条与方框之间的间距，绘制扫描线
    canvas.drawLine(
      Offset(40.0, lineY),
      Offset(size.width - 40.0, lineY),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
