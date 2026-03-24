import 'package:get/get.dart';
import 'base_web_view_controller.dart';

class BaseWebViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BaseWebViewController>(BaseWebViewController());
  }
}
