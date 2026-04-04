import 'package:youth/base/base_vm.dart';

/// FileName: sex_select_vm
///
/// @Author 谌文
/// @Date 2026/3/28 23:00
///
/// @Description 性别选择-vm
enum Sex {
  /// 男孩
  boy,

  /// 女孩
  girl,
}

class SexSelectVM extends BaseVM {
  /// 性别
  Sex? sex;

  @override
  void onInit() {
    super.onInit();
  }
}
