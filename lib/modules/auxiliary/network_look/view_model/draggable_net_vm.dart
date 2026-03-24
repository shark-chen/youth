import 'package:youth/base/base_vm.dart';
import '../model/draggable_model.dart';

/// FileName draggable_net_vm
///
/// @Author 谌文
/// @Date 2025/4/2 16:30
///
/// @Description 拖拽API的vm
class DraggableNetVM extends BaseVM {
  /// 拖拽数据模型
  DraggableModel draggableModel = DraggableModel();

  /// 左侧坐标
  double get left => draggableModel.left;

  /// 顶部坐标
  double get top => draggableModel.top;

  /// 长按开始
  void onLongPressStart(LongPressStartDetails details) {
    EasyLoading.showToast('可以拖拽api到任意位置了');
  }

  /// 长按拖拽
  void onLongPressMoveUpdate(LongPressMoveUpdateDetails details) {
    Offset globalPosition = details.globalPosition;
    draggableModel.left = globalPosition.dx - 30;
    draggableModel.top = globalPosition.dy - 30;
    refresh?.call();
  }

  /// 长按拖拽结束
  void onLongPressEnd(LongPressEndDetails details) {
    /// 处理拖拽超过边界问题
    if (draggableModel.left * 2 < screenWidth) {
      draggableModel.left = -10;
    } else {
      draggableModel.left = screenWidth - 50;
    }
    if(draggableModel.top <= 20) {
      draggableModel.top = 20;
    }
    refresh?.call();
  }
}
