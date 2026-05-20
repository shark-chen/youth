import 'package:kellychat/base/base_vm.dart';
import '../../model/knock_record_entity.dart';

/// FileName: beat_record_vm
///
/// @Author 谌文
/// @Date 2026/3/17 23:46
///
/// @Description 敲一下记录-vm
class BeatRecordVM extends BaseVM {
  /// 敲一下记录列表
  List<KnockRecordItems> rows = <KnockRecordItems>[];

  @override
  void onInit() {
    super.onInit();
  }

  /// 添加数据
  void configKnockRecordItems(KnockRecordEntity? value) {
    rows.clear();
    rows.addAll(value?.items ?? []);
  }
}
