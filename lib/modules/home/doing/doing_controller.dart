import 'dart:async';
import 'package:kellychat/base/base_controller.dart';
import '../home/view/tabs.dart';
import '../mine/user_info/model/user_info_entity.dart';
import 'model/doing_nav_ids.dart';
import 'model/doing_hot_tags_entity.dart';
import 'model/doing_present_hot_tag_entity.dart';
import 'model/publish_doing_entity.dart';
import 'package:kellychat/modules/user/user_center/my_doing/my_doing.dart';
import '../home/utils/invitation_code_utils.dart';
import 'view_model/doing_vm.dart';
import 'controller/doing_request_controller.dart';
export 'controller/doing_request_controller.dart';
import 'controller/doing_route_controller.dart';
export 'controller/doing_route_controller.dart';

/// FileName doing_controller
///
/// @Author 谌文
/// @Date 2023/8/24 11:18
///
/// @Description 正在-控制器
class DoingController extends BaseController {
  /// vm
  Rx<DoingVM> vm = DoingVM().obs;

  /// 当前嵌套路由栈是否还能 pop（例如底层仍有 DoingPage）
  bool get canClosePage =>
      Get.nestedKey(doingNavigatorId)?.currentState?.canPop() ?? false;

  @override
  void onInit() async {
    super.onInit();
    buildEditingManage();

    /// 添加通知
    addEventBusManager();

    /// 获取个人信息 · GET /api/user/profile
    requestUserProfile();

    /// 获取当前热门的正在做标签列表
    await requestPresetTags();
  }

  @override
  void closePage<T>({T? result}) {
    Get.back(id: doingNavigatorId);
  }

  /// 添加通知
  void addEventBusManager() {
    EventBusManager().listen<UserInfoEntity>(this, (event) async {
      await UserCenter().init();
      vm.refresh();
    });
    EventBusManager().listen<PublishDoingEntity?>(this, (event) async {
      await _openDoingListIfNeeded(_tagFromPublishDoing(event));
    });
    EventBusManager().listen<HomeTabs>(this, (tab) async {
      if (tab == HomeTabs.doing) {
        await refreshData();
      }
    });
  }

  DoingPresentHotTagEntity? _tagFromPublishDoing(PublishDoingEntity? event) {
    if (event == null) return null;
    return DoingPresentHotTagEntity()
      ..tagId = event.tagId
      ..tagName = event.tagName;
  }

  DoingPresentHotTagEntity? _tagFromMyDoing() {
    final doing = MyDoing().doing;
    if (doing == null) return null;
    return DoingPresentHotTagEntity()
      ..tagId = doing.tagId
      ..tagName = doing.tagName;
  }

  /// 发布正在做后，若当前不在 DoingListPage 则进入清单页
  Future<void> _openDoingListIfNeeded(DoingPresentHotTagEntity? tag) async {
    if (tag == null || tag.tagId == null) {
      if (canClosePage) {
        closePage();
      }
      return;
    }
    print('isDoingListPageShowing');
    if (isDoingListPageShowing) return;
    print('pushDoingListPage');
    await pushDoingListPage(tag);
  }

  /// 刷新数据
  Future refreshData() async {}

  /// 点击选择你想发布的事情
  Future clickSelectPublishDoing(DoingPresentHotTagEntity tag) async {
    if (Strings.isEmpty(tag.tagName)) return;
    final result = await requestPostStatusDoing(
        tagName: '${tag.icon ?? ''} ${tag.tagName ?? ''}');
    if (result == null) return;
    await pushDoingListPage(tag);
  }

  /// 点击发布正在做的事 - 输入框发布
  Future clickPublishDoing(String content) async {
    /// 邀请口令：数字+字母组合，长度恰好 9 位（如 24A76861A）
    final inviteCode = InvitationCodeUtils.normalizeInvitationCode(content);
    if (inviteCode != null) {
      await requestAcceptInvitationByCode(inviteCode);
      return;
    }

    final result = await requestPostStatusDoing(tagName: content);
    if (result == null) return;
    final tag = DoingPresentHotTagEntity()
      ..tagName = result.tagName
      ..tagId = result.tagId;
    await pushDoingListPage(tag);
  }
}
