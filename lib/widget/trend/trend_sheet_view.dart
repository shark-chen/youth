import 'package:youth/tripartite_library/tripartite_library.dart';
import 'trend_sheet_cell.dart';

/// FileName trend_sheet_view
///
/// @Author 谌文
/// @Date 2024/5/30 16:37
///
/// @Description 走势图表格-如同坐标
double xHeight = 13;
double yFirstHeight = 25;

class TrendSheetWidget extends StatelessWidget {
  const TrendSheetWidget({
    Key? key,
    required this.height,
    required this.width,
    this.dyWidth = 30,
    required this.dx,
    required this.dy,
  }) : super(key: key);

  final double height;
  final double width;

  /// X坐标点
  final List<String> dx;

  /// Y坐标点
  final List<List<String>> dy;

  /// dY轴标题的宽度
  final double? dyWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height + yFirstHeight + xHeight,
      width: width,
      child: Column(
        children: [
          ///  Y轴
          ListView.builder(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: Lists.isNotEmpty(dy) ? dy.first.length : 1,
            itemBuilder: (BuildContext context, int index) {
              if (Lists.isEmpty(dy)) return SizedBox(height: height + 24);
              return Container(
                alignment: Alignment.topCenter,
                height: index == dy.first.length - 1
                    ? yFirstHeight
                    : height / (dy.first.length - 1),
                child: TrendSheetCell(
                    title: dy.first[index],
                    rightTitle: dy.length <= 1 ? null : dy[1][index],
                    titleWidth: dyWidth,
                    height: yFirstHeight),
              );
            },
          ),

          /// X轴
          Container(
            padding: EdgeInsets.only(left: 6),
            height: xHeight,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: dx.length,
              itemBuilder: (BuildContext context, int index) {
                var alignment = Alignment.topCenter;
                if (dx.length > 1) {
                  alignment = (index == 0
                      ? Alignment.topLeft
                      : (index == dx.length - 1
                          ? Alignment.topRight
                          : Alignment.topCenter));
                }
                return Container(
                  alignment: alignment,
                  width: (width - 16) / dx.length,
                  child: Text(
                    textAlign: TextAlign.center,
                    dx[index],
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF919099)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
