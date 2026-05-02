import 'package:kellychat/base/base_controller.dart';
import 'package:kellychat/utils/utils/language/lang_value.dart';
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

}
