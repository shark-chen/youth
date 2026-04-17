import 'dart:async';

import 'package:youth/base/base_controller.dart';
import 'package:youth/network/net/entry/doing/doing.dart';

import 'model/doing_hot_tags_entity.dart';
import 'model/publish_doing_entity.dart';
import 'view_model/doing_vm.dart';
import 'controller/doing_request_controller.dart';
export 'controller/doing_request_controller.dart';

/// FileName doing_controller
///
/// @Author 谌文
/// @Date 2023/8/24 11:18
///
/// @Description 正在-控制器
class DoingController extends BaseController {
  /// vm
  Rx<DoingVM> vm = DoingVM().obs;

  @override
  void onInit() async {
    super.onInit();
    buildEditingManage();

    /// 获取当前热门的正在做标签列表
    await requestHotTags();
  }

  /// 点击发布正在做的事
  Future clickPublishDoing(String content) async {
    final result = await requestPostStatusDoing(tagName: content);
    if (result) {
      editingController?.text = '';
    }
  }

  /// mark - push
  ///
  /// push-正在做的清单-页面
  Future pushDoingListPage(DoingHotTagsEntity tag) async {
    await Get.toNamed(Routes.doingListPage, arguments: tag);
  }
}
