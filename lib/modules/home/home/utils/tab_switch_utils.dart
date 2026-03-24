
import '../view/tabs.dart';
import '../home_controller.dart';
import 'package:get/get.dart';

/// FileName tab_switch_utils
///
/// @Author 谌文
/// @Date 2023/6/16 13:24
///
/// @Description 大厅tab切换工具类
class TabSwitchUtils {
  static switchTab(
    HomeTabs tab,
  ) {
    try {
      var controller = Get.find<HomeController>();
      controller.switchTab(tab.index);
    } catch (_) {}
  }

}
