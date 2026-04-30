import 'package:get/get.dart';
import 'package:kellychat/base/base_bindings.dart';

import 'privacy_policy_controller.dart';

/// FileName: privacy_policy_binding
///
/// @Description 隐私政策-binding
class PrivacyPolicyBinding extends BaseBindings {
  @override
  void dependencies() {
    Get.lazyPut<PrivacyPolicyController>(() => PrivacyPolicyController());
  }
}

