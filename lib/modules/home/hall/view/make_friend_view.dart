import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youth/tripartite_library/tripartite_library.dart';

/// FileName: make_friend_view
///
/// @Author 谌文
/// @Date 2026/3/29 20:05
///
/// @Description 左右侧滑交友认识- view
/// 数据模型
class CardItem {
  final String name;
  final String desc;

  CardItem(this.name, this.desc);
}

class CardStackDemo extends StatefulWidget {
  @override
  State<CardStackDemo> createState() => _CardStackDemoState();
}

class _CardStackDemoState extends State<CardStackDemo> {
  List<CardItem> items = List.generate(
    5,
    (i) => CardItem("晓雨 $i", "别问我为什么单身，我们神仙和凡人谈恋爱是触犯天条..."),
  );

  Offset position = Offset.zero;
  double angle = 0;

  /// 拖动
  void onPanUpdate(DragUpdateDetails details) {
    setState(() {
      position += details.delta;
      angle = position.dx / 300;
    });
  }

  /// 松手
  void onPanEnd(DragEndDetails details) {
    final size = MediaQuery.of(context).size;
    const threshold = 120;

    if (position.distance > threshold) {
      /// 飞出去
      setState(() {
        position = Offset(
          position.dx > 0 ? size.width : -size.width,
          position.dy > 0 ? size.height : -size.height,
        );
      });

      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          items.removeAt(0);
          position = Offset.zero;
          angle = 0;
        });
      });
    } else {
      /// 回弹
      setState(() {
        position = Offset.zero;
        angle = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return items.length < 2
        ? const Text("没有更多了", style: TextStyle(color: Colors.white))
        : Stack(
            alignment: Alignment.center,
            children: [
              /// 👇 下层卡片
              buildBackCard(),

              /// 👇 上层卡片
              buildFrontCard(),
            ],
          );
  }

  /// ================== 下层卡片 ==================
  Widget buildBackCard() {
    /// progress：0~1
    double progress = (position.distance / 200).clamp(0.0, 1.0);

    return Transform.translate(
      offset: Offset(0, 30 * (1 - progress)), // 上移
      child: Transform.scale(
        scale: 0.92 + 0.08 * progress, // 放大
        child: Opacity(
          opacity: 0.7 + 0.3 * progress,
          child: Container(
            // width: screenWidth - 48,
            // height: (screenWidth - 64) * (410.0 / 327.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 30,
                  offset: const Offset(0, 20),
                )
              ],
            ),
            child: buildCard(items[1]),
          ),
        ),
      ),
    );
  }

  /// ================== 上层卡片 ==================
  Widget buildFrontCard() {
    return Transform.translate(
      offset: position,
      child: Transform.rotate(
        angle: angle,
        child: GestureDetector(
          onPanUpdate: onPanUpdate,
          onPanEnd: onPanEnd,
          child: buildCard(items[0]),
        ),
      ),
    );
  }

  /// ================== 卡片UI ==================
  Widget buildCard(CardItem item) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: screenWidth - 48,
        height: (screenWidth - 48) * (498.0 / 327.0),
        child: Stack(
          children: [
            /// 背景图（示例用颜色代替）
            Positioned.fill(
              child: Container(
                color: Colors.red,
                // width: screenWidth - 64,
                // height: (screenWidth - 64)* (410.0/327.0),
                child: Image.network(
                  "https://picsum.photos/400/600?random=${item.name}",
                  fit: BoxFit.fill,
                ),
              ),
            ),

            /// 渐变遮罩
            Positioned.fill(
              child: Container(
                // width: screenWidth - 64,
                // height: (screenWidth - 64)* (410.0/327.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),

            /// 信息
            Positioned(
              left: 16,
              right: 16,
              bottom: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 名字 + 在线
                  Row(
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white),
                        ),
                        child: const Text(
                          "在线",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    "33岁 · 深圳",
                    style: TextStyle(color: Colors.white70),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    item.desc,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white60),
                  ),

                  const SizedBox(height: 12),

                  /// 标签
                  Row(
                    children: [
                      chip("🎬 爱看电影"),
                      chip("🍔 吃货"),
                      chip("🏃 爱徒步"),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// 按钮
                  Row(
                    children: [
                      SizedBox(width: 12),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                            width: 1,
                            color: ThemeColor.themeFourZeroColor,
                          ),
                        ),
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.close,
                          color: ThemeColor.whiteColor,
                        ),
                      ),
                      SizedBox(width: 30),
                      Expanded(
                        child: Container(
                          height: 44,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Text(
                            "聊一聊",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 24),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget chip(String text) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}
