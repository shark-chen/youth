import 'package:get/get.dart';
import 'package:kellychat/base/base_bindings.dart';

import 'minor_protection_controller.dart';

/// FileName: minor_protection_binding
///
/// @Description 未成年人个人信息保护规则-binding
class MinorProtectionBinding extends BaseBindings {
  @override
  void dependencies() {
    Get.lazyPut<MinorProtectionController>(() => MinorProtectionController());
  }
}

