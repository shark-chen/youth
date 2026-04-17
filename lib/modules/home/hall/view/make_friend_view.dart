import 'package:youth/tripartite_library/tripartite_library.dart';

import '../model/smart_match_people_entity.dart';

/// FileName: make_friend_view
///
/// @Author 谌文
/// @Date 2026/3/29 20:05
///
/// @Description 左右侧滑交友认识- view（数据由外部传入）
class CardStackDemo extends StatefulWidget {
  CardStackDemo({
    this.friends,
    this.onTap,
    this.emptyHintWhenNoData,
    this.emptyHintWhenNoMore,
  });

  /// 匹配结果列表（如 `HallVM.friends`）
  final List<SmartMatchPeopleList>? friends;

  /// 点击查看卡片用户信息
  final ValueChanged<SmartMatchPeopleList>? onTap;

  /// 尚无数据时的提示
  final String? emptyHintWhenNoData;

  /// 卡片滑完后的提示
  final String? emptyHintWhenNoMore;

  @override
  State<CardStackDemo> createState() => _CardStackDemoState();
}

class _CardStackDemoState extends State<CardStackDemo> {
  late List<SmartMatchPeopleList> _stack;

  Offset position = Offset.zero;
  double angle = 0;

  @override
  void initState() {
    super.initState();
    _stack = List<SmartMatchPeopleList>.from(widget.friends ?? []);
  }

  @override
  void didUpdateWidget(CardStackDemo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_sameFriends(widget.friends, oldWidget.friends)) {
      setState(() {
        _stack = List<SmartMatchPeopleList>.from(widget.friends ?? []);
        position = Offset.zero;
        angle = 0;
      });
    }
  }

  bool _sameFriends(
    List<SmartMatchPeopleList>? a,
    List<SmartMatchPeopleList>? b,
  ) {
    if (a == null && b == null) return true;
    if (a == null || b == null) return false;
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i].userId != b[i].userId) return false;
    }
    return true;
  }

  String _displayName(SmartMatchPeopleList item) {
    final n = item.nickname?.trim();
    if (n != null && n.isNotEmpty) return n;
    return '用户${item.userId ?? ''}';
  }

  String _ageCityLine(SmartMatchPeopleList item) {
    final parts = <String>[];
    final age = item.age;
    if (age != null) parts.add('$age岁');
    final city = item.city?.trim();
    if (city != null && city.isNotEmpty) parts.add(city);
    if (parts.isEmpty) return '—';
    return parts.join(' · ');
  }

  String _descLine(SmartMatchPeopleList item) {
    final tags = item.tags;
    if (Lists.isEmpty(tags)) return '暂无标签';
    return tags!
        .map((e) => e?.toString() ?? '')
        .where((s) => s.isNotEmpty)
        .join(' · ');
  }

  List<Widget> _tagChips(SmartMatchPeopleList item) {
    final tags = item.tags;
    if (Lists.isEmpty(tags)) {
      return [chip('暂无标签')];
    }
    final list = tags!
        .map((e) => e?.toString() ?? '')
        .where((s) => s.isNotEmpty)
        .take(3)
        .map((t) => chip(t))
        .toList();
    return list.isEmpty ? [chip('暂无标签')] : list;
  }

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
      setState(() {
        position = Offset(
          position.dx > 0 ? size.width : -size.width,
          position.dy > 0 ? size.height : -size.height,
        );
      });

      Future.delayed(const Duration(milliseconds: 300), () {
        if (!mounted) return;
        setState(() {
          if (_stack.isNotEmpty) _stack.removeAt(0);
          position = Offset.zero;
          angle = 0;
        });
      });
    } else {
      setState(() {
        position = Offset.zero;
        angle = 0;
      });
    }
  }

  String _emptyMessage() {
    if (_stack.isNotEmpty) return '';
    final parent = widget.friends;
    if (parent == null || parent.isEmpty) {
      return widget.emptyHintWhenNoData ?? '暂无匹配用户';
    }
    return widget.emptyHintWhenNoMore ?? '没有更多了';
  }

  @override
  Widget build(BuildContext context) {
    if (_stack.isEmpty) {
      return Text(
        _emptyMessage(),
        style: const TextStyle(color: Colors.white70),
      );
    }
    if (_stack.length == 1) {
      return Stack(
        alignment: Alignment.center,
        children: [buildFrontCard()],
      );
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        buildBackCard(),
        buildFrontCard(),
      ],
    );
  }

  /// ================== 下层卡片 ==================
  Widget buildBackCard() {
    double progress = (position.distance / 200).clamp(0.0, 1.0);

    return Transform.translate(
      offset: Offset(0, 30 * (1 - progress)),
      child: Transform.scale(
        scale: 0.92 + 0.08 * progress,
        child: Opacity(
          opacity: 0.7 + 0.3 * progress,
          child: Container(
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
            child: buildCard(_stack[1]),
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
          child: GestureDetector(
            onTap: () => widget.onTap?.call(_stack[0]),
            child: buildCard(_stack[0]),
          ),
        ),
      ),
    );
  }

  /// ================== 卡片UI ==================
  Widget buildCard(SmartMatchPeopleList item) {
    final seed = item.userId ?? item.nickname?.hashCode ?? 0;
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: screenWidth - 48,
        height: (screenWidth - 48) * (498.0 / 327.0),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: Colors.red,
                child: Image.network(
                  'https://picsum.photos/400/600?random=$seed',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
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
            Positioned(
              left: 16,
              right: 16,
              bottom: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          _displayName(item),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
                          '在线',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _ageCityLine(item),
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _descLine(item),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white60),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: _tagChips(item),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const SizedBox(width: 12),
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
                      const SizedBox(width: 30),
                      Expanded(
                        child: Container(
                          height: 44,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Text(
                            '聊一聊',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
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
