import 'package:youth/base/base_controller.dart';
import 'package:youth/network/net/entry/doing/doing.dart';

import '../model/doing_hot_tags_entity.dart';
import '../model/publish_doing_entity.dart';
import 'model/doing_list_entity.dart';
import 'view_model/doing_list_vm.dart';
import 'controller/doing_list_request_controller.dart';
export 'controller/doing_list_request_controller.dart';
import 'controller/doing_list_route_controller.dart';
export 'controller/doing_list_route_controller.dart';

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
    requestMyDoing();
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

  /// 点击删除我正在做的事
  Future clickDeleteStatusDoing() async {
    await requestDeleteStatusDoing(vm.value.myDoing?.statusId ?? 0);
    vm.refresh();
  }

  /// 点击敲一下
  Future clickKnock(DoingListList? item) async {
    if (item?.userId == null) return;
    await requestKnockSend(
      toUserId: item?.userId ?? 0,
      tagId: vm.value.myDoing?.tagId,
    );
    vm.refresh();
  }

  /// 点击加入一起
  Future clickJoinTogether(DoingListList? item) async {
    if (item?.togetherId == null) return;
    await requestTogetherJoin(item?.togetherId ?? '0');
    vm.refresh();
  }

  /// 点击查看个人信息
  Future clickLookUserInfo(DoingListList? item) async {
    if (item?.userId == null) return;
    await pushProfile(userId: '${item?.userId}');
  }

  /// mark - method
  ///
  /// 获取列表数据源
  /// 获取列表数据
  List<DoingListList>? get rows {
    return vm.value.rows;
  }
}
