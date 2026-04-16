import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:youth/network/net/entry/doing/doing.dart';
import 'package:youth/utils/authority/photos_authority.dart';
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

  final ImagePicker _imagePicker = ImagePicker();

  @override
  Future onInit() async {
    super.onInit();
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

  /// mark - request
  ///
  /// 获取配对建议列表
  Future requestMatchSuggestions() async {
    EasyLoading.show();
    var response =
        await Net.value<Doing>().requestMatchSuggestions<String>();
    EasyLoading.dismiss();
    if (response.succeed) {
      /// 配置AI标签（含空列表，用于清空展示）
      vm.value.configAiTags(response.values);
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
  /// 相册选图：关闭 Loading、下一帧再调起，避免遮罩拦截系统相册触摸；iOS 关闭全量元数据
  Future<XFile?> _pickImageFromGallery() async {
    EasyLoading.dismiss();
    await Future<void>.delayed(const Duration(milliseconds: 80));
    final scheduler = SchedulerBinding.instance;
    if (scheduler.schedulerPhase != SchedulerPhase.idle) {
      await scheduler.endOfFrame;
    }
    return _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 2048,
      maxHeight: 2048,
      requestFullMetadata: false,
    );
  }

  /// 个人信息页面
  Future<XFile?> pushUserInfoPage() async {
    if (!await PhotosAuthority.request()) return null;
    try {
      return await _pickImageFromGallery();
    } catch (_) {
      EasyLoading.showToast('选择图片失败');
      return null;
    }
  }
}
