import 'package:youth/base/base_stateless_widget.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../config/environment_config/config.dart';
import '../../../routes/app_pages.dart';
import '../model/network_model_utils.dart';
import '../view_model/draggable_net_vm.dart';

/// FileName draggable_net_view
///
/// @Author 谌文
/// @Date 2025/4/1 15:53
///
/// @Description 拖拽网络view
class DraggableNetWidget {
  /// 拖拽VM
  static Rx<DraggableNetVM> vm = DraggableNetVM().obs;

  /// 创建可拖动网络查看控件
  static TransitionBuilder init() {
    vm.value.refresh = vm.refresh;
    if (environment == Environment.prod) {
      return EasyLoading.init();
    } else {
      return EasyLoading.init(
        builder: (context, child) {
          return Stack(
            children: [
              child!,
              Obx(
                () => Positioned(
                  left: vm.value.left,
                  top: vm.value.top,
                  child: Visibility(
                    visible: NetworkModelUtils().apiIsOpen == true,
                    child: GestureDetector(
                      onLongPressMoveUpdate: vm.value.onLongPressMoveUpdate,
                      onLongPressEnd: vm.value.onLongPressEnd,
                      onLongPressStart: vm.value.onLongPressStart,
                      child: FloatingActionButton(
                        onPressed: () => Get.toNamed(Routes.networkLookPage),
                        child: Text('api'),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }
}
