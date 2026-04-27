import 'package:kellychat/base/base_vm.dart';

import '../model/beat_item_entity.dart';

/// FileName: beat_record_vm
///
/// @Author 谌文
/// @Date 2026/3/17 23:46
///
/// @Description 敲一下记录-vm
class BeatRecordVM extends BaseVM {
  /// 敲一下记录列表
  List<BeatItemEntity> rows = <BeatItemEntity>[];

  @override
  void onInit() {
    super.onInit();
  }

  /// 添加数据
  void configBeatItemList(List<BeatItemEntity>? values) {
    rows.addAll(values ?? []);
  }
}
