import 'package:youth/base/base_bindings.dart';
import 'city_set_controller.dart';

/// FileName: city_set_binding
///
/// @Author 谌文
/// @Date 2026/3/26 22:29
///
/// @Description 地区设置-binding
class CitySetBinding extends BaseBindings {
  @override
  void dependencies() {
    Get.lazyPut<CitySetController>(() => CitySetController());
  }
}
