import 'dart:async';
import 'package:youth/network/net/entry/doing/doing.dart';

import '../../../base/base_controller.dart';
import '../doing/model/doing_hot_tags_entity.dart';
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
    await requestHotTags();
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

  /// mark - request
  ///
  /// 获取当前热门的正在做标签列表
  Future requestHotTags() async {
    EasyLoading.show();
    var response =
        await Net.value<Doing>().requestHotTags<DoingHotTagsEntity>(limit: 20);
    EasyLoading.dismiss();
    if (response.succeed) {
      /// 配置热门标签（含空列表，用于清空展示）
      vm.value.configHotTags(response.values);
      vm.refresh();
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }

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

  /// mark - push
  ///
  /// 个人信息页面
  Future pushUserInfoPage() async {
    await Get.toNamed(Routes.userInfoPage);
  }
}
