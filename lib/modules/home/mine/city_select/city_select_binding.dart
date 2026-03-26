import 'package:youth/base/base_bindings.dart';

import 'city_select_controller.dart';

/// FileName: city_select_binding
///
/// @Author 谌文
/// @Date 2026/3/26 18:30
///
/// @Description
class CitySelectBinding extends BaseBindings {

   @override
   void dependencies() {
       Get.lazyPut<CitySelectController>(()=> CitySelectController());
   }
}