import 'dart:async';
import 'package:youth/modules/home/hall/view_model/hall_currency_vm.dart';
import 'package:youth/modules/user/user_center/authority/authority.dart';
import 'package:youth/utils/utils/language/lang_value.dart';
import 'package:easy_refresh/easy_refresh.dart';
import '../../../base/base_controller.dart';
import '../../../network/net/entry/user/user.dart';
import '../../functions/upgrade/upgrade_tool.dart';
import '../../user/global.dart';
import '../../user/msg_push_manager.dart';
import '../home/view/tabs.dart';
import 'model/hall_entity.dart';
import 'model/hall_mark_model.dart';
import 'model/msg_entity.dart';
import 'model/replete_num_entity.dart';
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
    if (state == AppLifecycleState.inactive) {

    }
  }


  /// 下拉刷新
  @override
  Future onRefresh() async {

  }

  /// MARK - method
  ///
  /// 获取列表数量
  int itemCount() => vm.value.itemCount();

  /// 获取元素数据
  HallEntity getItem(int index) => vm.value.getItem(index);

}
