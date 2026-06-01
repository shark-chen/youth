import 'package:flutter/services.dart';
import 'package:kellychat/base/base_controller.dart';
import 'package:kellychat/network/net/entry/friend/friend.dart';
import '../../functions/load_item/load_item.dart';
import 'view/tabs.dart';
import 'view_model/home_vm.dart';

/// FileName home_controller
///
/// @Author 谌文
/// @Date 2023/12/18 15:37
///
/// @Description APP-home控制器
class HomeController extends BaseController {
  /// vm
  Rx<HomeVm> vm = HomeVm().obs;

  /// 页面
  List<Widget> pages = getPages();

  /// tab页面切换类
  late PageController pageController =
      PageController(initialPage: vm.value.currentTab.index);

  /// 最近一次处理过的邀请码，防止重复调用
  String? _lastHandledInviteCode;

  HomeController() {
    listenAppLifecycleState = true;
  }

  @override
  void onInit() async {
    super.onInit();
    EasyLoading.dismiss();
    String? tab = Get.parameters['tab'];
    if (Strings.isNotEmpty(tab)) {
      vm.value.currentTab = TabsKey[tab];
    }
  }

  @override
  void onReady() async {
    super.onReady();

    /// 首页加载项目
    LoadItem().homeLoad();

    EventBusManager().fire(HomeTabs.values[vm.value.currentTab.index]);
  }

  @override
  void changeMetricsUpdateUI() {
    super.changeMetricsUpdateUI();
    vm.refresh();
  }

  /// 获取页面
  static List<Widget> getPages() {
    List<Widget> pages = [];
    for (int i = 0; i < HomePages.length; i++) {
      pages.add(HomePages[i].page);
    }
    return pages;
  }

  /// 点击tab
  void switchTab(int index) async {
    if (index > 2) return;
    EasyLoading.dismiss();

    /// 切换tab发送通知
    EventBusManager().fire(HomeTabs.values[index]);

    /// 保证更新后url会更新
    pageController.jumpToPage(index);
    vm.value.currentTab = HomeTabs.values[index];
    vm.refresh();
  }

  /// MARK- APP生命状态
  @override
  void appLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
    }
  }

  /// 检查粘贴板是否包含邀请码或邀请链接
  Future<void> _checkClipboardForInviteCode() async {
    try {
      final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
      final text = clipboardData?.text;
      if (text == null || text.isEmpty) return;

      final inviteCode = _extractInviteCode(text);
      if (inviteCode == null || inviteCode.isEmpty) return;
      if (inviteCode == _lastHandledInviteCode) return;
      final response = await Net.value<Friend>()
          .requestAcceptInvitationByCode<dynamic>(inviteCode: inviteCode);
      if (response.succeed) {
        _lastHandledInviteCode = inviteCode;
        EasyLoading.showToast('接受邀约成功');
      }
    } catch (_) {}
  }

  /// 从纯文本或链接中提取邀请码
  /// 纯字符串: 24A76861A
  /// 链接: https://kellychat.com/invite/24A76861A
  String? _extractInviteCode(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return null;

    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      try {
        final uri = Uri.parse(trimmed);
        final segments = uri.pathSegments;
        if (segments.isNotEmpty &&
            uri.host == 'kellychat.com' &&
            segments.length >= 2 &&
            segments[segments.length - 2] == 'invite') {
          return segments.last;
        }
      } catch (_) {
        return null;
      }
    }

    // 视为纯字符串邀请码，基础校验：非空即可
    return trimmed;
  }
}
