import 'package:kellychat/network/net/entry/doing/doing.dart';

import '../../model/knock_record_entity.dart';
import '../beat_record_controller.dart';
import 'package:kellychat/base/base_controller.dart';

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

  /// request - 敲一下收件箱
  /// 敲一下 inbox · GET /api/knock/inbox
  Future<void> requestKnockInbox() async {
    EasyLoading.show();
    final response = await Net.value<Doing>().cache<KnockRecordEntity>((value) {
      if (value == null) return;
      vm.value.knockRecordEntity = value;
      vm.refresh();
    }).requestKnockInbox<KnockRecordEntity>();
    EasyLoading.dismiss();
    if (response.succeed) {
      vm.value.knockRecordEntity = response.value;
      vm.refresh();
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }
}
