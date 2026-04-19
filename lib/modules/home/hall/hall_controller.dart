import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:youth/modules/home/hall/controller/hall_request_controller.dart';
import 'package:youth/network/net/entry/doing/doing.dart';
import 'package:youth/utils/authority/photos_authority.dart';
import '../../../base/base_controller.dart';
import 'model/smart_match_people_entity.dart';
import 'view_model/hall_vm.dart';

export 'controller/hall_request_controller.dart';

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

  final ImagePicker _imagePicker = ImagePicker();

  @override
  Future onInit() async {
    super.onInit();
    buildEditingManage();

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
  Future clickStartFindFriend(String content) async {
    final succeed = await requestMatchSearch(description: content);
    if (succeed) {
      vm.value.findMode = FindMode.findFriend;
    }
    vm.refresh();
  }

  /// 是否是找友提示语模式
  bool get findPrompt {
    return vm.value.findPrompt;
  }

  /// 点击查看个人信息
  Future clickLookUserInfo(SmartMatchPeopleList? item) async {
    if (item?.userId == null) return;
    await pushProfile(userId: '${item?.userId}');
  }

  /// mark - push
  ///
  /// 个人信息页面
  Future pushUserInfoPage() async {
    await Get.toNamed(Routes.minePage);
  }

  /// push - 个人信息页面
  Future<void> pushProfile({required String userId}) async {
    await Get.toNamed(Routes.userInfoPage, parameters: {
      'userId': userId,
    });
  }
}
