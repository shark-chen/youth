import 'package:youth/base/base_controller.dart';

import 'controller/beat_record_request_controller.dart';
export 'controller/beat_record_request_controller.dart';
import 'model/beat_item_entity.dart';
import 'view_model/beat_record_vm.dart';

/// FileName: beat_record_controller
///
/// @Author 谌文
/// @Date 2026/3/17 23:23
///
/// @Description 敲一下记录- controller
class BeatRecordController extends BaseController {
  /// vm
  Rx<BeatRecordVM> vm = BeatRecordVM().obs;

  @override
  void onInit() async {
    super.onInit();
    title = '敲一下';
    requestKnockReceived();
  }

  /// push - 跳转到用户信息页面-page
  Future pushUserInfoPage() async {
    await Get.toNamed(Routes.userInfoPage);
  }

  List<BeatItemEntity> get rows => vm.value.rows;
}
