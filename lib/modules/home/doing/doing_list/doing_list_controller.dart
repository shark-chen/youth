import 'package:kellychat/base/base_controller.dart';
import 'package:kellychat/modules/home/mine/user_info/model/current_doing_state_entity.dart';
import '../../mine/user_info/model/user_info_entity.dart';
import '../../../user/user_center/my_doing/my_doing.dart';
import '../model/doing_hot_tags_entity.dart';
import '../model/doing_present_hot_tag_entity.dart';
import '../model/publish_doing_entity.dart';
import 'model/doing_list_entity.dart';
import 'package:kellychat/widget/fly_toast/fly_toast_util.dart';
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

      // await _openDoingListIfNeeded(_tagFromPublishDoing(event));
      await refreshData();
    });

    /// 个人资料改变
    EventBusManager().listen<UserInfoEntity>(this, (event) async {
      await UserCenter().init();
      vm.refresh();
    });
  }

  /// 已有正在做且清单 Controller 未注册时，进入 DoingListPage
  Future<void> _openDoingListIfNeeded(DoingPresentHotTagEntity? tag) async {
    if (tag == null || tag.tagId == null) return;
    if (Get.isRegistered<DoingListController>()) {
      Get.put<DoingListController>(DoingListController(value: tag));
    }
  }

  /// 刷新数据
  Future refreshData() async {
    requestMyDoing();

    onRefresh();

    /// 获取邀约收件箱（用于判断是否有待处理邀约）
    requestInvitationInbox();
    final value = vm.value.doingHotTagsEntity;
    if (value == null) return;
    final name = value.tagName;
    if (name != null && name.isNotEmpty) {
      vm.value.activityTitle = name;
    }
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
    final confirm = await pushDialog('是否移除当前状态', rightTitle: '确定');
    if (!confirm) return;
    final result =
        await requestDeleteStatusDoing(vm.value.myDoing?.statusId ?? 0);
    if (!result) return;
    if (canClosePage) {
      Future.delayed(Duration(microseconds: 1500), closePage);
    } else {
      await pushDoingPage();
    }
  }

  /// 敲一下飞入 Toast 背景色 RGB(101, 178, 91)
  static const Color knockFlyToastBgColor = Color.fromRGBO(101, 178, 91, 1);

  /// 敲一下问候飞入 Toast 文案
  static String knockGreetMessage(String? nickname) => '你敲了一下TA';

  /// 展示敲一下飞入 Toast（从 [knockButtonCenter] 飞向屏幕中心）
  void showKnockGreetFlyToast({
    Offset? knockButtonCenter,
    String? nickname,
  }) {
    final ctx = Get.context;
    if (ctx == null || knockButtonCenter == null) return;
    FlyToastUtil.show(
      ctx,
      startCenter: knockButtonCenter,
      message: knockGreetMessage(nickname),
      backgroundColor: knockFlyToastBgColor,
    );
  }

  /// 点击敲一下
  Future<void> clickKnock(
    DoingListList? item, {
    Offset? knockButtonCenter,
  }) async {
    final target = item;
    final userId = target?.userId;
    if (target == null || userId == null) return;
    showKnockGreetFlyToast(
      knockButtonCenter: knockButtonCenter,
      nickname: target.nickname,
    );
    final ok = await requestKnockSend(
      toUserId: userId,
      tagId: vm.value.myDoing?.tagId,
      showLoading: false,
    );
    if (ok) {
      vm.refresh();
    }
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
  Future clickJoinTogether(
    DoingListList? item,
    TogetherButtonStatus status,
  ) async {
    if (item == null) return;

    /// 我已经建立连接啦，点击其他用户一起做，提示报错
    if (TogetherButtonStatus.disabled == status) {
      await pushDialogAlert(
        content: '你正在与${item.nickname}一起做，请取消后再试',
        leftTitle: '',
        rightTitle: '我知道了',
      );
      return;
    }

    CurrentDoingStateEntity? result = await requestInvitationCurrentDoingState(
        targetUserId: item.userId ?? 0);
    if (result == null) return;

    /// 当前用户可以接受邀约
    if (true == result.canInviteTarget) {
      /// 当前用户可以接受邀约
      ///
      /// 1. 我当前是否有正在连接中的用户?
      if (true == result.hasActiveTogether) {
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

      /// 2. 当前我是否有邀约在「待接受」的状态?
      /// 弹窗提示:你向xxx(用户名)发起的「%s具体事项」一起做)等待对方接受中。继续操作将取消该邀约，
      /// 并建立新的一起估点击弹窗上的「取消」按钮，关闭弹窗;点击「继续」按钮，取前的激约。建立新的一起做连接云能店
      if (true == result.hasPendingInvitation) {
        final confirm = await pushDialog(
            '你向${result.pendingInvitationToUserNickname ?? '--'}发起的「${result.tagName ?? '--'}」一起做)等待对方接受中。继续操作将取消该邀约，并建立新的一起做。');
        if (!confirm) return;
      }

      /// 直连一起做 · POST /api/together/direct-connect
      final connected = await requestTogetherDirectConnect(
        toUserId: item.userId ?? 0,
        tagId:
            vm.value.doingHotTagsEntity?.tagId ?? vm.value.myDoing?.tagId ?? 0,
        force: true,
      );

      if (connected) {
        /// 刷新数据
        refreshData();
      }
    } else {
      if (status == TogetherButtonStatus.connected) {
        await clickDeleteDoing();
        return;
      }
      EasyLoading.showToast(result.cannotInviteReason ?? '当前用户不可接受邀约');
    }
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
