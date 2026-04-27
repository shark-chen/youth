import 'package:flutter/material.dart';
import 'package:kellychat/utils/extension/lists/lists.dart';
import 'package:kellychat/utils/marco/marco.dart';

/// FileName: hot_tags_widget
///
/// @Author 谌文
/// @Date 2026/3/28 23:51
///
/// @Description Ai找人-热度标签- view
class HotTagsWidget extends StatefulWidget {
  HotTagsWidget({
    this.items,
    this.emptyHintWhenNoData,
    this.emptyHintWhenNoMore,
    this.findTap,
  });

  /// 卡片数据（由外部传入，如 aiTags / 匹配结果 friends 映射而来）
  final List<String>? items;

  /// 列表为空时的提示（如尚无标签）
  final String? emptyHintWhenNoData;

  /// 卡片滑完后的提示
  final String? emptyHintWhenNoMore;

  /// 找一找点击
  final ValueChanged<String>? findTap;

  @override
  _HotTagsWidgetState createState() => _HotTagsWidgetState();
}

class _HotTagsWidgetState extends State<HotTagsWidget> {
  late List<String> _stack;

  Offset position = Offset.zero;
  double angle = 0;

  @override
  void initState() {
    super.initState();
    _stack = widget.items ?? [];
  }

  @override
  void didUpdateWidget(HotTagsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      _stack = widget.items ?? [];
      position = Offset.zero;
      angle = 0;
    });
  }

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
          _stack.removeAt(0);
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

  String _emptyMessage() {
    if (_stack.isNotEmpty) return '';
    if (Lists.isEmpty(widget.items)) {
      return widget.emptyHintWhenNoData ?? '暂无数据';
    }
    return widget.emptyHintWhenNoMore ?? '没有更多了';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _stack.isEmpty
          ? Text(
              _emptyMessage(),
              style: TextStyle(color: Colors.white.withOpacity(0.7)),
            )
          : Stack(
              alignment: Alignment.center,
              children: _stack
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
                      offsetX = -(screenWidth * 0.25 - 30); 
                      rotate = -0.2;
                    } else if (index == 2) {
                      offsetX = (screenWidth * 0.25 - 30); 
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
                                : Opacity(
                                    opacity: 0.45,
                                    child: buildCard(item),
                                  ),
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

  Widget buildCard(String title) {
    return Container(
      width: screenWidth * 0.5,
      height: screenWidth * 0.5 * 1.2,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF292929),
        border: Border.all(
          width: 1,
          color: const Color(0xFF3C3C3C),
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, 6),
            blurRadius: 10,
          ),
        ],
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
              title,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          GestureDetector(
            onTap: () => widget.findTap?.call(title),
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
