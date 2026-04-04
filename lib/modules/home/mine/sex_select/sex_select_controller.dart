import 'package:youth/base/base_controller.dart';

import 'view_model/sex_select_vm.dart';

/// FileName: sex_select_controller
///
/// @Author 谌文
/// @Date 2026/3/25 23:51
///
/// @Description 性别选择-controller
class SexSelectController extends BaseController {
  /// vm
  Rx<SexSelectVM> vm = SexSelectVM().obs;

  @override
  void onInit() async {
    super.onInit();
  }

  /// 选择性别
  void selectSex(Sex sex) {
    vm.value.sex = sex;
    vm.refresh();
  }

  /// push-生日选择-页面-page
  Future pushBirthdaySelectPage() async {
    await Get.toNamed(Routes.birthdaySelectPage);
  }
}
