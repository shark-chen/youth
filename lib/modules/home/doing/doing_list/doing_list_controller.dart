import 'package:youth/base/base_controller.dart';
import 'package:youth/network/net/entry/doing/doing.dart';

import '../model/doing_hot_tags_entity.dart';
import 'view_model/doing_list_vm.dart';

/// FileName: doing_list_controller
///
/// @Author 谌文
/// @Date 2026/3/9 23:18
///
/// @Description 正在做的清单-controller
class DoingListController extends BaseController {
  /// vm
  Rx<DoingListVM> vm = DoingListVM().obs;

  @override
  void onInit() async {
    super.onInit();
    title = '我正在';
    final arg = Get.arguments;
    if (arg is DoingHotTagsEntity) {
      final name = arg.tagName;
      if (name != null && name.isNotEmpty) {
        vm.value.activityTitle = name;
      }
      final count = arg.userCount;
      if (count != null) {
        vm.value.samePeopleCount = count;
      }
      vm.refresh();
      final id = arg.tagId;
      if (id != null) {
        await requestStatusDoingByTagId(id);
      }
    }
  }

  /// mark - request
  ///
  /// GET /api/status/doing/{tagId}
  Future<void> requestStatusDoingByTagId(int tagId) async {
    EasyLoading.show();
    final response =
        await Net.value<Doing>().requestStatusDoing<dynamic>(tagId: tagId);
    EasyLoading.dismiss();
    if (response.succeed) {
      /// TODO: 定义 data 模型后解析 `response.value` / `response.values` 更新列表
      vm.refresh();
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }
}
