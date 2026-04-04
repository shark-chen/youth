import 'package:flutter/material.dart';
import 'package:youth/utils/marco/marco.dart';
import 'package:youth/utils/utils/theme_color.dart';
import '../model/card_item.dart';

/// FileName: card_stack_view
///
/// @Author 谌文
/// @Date 2026/3/28 23:51
///
/// @Description
class CardStackPage extends StatefulWidget {
  CardStackPage({this.findTap});

  /// 找一找点击
  final VoidCallback? findTap;

  @override
  _CardStackPageState createState() => _CardStackPageState();
}

class _CardStackPageState extends State<CardStackPage> {
  List<CardItem> items = List.generate(
    5,
    (index) => CardItem("找爱看电影的人，恐怖类型的 👻 $index"),
  );

  Offset position = Offset.zero;
  double angle = 0;

  void onPanUpdate(DragUpdateDetails details) {
    setState(() {
      position += details.delta;
      angle = position.dx / 300; // 旋转角度
    });
  }

  void onPanEnd(DragEndDetails details) {
    final screenSize = MediaQuery.of(context).size;
    final threshold = 150;

    if (position.dx.abs() > threshold || position.dy.abs() > threshold) {
      // 滑出屏幕
      setState(() {
        position = Offset(
          position.dx > 0 ? screenSize.width : -screenSize.width,
          position.dy > 0 ? screenSize.height : -screenSize.height,
        );
      });

      Future.delayed(Duration(milliseconds: 300), () {
        setState(() {
          items.removeAt(0);
          position = Offset.zero;
          angle = 0;
        });
      });
    } else {
      // 回弹
      setState(() {
        position = Offset.zero;
        angle = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: items.isEmpty
          ? Text("没有更多了", style: TextStyle(color: Colors.white))
          : Stack(
              alignment: Alignment.center,
              children: items
                  .asMap()
                  .map((index, item) {
                    if (index >= 3) return MapEntry(index, SizedBox());
                    var scale = 1.0;
                    if (index > 0) {
                      scale = scale - 0.2;
                    }

                    /// ✅ 新增：左右偏移
                    double offsetX = 0;
                    double offsetY = index * 10.0;
                    double rotate = 0;

                    if (index == 1) {
                      offsetX = -(screenWidth * 0.25 - 20); // 左边卡
                      rotate = -0.2;
                    } else if (index == 2) {
                      offsetX = (screenWidth * 0.25 - 20); // 右边卡
                      rotate = 0.2;
                    }

                    return MapEntry(
                      index,
                      Transform.translate(
                        offset:
                            index == 0 ? position : Offset(offsetX, offsetY),
                        child: Transform.rotate(
                          angle: index == 0 ? angle : rotate,
                          child: Transform.scale(
                            scale: scale,
                            child: index == 0
                                ? GestureDetector(
                                    onPanUpdate: onPanUpdate,
                                    onPanEnd: onPanEnd,
                                    child: buildCard(item),
                                  )
                                : buildCard(item),
                          ),
                        ),
                      ),
                    );
                  })
                  .values
                  .toList()
                  .reversed
                  .toList(),
            ),
    );
  }

  Widget buildCard(CardItem item) {
    return Container(
      width: screenWidth * 0.5,
      height: screenWidth * 0.5 * 1.2,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ThemeColor.cardBgColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "“",
              style: TextStyle(fontSize: 40, color: Colors.white38),
            ),
          ),
          Center(
            child: Text(
              item.text,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          GestureDetector(
            onTap: widget.findTap,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding:
                    EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text("找一找"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
