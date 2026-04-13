import 'package:youth/base/base_bindings.dart';

import 'feedback_controller.dart';

/// FileName: feedback_binding
///
/// @Author 谌文
/// @Date 2026/4/12 21:31
///
/// @Description
class FeedbackBinding extends BaseBindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedbackController>(() => FeedbackController());
  }
}
