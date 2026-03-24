import 'package:flutter/material.dart';
import '../../utils/extension/lists/lists.dart';

/// FileName trend_painter
///
/// @Author 谌文
/// @Date 2024/5/30 13:37
///
/// @Description 走势曲线控件
class TrendPainter extends CustomPainter {
  TrendPainter({
    required this.points,
    this.circle,
    this.color,
    this.strokeWidth = 2.5,
    this.indexWire,
  });

  /// 曲线点
  final List<Offset> points;

  /// 走势图数据点点击时候画圆圈点
  final Offset? circle;

  /// 走势图线颜色
  final Color? color;

  /// 走势图线颜色
  final double? strokeWidth;

  /// 指引线
  final List<Offset>? indexWire;

  @override
  void paint(Canvas canvas, Size size) {
    /// 画走势图
    if (points.length > 0) {
      buildTrend(canvas, points, color, strokeWidth);
    }

    /// 指引线
    if (Lists.isNotEmpty(indexWire)) {
      buildTrend(canvas, indexWire!, Color(0x9965789B), 1);
    }

    /// 当用户点击图表时，在曲线上绘制圆
    if (circle != null) buildCircle(canvas, circle!);

    /// 当只有一条数据时，直接画圈圈
    if (points.length == 1) buildCircle(canvas, points.first);
  }

  /// 画走势图
  void buildTrend(
    Canvas canvas,
    List<Offset> points,
    Color? color,
    double? strokeWidth,
  ) {
    final Paint paint = Paint()
      ..color = color ?? const Color(0xFF00B88D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth ?? 2.5;
    Path path = Path();
    path.moveTo(points.first.dx, points.first.dy);
    for (int i = 0; i < points.length - 1; i++) {
      final double distance = (points[i + 1].dx - points[i].dx) / 2;
      final Offset controlPoint1 =
          Offset(points[i].dx + distance / 2, points[i].dy);
      final Offset controlPoint2 =
          Offset(points[i + 1].dx - distance / 2, points[i + 1].dy);
      path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
          controlPoint2.dy, points[i + 1].dx, points[i + 1].dy);
    }
    canvas.drawPath(path, paint);
  }

  /// 画圈圈
  void buildCircle(Canvas canvas, Offset circle) {
    Paint circlePaint = Paint()
      ..color = (color ?? Colors.red)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(circle, 3, circlePaint);
    Paint strokePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawCircle(circle, 3.5, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
