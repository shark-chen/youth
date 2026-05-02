import 'dart:async';
import 'package:kellychat/base/base_controller.dart';
import 'model/doing_nav_ids.dart';
import 'model/doing_hot_tags_entity.dart';
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

    /// 获取个人信息 · GET /api/user/profile
    requestUserProfile();

    /// 获取当前热门的正在做标签列表
    await requestHotTags();
  }

  @override
  void closePage() {
    Get.back(id: doingNavigatorId);
  }

  /// 刷新数据
  Future refreshData() async {
    /// request - 我正在做的事情
    await requestMyDoing();
  }

  /// 点击选择你想发布的事情
  Future clickSelectPublishDoing(DoingHotTagsEntity tag) async {
    if (Strings.isEmpty(tag.tagName)) return;
    final result = await requestPostStatusDoing(tagName: tag.tagName ?? '');
    if (result == null) return;
    if (canClosePage) {
      closePage();
    } else {
      await pushDoingListPage(tag);
    }
  }

  /// 点击发布正在做的事 - 输入框发布
  Future clickPublishDoing(String content) async {
    final result = await requestPostStatusDoing(tagName: content);
    if (result == null) return;
    final tag = DoingHotTagsEntity()
      ..tagName = result.tagName
      ..tagId = result.tagId;
    await pushDoingListPage(tag);
  }
}
