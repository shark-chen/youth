import 'package:youth/base/base_vm.dart';

/// FileName: doing_list_vm
///
/// @Author 谌文
/// @Date 2026/3/9 23:29
///
/// @Description 正在做的清单-vm
class DoingListVM extends BaseVM {
  /// 当前正在做的事（展示在渐变头、统计文案里）
  String activityTitle = '看电影';

  /// 「有 N 人也在」
  int samePeopleCount = 318;

  @override
  void onInit() {
    super.onInit();
  }
}
