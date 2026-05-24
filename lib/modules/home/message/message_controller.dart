import 'package:kellychat/base/base_controller.dart';
import '../doing/doing_list/model/invitation_item_entity.dart';
import '../home/view/tabs.dart';
import '../mine/user_info/model/user_info_entity.dart';
import 'view_model/message_vm.dart';
export 'controller/message_route_controller.dart';
import 'controller/message_request_controller.dart';
export 'controller/message_request_controller.dart';
import 'package:kellychat/network/im/im_incoming_message_event.dart';
import 'package:kellychat/network/im/im_service.dart';

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

    /// 添加通知
    addEventBusManager();

    /// IM 长连接（SockJS + STOMP）
    try {
      await Get.find<ImService>().connect();
    } catch (_) {}

    /// mark - request
    ///
    /// GET /api/message/conversations 获取用户会话列表
    requestConversations();

    /// GET /api/status/my-doing
    requestMyDoing();

    /// 敲一下记录
    requestKnockInbox();

    /// 邀约记录
    requestInvitationInbox();
  }

  /// 添加通知
  void addEventBusManager() {
    EventBusManager().listen<UserInfoEntity>(this, (event) async {
      await UserCenter().init();
      vm.refresh();
    });
    EventBusManager().listen<ImIncomingMessageEvent>(this, (event) async {
      await requestConversations(showLoad: false);
    });

    EventBusManager().listen<HomeTabs>(this, (tab) async {
      if (tab == HomeTabs.message) {
        refreshData(showLoad: false);
      }
    });
  }

  /// 点击删除我正在做的事
  Future clickDeleteStatusDoing() async {
    await requestDeleteStatusDoing(vm.value.myDoing?.statusId ?? 0);
    vm.refresh();
  }

  /// 侧滑删除会话
  Future<bool> clickDeleteConversation(int? conversationId) async {
    if (conversationId == null || conversationId <= 0) return false;
    final ok = await requestDeleteConversation(conversationId: conversationId);
    if (ok) {
      vm.value.removeConversation(conversationId);
      vm.refresh();
    }
    return ok;
  }

  /// 刷新数据
  Future refreshData({bool? showLoad = true}) async {
    /// request - 敲一下收件箱
    requestKnockInbox(showLoad: showLoad);
  }

  /// 下拉刷新
  @override
  Future<void> onRefresh() async {
    await requestConversations();
    await requestMyDoing();
    requestInvitationInbox();
    await refreshData();
    refreshController.refreshCompleted();
  }

  /// 邀约记录
  List<InvitationItemEntity>? get invitationRow {
    return vm.value.invitationRow;
  }
}
