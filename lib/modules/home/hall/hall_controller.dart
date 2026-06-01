import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:kellychat/base/base_controller.dart';
import 'package:kellychat/modules/home/home/utils/invitation_code_utils.dart';
import '../mine/user_info/model/user_info_entity.dart';
import 'model/smart_match_people_entity.dart';
import 'view_model/hall_vm.dart';
import 'controller/hall_request_controller.dart';
export 'controller/hall_request_controller.dart';
import 'controller/hall_route_controller.dart';
export 'controller/hall_route_controller.dart';

/// FileName hall_controller
///
/// @Author 谌文
/// @Date 2023/8/23 15:57
///
/// @Description 首页控制器
class HallController extends BaseController
    with GetSingleTickerProviderStateMixin {
  /// view_model
  Rx<HallVM> vm = HallVM().obs;

  bool _prefetchingMatchSuggestions = false;

  /// 预拉建议成功后递增，驱动 HotTagsWidget 向栈内补足卡片
  int hotTagsPrefetchToken = 0;

  @override
  Future onInit() async {
    super.onInit();
    UserCenter().init();
    buildEditingManage();

    /// 添加通知
    addEventBusManager();

    /// 获取个人信息 · GET /api/user/profile
    requestUserProfile();
  }

  @override
  void onReady() async {
    super.onReady();

    /// 获取配对建议列表
    await requestMatchSuggestions();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// MARK- APP生命状态
  @override
  void appLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {}
  }

  /// 添加通知
  void addEventBusManager() {
    EventBusManager().listen<UserInfoEntity>(this, (event) async {
      await UserCenter().init();
      vm.refresh();
    });
  }

  /// MARK - method
  ///
  /// 获取列表数量
  int itemCount() => vm.value.itemCount();

  /// 点击开始找人
  Future clickStartFindFriend(String content) async {
    /// 邀请口令：数字+字母组合，长度恰好 9 位（如 24A76861A）
    final inviteCode = InvitationCodeUtils.normalizeInvitationCode(content);
    if (inviteCode != null) {
      await requestAcceptInvitationByCode(inviteCode);
      return;
    }
    final succeed = await requestMatchSearch(description: content);
    if (succeed) {
      vm.value.findMode = FindMode.findFriend;
    }
    vm.refresh();
  }

  /// 点击新对话
  void clickNewChat() {
    vm.value.findMode = FindMode.findPrompt;
    editingController?.text = '';
    vm.refresh();
  }

  /// 是否是找友提示语模式
  bool get findPrompt {
    return vm.value.findPrompt;
  }

  /// 热门标签卡片剩余 4 张时预拉建议
  Future onHotTagsRemainingFour() async {
    if (_prefetchingMatchSuggestions) return;
    _prefetchingMatchSuggestions = true;
    try {
      final ok = await requestMatchSuggestions(
        append: true,
        showLoading: false,
      );
      if (ok) {
        hotTagsPrefetchToken++;
        vm.refresh();
      }
    } finally {
      _prefetchingMatchSuggestions = false;
    }
  }

  /// 点击查看个人信息
  Future clickLookUserInfo(SmartMatchPeopleList? item) async {
    if (item?.userId == null) return;
    await pushProfile(userId: '${item?.userId}');
  }

  /// 点击找一找
  Future clickFindPerson(String content) async {
    editingController?.text = content;
    await clickStartFindFriend(content);
  }
}
