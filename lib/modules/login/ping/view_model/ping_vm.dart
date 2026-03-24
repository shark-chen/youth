import 'package:youth/base/base_vm.dart';

/// FileName: ping_vm
///
/// @Author 谌文
/// @Date 2026/1/22 11:10
///
/// @Description ping- vm

class PingVM extends BaseVM {
  /// 数据源
  List<String> rows = <String>[];

  @override
  void onInit() {
    super.onInit();
  }

  /// 添加数据
  void addRow(String value) {
    clearRows();
    rows.add(value);
  }

  /// 清空数据
  void clearRows() {
    rows.clear();
  }
}
