import 'package:youth/base/base_controller.dart';
import 'package:youth/network/net/entry/doing/doing.dart';

import 'model/doing_hot_tags_entity.dart';
import 'view_model/doing_vm.dart';

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

    /// 获取当前热门的正在做标签列表
    await requestHotTags();
  }

  /// mark - request
  ///
  /// 获取当前热门的正在做标签列表
  Future requestHotTags() async {
    EasyLoading.show();
    var response =
        await Net.value<Doing>().requestHotTags<DoingHotTagsEntity>(limit: 20);
    EasyLoading.dismiss();
    if (response.succeed) {
      vm.value.configHotTags(response.values);
      vm.refresh();
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }

  /// mark - push
  ///
  /// push-正在做的清单-页面
  Future pushDoingListPage(DoingHotTagsEntity tag) async {
    await Get.toNamed(Routes.doingListPage, arguments: tag);
  }
}
