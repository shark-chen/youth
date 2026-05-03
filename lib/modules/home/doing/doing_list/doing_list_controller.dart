import 'package:kellychat/base/base_controller.dart';
import '../../mine/user_info/model/user_info_entity.dart';
import '../model/doing_hot_tags_entity.dart';
import '../model/publish_doing_entity.dart';
import 'model/doing_list_entity.dart';
import 'view_model/doing_list_vm.dart';
import 'controller/doing_list_request_controller.dart';
export 'controller/doing_list_request_controller.dart';
import 'controller/doing_list_route_controller.dart';
export 'controller/doing_list_route_controller.dart';
import '../model/doing_nav_ids.dart';

/// FileName: doing_list_controller
///
/// @Author 谌文
/// @Date 2026/3/9 23:18
///
/// @Description 正在做的清单-controller
class DoingListController extends BaseController {
  DoingListController({DoingHotTagsEntity? value}) {
    vm.value.doingHotTagsEntity = value;
  }

  /// vm
  Rx<DoingListVM> vm = DoingListVM().obs;

  /// 当前嵌套路由栈是否还能 pop（例如底层仍有 DoingPage）
  bool get canClosePage =>
      Get.nestedKey(doingNavigatorId)?.currentState?.canPop() ?? false;

  @override
  void closePage<T>({T? result}) {
    Get.back(id: doingNavigatorId);
  }

  @override
  void onInit() async {
    super.onInit();
    title = '我正在';

    /// 添加监听事件
    addEventBusManager();

    /// 刷新数据
    refreshData();
  }

  /// 添加监听事件
  void addEventBusManager() {
    EventBusManager().listen<PublishDoingEntity>(this, (event) async {
      /// 刷新数据
      vm.value.doingHotTagsEntity = DoingHotTagsEntity()
        ..tagId = event.tagId
        ..tagName = event.tagName;
      await refreshData();
    });

    /// 个人资料改变
    EventBusManager().listen<UserInfoEntity>(this, (event) async {
      await UserCenter().init();
      vm.refresh();
    });
  }

  /// 刷新数据
  Future refreshData() async {
    requestMyDoing();
    final value = vm.value.doingHotTagsEntity;
    if (value == null) return;
    final name = value.tagName;
    if (name != null && name.isNotEmpty) {
      vm.value.activityTitle = name;
    }
    vm.value.samePeopleCount = value.userCount ?? 0;
    vm.refresh();
    if (value.tagId != null) {
      await requestStatusDoingByTagId(value.tagId ?? 0);
    }
  }

  /// 点击删除我正在做的事
  Future clickDeleteStatusDoing() async {
    final result =
        await requestDeleteStatusDoing(vm.value.myDoing?.statusId ?? 0);
    vm.refresh();
    if (!result) return;
    if (canClosePage) {
      closePage();
    } else {
      await pushDoingPage();
    }
  }

  /// 点击敲一下
  Future clickKnock(DoingListList? item) async {
    if (item?.userId == null) return;
    await requestKnockSend(
      toUserId: item?.userId ?? 0,
      tagId: vm.value.myDoing?.tagId,
    );
    vm.refresh();
  }

  /// 点击加入一起 一起做
  Future clickJoinTogether(DoingListList? item) async {
    if (item == null) return;

    /// push - 一起做 弹框确认alert
    final result = await pushTogetherDoAlert(item);
    if (true != result) return;
    if (item.togetherId == null) {
      /// 发送邀约 · POST /api/invitation/send
      await requestInvitationSend(
        toUserId: item.userId ?? 0,
        invitationType: 1,
        tagId: vm.value.doingHotTagsEntity?.tagId ?? 0,
      );
      return;
    }
    await requestTogetherJoin(item.togetherId ?? '0');
    vm.refresh();
  }

  /// 点击查看个人信息
  Future clickLookUserInfo(DoingListList? item) async {
    if (item?.userId == null) return;
    await pushProfile(userId: '${item?.userId}');
  }

  /// 点击邀请好友
  Future clickInvitationFriend() async {
    /// 生成邀约码 · POST /api/invitation/generate-code
    final inviteFriendEntity = await requestInvitationGenerateCode(
      invitationType: 1,
      tagId: vm.value.myDoing?.tagId ?? 0,
    );
    if (inviteFriendEntity == null) return;

    /// push - 邀请
    await pushInviteAlert(inviteFriendEntity);
  }

  /// mark - method
  ///
  /// 获取列表数据源
  /// 获取列表数据
  List<DoingListList>? get rows {
    return vm.value.rows;
  }
}
