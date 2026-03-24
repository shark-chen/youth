import 'package:flutter/material.dart';
import 'trend_painter.dart';
import 'trend_sheet_view.dart';

/// FileName trend_view
///
/// @Author 谌文
/// @Date 2024/5/30 13:39
///
/// @Description 走势图
typedef TrendValueChanged = void Function(int,
    {TapDownDetails? tapDetails, DragUpdateDetails? dragDetails});

/// 点击时候圈圈位置
int circleIndex = -1;

/// 指引线
List<Offset> indexWire = [];

class TrendWidget extends StatelessWidget {
  TrendWidget({
    Key? key,
    required this.points,
    required this.dy,
    this.dx,
    required this.height,
    required this.width,
    this.dyWidth = 30,
    this.colors,
    this.strokeWidth = 2,
    this.showCircle = false,
    this.trendValueChanged,
  }) : super(key: key);

  /// 走势图数据点
  final List<List<Offset>> points;

  /// X坐标点
  final List<String>? dx;

  /// Y坐标点
  final List<List<String>> dy;

  /// 走势图高度
  final double height;

  /// 走势图宽度
  final double width;

  /// dY轴标题的宽度
  final double? dyWidth;

  /// 走势图线颜色
  final List<Color>? colors;

  /// 走势图线颜色
  final double? strokeWidth;

  /// 显示圆圈点
  final bool? showCircle;

  /// 回调当前按住的位置
  final TrendValueChanged? trendValueChanged;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = <Widget>[];
    indexWire.clear();

    /// 坐标表格
    children.add(TrendSheetWidget(
      width: width,
      height: height,
      dyWidth: dyWidth,
      dy: dy,
      dx: dx ?? [],
    ));

    for (int i = 0; i < points.length; i++) {
      List<Offset> offsets = <Offset>[];
      points[i].forEach((element) => offsets.add(Offset(
          element.dx * (width - (dy.length > 1 ? 2 : 1) * (dyWidth ?? 30)),
          (1.0 - element.dy) * height)));

      /// 判断是否展示指引线和圈圈
      bool showIndex = showCircle == true &&
          circleIndex >= 0 &&
          circleIndex < offsets.length;
      if (showIndex) {
        Offset circleOffset = offsets[circleIndex];
        indexWire
          ..add(Offset(circleOffset.dx, 0))
          ..add(Offset(circleOffset.dx, 100));
      }

      /// 走势图
      children.add(
        Container(
          margin: EdgeInsets.only(top: yFirstHeight * 0.5),
          padding: EdgeInsets.only(left: dyWidth ?? 30),
          height: height,
          width: width,
          child: GestureDetector(
            onTapDown: (details) {
              int maxLength = 0;
              points.forEach((element) => element.length > maxLength
                  ? maxLength = element.length
                  : null);
              double x = details.localPosition.dx / (width - (dyWidth ?? 30));
              int index = (x * maxLength).round() - 1;
              circleIndex = index;
              trendValueChanged?.call(index, tapDetails: details);
            },
            onHorizontalDragUpdate: (details) {
              int maxLength = 0;
              points.forEach((element) => element.length > maxLength
                  ? maxLength = element.length
                  : null);
              double x = details.localPosition.dx / (width - (dyWidth ?? 30));
              int index = (x * maxLength).round() - 1;
              circleIndex = index;
              trendValueChanged?.call(index, dragDetails: details);
            },
            child: CustomPaint(
              painter: TrendPainter(
                points: offsets,
                indexWire: showIndex ? indexWire : null,
                circle: showIndex ? offsets[circleIndex] : null,
                color: i < (colors?.length ?? 0) ? (colors?[i]) : null,
                strokeWidth: strokeWidth,
              ),
            ),
          ),
        ),
      );
    }
    return Stack(children: children);
  }
}
