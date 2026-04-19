import 'package:youth/base/base_controller.dart';
import 'view_model/message_vm.dart';
import 'controller/message_route_controller.dart';
export 'controller/message_route_controller.dart';
import 'controller/message_request_controller.dart';
export 'controller/message_request_controller.dart';

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

    /// mark - request
    ///
    /// GET /api/message/conversations 获取用户会话列表
    requestConversations();

    /// GET /api/status/my-doing
    requestMyDoing();

    /// 收到的敲一下列表 · GET /api/knock/received
    requestKnockReceived();
  }

  /// 点击删除我正在做的事
  Future clickDeleteStatusDoing() async {
    await requestDeleteStatusDoing(vm.value.myDoing?.statusId ?? 0);
    vm.refresh();
  }
}
