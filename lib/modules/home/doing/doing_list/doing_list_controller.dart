import 'package:kellychat/base/base_controller.dart';
import '../../mine/user_info/model/user_info_entity.dart';
import '../../../user/user_center/my_doing/my_doing.dart';
import '../model/doing_hot_tags_entity.dart';
import '../model/doing_present_hot_tag_entity.dart';
import '../model/publish_doing_entity.dart';
import 'model/doing_list_entity.dart';
import 'view/doing_list_cell.dart';
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
  DoingListController({DoingPresentHotTagEntity? value}) {
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

    /// request - 获取当前热门的正在做标签列表
    requestHotTags();
  }

  /// 添加监听事件
  void addEventBusManager() {
    EventBusManager().listen<PublishDoingEntity>(this, (event) async {
      /// 刷新数据
      vm.value.doingHotTagsEntity = DoingPresentHotTagEntity()
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

    /// 获取邀约收件箱（用于判断是否有待处理邀约）
    requestInvitationInbox();
    final value = vm.value.doingHotTagsEntity;
    if (value == null) return;
    final name = value.tagName;
    if (name != null && name.isNotEmpty) {
      vm.value.activityTitle = name;
    }
    // vm.value.samePeopleCount = value.userCount ?? 0;
    vm.refresh();
    if (value.tagId != null) {
      pageNo = 1;
      await requestStatusDoingByTagId(value.tagId ?? 0);
    }
  }

  /// 下拉刷新
  @override
  Future onRefresh({bool? showLoading = false}) async {
    pageNo = 1;
    await requestStatusDoingByTagId(
      vm.value.doingHotTagsEntity?.tagId ?? 0,
      showLoad: false,
      refresh: true,
    );
    requestHotTags();
    refreshController.refreshCompleted();
  }

  /// 上拉加载更多（仅同频用户列表）
  @override
  void onLoading() {
    loadMoreStatusDoing();
  }

  Future<void> loadMoreStatusDoing() async {
    if (!vm.value.haveDoingPerson) {
      refreshController.loadComplete();
      return;
    }
    final tagId = vm.value.doingHotTagsEntity?.tagId;
    if (tagId == null) {
      refreshController.loadComplete();
      return;
    }
    pageNo++;
    final ok = await requestStatusDoingByTagId(
      tagId,
      showLoad: false,
      refresh: false,
    );
    if (!ok) {
      pageNo--;
      refreshController.loadComplete();
    }
  }

  /// 点击删除一起做的事
  Future clickDeleteDoing() async {
    final confirm = await pushCancelDoingDialog();
    if (!confirm) return;
    await requestCancelTogether(
      togetherId:
          vm.value.myDoing?.togetherPartner?.togetherId.toString() ?? '',
    );
    /// 刷新数据
    refreshData();
    vm.refresh();
  }

  /// 点击删除我正在做的事
  Future clickDeleteStatusDoing() async {
    final confirm = await pushCancelDoingDialog();
    if (!confirm) return;
    final result =
        await requestDeleteStatusDoing(vm.value.myDoing?.statusId ?? 0);
    vm.refresh();
    if (!result) return;
    if (canClosePage) {
      Future.delayed(Duration(microseconds: 1500), closePage);
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

  /// 计算一起做按钮状态
  TogetherButtonStatus togetherButtonStatusFor(DoingListList? item) {
    if (item == null) return TogetherButtonStatus.available;

    final myPartner = MyDoing().doing?.togetherPartner;

    // 已和对方建立连接
    if (myPartner?.userId == item.userId) {
      return TogetherButtonStatus.connected;
    }

    // 自己已和其他人建立连接
    if (myPartner != null) {
      return TogetherButtonStatus.disabled;
    }

    // 默认可用
    return TogetherButtonStatus.available;
  }

  /// 点击加入一起 一起做
  Future clickJoinTogether(DoingListList? item) async {
    if (item == null) return;

    final myPartner = MyDoing().doing?.togetherPartner;

    /// 已和对方建立连接，点击取消
    if (myPartner?.userId == item.userId) {
      final confirm = await pushCancelDoingDialog();
      if (!confirm) return;
      await requestCancelTogether(
        togetherId:
        vm.value.myDoing?.togetherPartner?.togetherId.toString() ?? '',
      );
      /// 刷新数据
      refreshData();
      vm.refresh();
      return;
    }

    /// 自己已与其他人建立连接
    if (myPartner != null) {
      await pushAlreadyConnectedDialog(myPartner.nickname ?? '');
      return;
    }

    /// 拉最新收件箱，避免缓存导致 pending 误判
    await requestInvitationInbox(useCache: false);

    // 有待处理的发出邀约（且不是发给当前用户）
    final pendingInvitation = vm.value.pendingSentInvitation;
    if (pendingInvitation != null &&
        pendingInvitation.targetUserId != item.userId) {
      final result = await pushCancelOldInvitationAlert(pendingInvitation);
      if (true != result) return;
      // 取消旧邀约
      final cancelled = await requestInvitationCancel(
        pendingInvitation.invitationId ?? 0,
      );
      if (!cancelled) return;
    }

    // /// push - 一起做 弹框确认alert
    // final confirm = await pushTogetherDoAlert(item);
    // if (true != confirm) return;

    /// 直连一起做 · POST /api/together/direct-connect
    final connected = await requestTogetherDirectConnect(
      toUserId: item.userId ?? 0,
      tagId: vm.value.doingHotTagsEntity?.tagId ?? vm.value.myDoing?.tagId ?? 0,
      force: true,
    );
    if (connected) vm.refresh();
    /// 刷新数据
    refreshData();
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
  List<DoingListList> get rows {
    return vm.value.rows ?? [];
  }

  /// 热门标签数据 列表
  List<DoingHotTagsEntity> get hotRows {
    return vm.value.hotTags;
  }

  /// 列表数量
  int get itemCount {
    if (vm.value.haveDoingPerson) {
      return rows.length;
    }
    return hotRows.length;
  }
}
