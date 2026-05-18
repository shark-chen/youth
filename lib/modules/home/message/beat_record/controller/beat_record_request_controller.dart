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
  /// request - 收到的敲一下列表 · GET /api/knock/received
  Future<void> requestKnockReceived({
    bool? showLoad = true,
  }) async {
    if (true == showLoad) EasyLoading.show();
    final response = await Net.value<Doing>().caches<BeatItemEntity>((values) {
      vm.value.configBeatItemList(values);
      vm.refresh();
    }).requestKnockReceived<BeatItemEntity>();
    if (true == showLoad) EasyLoading.dismiss();
    if (response.succeed) {
      vm.value.configBeatItemList(response.values);
      vm.refresh();
    } else {
      if (true == showLoad) EasyLoading.showToast(response.msg ?? '');
    }
  }

  /// request - 敲一下收件箱 获取24小时内双向敲一下记录（我敲的+敲我的），
  /// 每对用户只显示最近一次，同时返回未读数
  Future<void> requestKnockInbox({
    bool? showLoad = true,
  }) async {
    if (true == showLoad) EasyLoading.show();
    final response = await Net.value<Doing>().cache<KnockRecordEntity>((value) {
      if (value == null) return;
      vm.value.knockRecordEntity = value;
      vm.refresh();
    }).requestKnockInbox<KnockRecordEntity>();
    if (true == showLoad) EasyLoading.dismiss();
    if (response.succeed) {
      vm.value.knockRecordEntity = response.value;
      vm.refresh();
    } else {
      if (true == showLoad) EasyLoading.showToast(response.msg ?? '');
    }
  }
}
