import 'package:youth/base/base_controller.dart';
import 'package:youth/network/net/entry/doing/doing.dart';

import '../model/doing_hot_tags_entity.dart';
import 'model/doing_list_entity.dart';
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

  /// mark - method
  ///
  /// 获取列表数据源
  /// 获取列表数据
  List<DoingListList>? get rows {
    return vm.value.rows;
  }

  /// mark - request
  ///
  /// GET /api/status/doing/{tagId}
  Future<void> requestStatusDoingByTagId(int tagId) async {
    EasyLoading.show();
    final response = await Net.value<Doing>()
        .requestStatusDoing<DoingListEntity>(tagId: tagId);
    EasyLoading.dismiss();
    if (response.succeed) {
      /// 配置正在做的事情数据
      vm.value.configDoingListEntity(response.value);
      vm.refresh();
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }

  /// 向某个用户发送敲一下
  Future<void> requestKnockSend(int toUserId) async {
    EasyLoading.show();
    final response =
        await Net.value<Doing>().requestKnockSend<dynamic>(toUserId: toUserId);
    EasyLoading.dismiss();
    if (response.succeed) {
      EasyLoading.showToast('已发送');
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }

  /// 发起一起做活动
  Future<void> requestTogetherCreate({String? tagName}) async {
    final name = (tagName ?? vm.value.activityTitle).trim();
    if (name.isEmpty) {
      EasyLoading.showToast('暂无活动标签');
      return;
    }
    EasyLoading.show();
    final response =
        await Net.value<Doing>().requestTogetherCreate<dynamic>(tagName: name);
    EasyLoading.dismiss();
    if (response.succeed) {
      EasyLoading.showToast('已发起');
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }
}
