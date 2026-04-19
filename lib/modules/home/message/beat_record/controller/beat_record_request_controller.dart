import 'package:youth/network/net/entry/doing/doing.dart';

import '../beat_record_controller.dart';
import 'package:youth/base/base_controller.dart';

import '../model/beat_item_entity.dart';

/// FileName: beat_record_request_controller
///
/// @Author 谌文
/// @Date 2026/4/19 20:46
///
/// @Description
extension BeatRecordRequestController on BeatRecordController {
  /// 收到的敲一下列表 · GET /api/knock/received
  Future<void> requestKnockReceived() async {
    EasyLoading.show();
    final response = await Net.value<Doing>().caches<BeatItemEntity>((values) {
      vm.value.configBeatItemList(values);
      vm.refresh();
    }).requestKnockReceived<BeatItemEntity>();
    EasyLoading.dismiss();
    if (response.succeed) {
      vm.value.configBeatItemList(response.values);
      vm.refresh();
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }
}
