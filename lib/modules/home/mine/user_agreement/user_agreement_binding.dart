import 'package:kellychat/base/base_bindings.dart';

import 'user_agreement_controller.dart';

/// FileName: user_agreement_binding
///
/// @Author 谌文
/// @Date 2026/4/30
///
/// @Description 用户服务协议-binding
class UserAgreementBinding extends BaseBindings {
  @override
  void dependencies() {
    Get.lazyPut<UserAgreementController>(() => UserAgreementController());
  }
}

