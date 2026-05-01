import 'package:kellychat/base/base_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:kellychat/utils/utils/language/lang_value.dart';
import 'package:kellychat/modules/home/doing/doing_nav_ids.dart';
import 'package:kellychat/modules/routes/app_pages.dart';
import '../../functions/load_item/load_item.dart';
import 'view/tabs.dart';
import 'view_model/home_vm.dart';
import 'dart:ui' as ui;

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

  /// 冷启动首次进入首页：自动打开 DoingList（只触发一次）
  bool _autoOpenedDoingList = false;
  bool _autoOpeningDoingList = false;

  /// tab页面切换类
  late PageController pageController =
      PageController(initialPage: vm.value.currentTab.index);

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

    // 冷启动首次进入：默认仍是 Hall，但自动切到 Doing 并 push DoingListPage
    if (_autoOpenedDoingList || _autoOpeningDoingList) return;
    _autoOpeningDoingList = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // 先切到 Doing tab，让 DoingTabHost/nested navigator 建立起来
      switchTab(HomeTabs.doing.index);
      // 再等一帧，确保 nested navigator 已挂载
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        try {
          await Get.toNamed(
            Routes.doingListPage,
            id: doingNavigatorId,
          );
          _autoOpenedDoingList = true;
        } catch (_) {
          // 若 nested navigator 尚未就绪，留待下次进入 onReady 再尝试
          _autoOpenedDoingList = false;
        } finally {
          _autoOpeningDoingList = false;
        }
      });
    });
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

  /// 获取首页截图
  Future<ui.Image?> get getHomeScreenshotImage async {
    return await vm.value.getHomeScreenshotImage;
  }
}
