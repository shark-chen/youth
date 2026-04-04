import 'dart:async';
import '../../../base/base_controller.dart';
import 'view_model/hall_vm.dart';

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

  @override
  Future onInit() async {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void changeMetricsUpdateUI() {
    vm.refresh();
  }

  /// MARK- APP生命状态
  @override
  void appLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {}
  }

  /// 下拉刷新
  @override
  Future onRefresh() async {}

  /// MARK - method
  ///
  /// 获取列表数量
  int itemCount() => vm.value.itemCount();

  /// 点击开始找人
  void clickStartFindFriend() {
    vm.value.findMode = FindMode.findFriend;
    vm.refresh();
  }

  /// 是否是找友提示语模式
  bool get findPrompt {
    return vm.value.findPrompt;
  }
}
