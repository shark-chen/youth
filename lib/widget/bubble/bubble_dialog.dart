import 'package:youth/base/base_controller.dart';
import 'bubble_view.dart';
export 'model/bubble_model.dart';

/// FileName bubble_dialog
///
/// @Author 谌文
/// @Date 2023/10/17 15:18
///
/// @Description 气泡弹框
class BubbleDialog {
  /// list: 列表数据
  /// context: 上下文
  /// details: 点击的事件,用于计算起点
  /// dy: Y的递增数量
  /// top: Y轴起点 此时context+dy都不生效
  /// bottom：设置了底部，top就不会生效
  /// left: x 轴起点
  /// width: 宽度 默认 136
  /// itemHeight: 单个选项的高度
  /// triangle: 是否有三角 默认有
  /// showBg: 是否展示 黑色背景
  /// selectedCall: 选择回调
  /// 单个选项的高度
  static Future show<T extends BubbleModel>(
    List<T> list,
    BuildContext context, {
    TapDownDetails? details,
    double? dy,
    double? top,
    double? bottom,
    double? left,
    double? dx,
    double? right,
    double? width = 104,
    double? itemHeight = 40,
    bool? triangle = true,
    bool? bottomTriangle = false,
    bool? showBg = false,
    double? triangleOffset = 25,
    Function(int, T)? selectedCall,
    Widget? customWidget,
  }) async {
    if (Lists.isEmpty(list)) return;
    final box = context.findRenderObject() as RenderBox; // 获取手势检测器所在的RenderBox
    Offset? offset;
    if (details?.localPosition != null) {
      offset =
          box.localToGlobal((details?.localPosition)!); // 将localPosition转换为屏幕位置
    }
    var defaultLeft = (offset?.dx ?? 0) + (dx ?? 0);
    defaultLeft = (defaultLeft + (width ?? 0)) > Get.mediaQuery.size.width
        ? (Get.mediaQuery.size.width - (width ?? 0) - 20)
        : defaultLeft;
    defaultLeft = defaultLeft < 0 ? 20 : defaultLeft;
    return await showDialog(
      barrierColor: Colors.transparent,
      barrierDismissible: true,
      context: context,
      useSafeArea: false,
      builder: (BuildContext context) {
        return BubbleWidget(
          list: list,
          top: top ?? (offset?.dy ?? 0) + (dy ?? 0),
          bottom: bottom,
          left: left ?? defaultLeft,
          right: right,
          width: width,
          itemHeight: itemHeight,
          triangle: triangle,
          bottomTriangle: bottomTriangle,
          showBg: showBg,
          triangleOffset: triangleOffset,
          selectedCall: selectedCall,
          customWidget: customWidget,
        );
      },
    );
  }
}
