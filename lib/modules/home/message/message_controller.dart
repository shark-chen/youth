import 'package:youth/base/base_controller.dart';
import 'view_model/message_vm.dart';
import 'controller/message_route_controller.dart';
export 'controller/message_route_controller.dart';

/// FileName: message_controller
///
/// @Author 谌文
///
///
/// @Date 2026/3/10 19:53
///
/// @Description 消息模块-controller
class MessageController extends BaseController {
  /// vm
  Rx<MessageVM> vm = MessageVM().obs;

  @override
  void onInit() async {
    super.onInit();
    title = '消息';
  }
}
