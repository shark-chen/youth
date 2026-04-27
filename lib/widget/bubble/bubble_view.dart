import 'dart:math';
import 'package:kellychat/widget/bubble/model/bubble_model.dart';
import '../../base/base_stateless_widget.dart';
import '../triangle/triangle_painter.dart';

/// FileName bubble_view
///
/// @Author 谌文
/// @Date 2023/10/17 15:12
///
/// @Description 气泡View
class BubbleWidget<T extends BubbleModel> extends StatelessWidget {
  const BubbleWidget({
    Key? key,
    required this.list,
    this.top,
    this.bottom,
    this.left = 20,
    this.right,
    this.width = 104,
    this.itemHeight = 40,
    this.triangle = true,
    this.selectedCall,
    this.showBg = false,
    this.triangleOffset = 25,
    this.bottomTriangle = false,
    this.customWidget,
  }) : super(key: key);

  /// Y坐标起始点
  final double? top;

  /// 离底部距离 设置了底部，top就不会生效
  final double? bottom;

  /// x坐标起始点 默认20
  final double? left;

  /// 距离右边的距离 默认20
  final double? right;

  /// 宽度 默认 136
  final double? width;

  /// 单个选项的高度
  final double? itemHeight;

  /// 是否有三角 默认有
  final bool? triangle;

  /// 是否有三角偏移量
  final double? triangleOffset;

  /// 下三角
  final bool? bottomTriangle;

  /// 数据列表
  final List<T> list;

  /// 选择回调
  final Function(int, T)? selectedCall;

  /// 是否显示黑色背景 ，默认不展示
  final bool? showBg;

  /// 自定义UI
  final Widget? customWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment:
            bottom != null ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment:
            bottom != null ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          SizedBox(height: top ?? 10),

          /// 三角
          Visibility(
            visible: triangle ?? true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: (right ?? 0) > 0
                        ? (screenWidth - (triangleOffset ?? 25) - (right ?? 20))
                        : (left ?? 20) + (triangleOffset ?? 25)),
                Transform.rotate(
                  angle: pi * 2,
                  child: CustomPaint(
                    size: const Size(20, 8),
                    painter: TrianglePainter(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 4),

          /// 列表
          Padding(
            padding: (right ?? 0) > 0
                ? EdgeInsets.only(right: right ?? 20)
                : EdgeInsets.only(left: left ?? 20),
            child: customWidget ??
                Row(
                  mainAxisAlignment: (right ?? 0) > 0
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Container(
                      width: width ?? 104,
                      height: (list.length > 8 ? 8 : list.length) *
                          ((itemHeight ?? 40) + 1),
                      constraints: const BoxConstraints(minWidth: 104),
                      padding: const EdgeInsets.only(left: 13, right: 0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(2, 4),
                              color: ThemeColor.shadowGrayColor,
                              blurRadius: 6)
                        ],
                      ),
                      child: MediaQuery.removePadding(
                        removeTop: true,
                        removeBottom: true,
                        context: context,
                        child: ListView.separated(
                            itemBuilder: (BuildContext context, int index) {
                              var item = list[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.back();
                                  selectedCall?.call(index, list[index]);
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    color: Colors.white,
                                    alignment: Alignment.centerLeft,
                                    height: itemHeight,
                                    padding: const EdgeInsets.only(right: 3),
                                    width: width ?? 60,
                                    child: Text(
                                      item.title.tr,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: list[index].selected == true
                                              ? ThemeColor.blueColor
                                              : ThemeColor.mainTextColor,
                                          fontSize: item.fontSize ?? 14,
                                          fontWeight: item.fontWeight ??
                                              FontWeight.w500),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) => Container(
                                    color: ThemeColor.lineColor, height: 1),
                            itemCount: list.length),
                      ),
                    )
                  ],
                ),
          ),
          const SizedBox(width: 4),
          Visibility(
            visible: bottomTriangle ?? false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: (right ?? 0) > 0
                        ? (screenWidth - (triangleOffset ?? 25) - (right ?? 20))
                        : (left ?? 20) + (triangleOffset ?? 25)),
                Transform.rotate(
                  angle: pi * 1,
                  child: CustomPaint(
                    size: const Size(20, 8),
                    painter: TrianglePainter(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          /// 黑色背景
          Visibility(
            visible: showBg ?? false,
            child: Expanded(
              child: GestureDetector(
                onTap: Get.back,
                child: Container(color: Colors.black54),
              ),
            ),
          ),
          const SizedBox(width: 4),
          SizedBox(height: bottom ?? 0),
        ],
      ),
    );
  }
}
