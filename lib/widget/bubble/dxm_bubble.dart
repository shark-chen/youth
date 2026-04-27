import 'package:kellychat/base/base_stateless_widget.dart';
import '../../utils/marco/frame.dart';

/// FileName show_bubble
///
/// @Author 谌文
/// @Date 2023/12/12 13:31
///
/// @Description 气泡
// ignore: must_be_immutable
class ShowBubble extends BaseStatelessWidget {
  final Widget child;

  /// 气泡widget
  final Widget? bubble;

  /// 控制展示气泡
  late bool showBubble;

  /// 气泡左边
  final double? left;

  /// 气泡右边
  final double? top;

  /// 气泡宽
  final double? width;

  /// 约束
  final Frame? frame;

  /// 气泡以renderBox为width,进行width宽度加减，如bubbleSizeExpand.width = 10; 则宽度加10，负数为减
  final Size? bubbleSizeExpand;

  /// 点击空白回调
  final VoidCallback? blankClick;

  ShowBubble({
    super.key,
    required this.child,
    this.bubble,
    this.showBubble = false,
    this.left,
    this.top,
    this.width,
    this.frame,
    this.bubbleSizeExpand,
    this.blankClick,
  });

  @override
  Widget build(BuildContext context) {
    if (showBubble && bubble != null) {
      var widgets = <Widget>[];
      widgets.add(child);
      var bubbleView = Positioned(
          left: frame?.offset?.dx ?? left,
          top: frame?.offset?.dy ?? top,
          width: frame?.size?.width ?? width,
          child: bubble!);
      widgets.add(GestureDetector(
          onTap: blankClick, child: Container()));
      widgets.add(bubbleView);
      return Stack(children: widgets);
    }
    return child;
  }
}
