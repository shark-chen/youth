import 'package:youth/modules/home/message/message_controller.dart';

import '../../../base/base_bindings.dart';
import '../doing/doing_controller.dart';
import '../hall/hall_controller.dart';
import '../mine/mine_controller.dart';
import 'home_controller.dart';

/// FileName home_binding
///
/// @Author 谌文
/// @Date 2023/12/18 15:37
///
/// @Description APP-home-binding
class HomeBinding extends BaseBindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
    Get.put<HallController>(HallController());
    Get.put<DoingController>(DoingController());
    Get.put<MessageController>(MessageController());
    Get.put<MineController>(MineController());
  }
}
