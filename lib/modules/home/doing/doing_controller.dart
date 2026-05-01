import 'dart:async';
import 'package:kellychat/base/base_controller.dart';
import 'package:kellychat/modules/home/home/view/tabs.dart';
import '../../user/user_center/my_doing/my_doing.dart';
import 'model/doing_hot_tags_entity.dart';
import 'view_model/doing_vm.dart';
import 'controller/doing_request_controller.dart';
export 'controller/doing_request_controller.dart';
import 'doing_nav_ids.dart';

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

    EventBusManager().listen<HomeTabs>(this, (event) async {
      if(HomeTabs.doing == event) {
        final doing = await MyDoing().doing;
        if (doing != null) {
          await pushDoingListPage(
            DoingHotTagsEntity()
              ..tagId = doing.tagId
              ..tagName = doing.tagName,
          );
        }
      }
    });

    /// 获取个人信息 · GET /api/user/profile
    requestUserProfile();

    /// 获取当前热门的正在做标签列表
    await requestHotTags();
  }


  /// 刷新数据
  Future refreshData() async {
    /// request - 敲一下收件箱
    await requestMyDoing();
  }

  /// 点击选择你想发布的事情
  Future clickSelectPublishDoing(DoingHotTagsEntity tag) async {
    if (Strings.isEmpty(tag.tagName)) return;
    await requestPostStatusDoing(tagName: tag.tagName ?? '');
    await pushDoingListPage(tag);
  }

  /// 点击发布正在做的事
  Future clickPublishDoing(String content) async {
    final result = await requestPostStatusDoing(tagName: content);
    final tag = DoingHotTagsEntity()
      ..tagName = result?.tagName
      ..tagId = result?.tagId;
    await pushDoingListPage(tag);
  }

  /// mark - push
  ///
  /// push-正在做的清单-页面
  Future pushDoingListPage(DoingHotTagsEntity tag) async {
    await Get.toNamed(
      Routes.doingListPage,
      arguments: tag,
      id: doingNavigatorId,
    );
  }

  /// 个人信息页面
  Future pushUserInfoPage() async {
    await Get.toNamed(Routes.minePage);
  }
}
