import 'package:youth/base/base_controller.dart';
import 'model/gender.dart';
import 'model/user_info_param.dart';
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

  /// mark - method
  ///
  /// 选择性别
  void selectSex(Gender sex) async {
    vm.value.sex = sex;
    vm.refresh();
  }

  /// 更新用户信息
  Future updateUserInfo() async {
    if (vm.value.sex == null) {
      EasyLoading.showToast('请选择性别');
      return;
    }

    /// push-生日选择-页面-page
    await pushBirthdaySelectPage();
  }

  /// mark - push
  ///
  /// push-生日选择-页面-page
  Future pushBirthdaySelectPage() async {
    UserInfoParam param = UserInfoParam();
    param.gender = Gender.boy == vm.value.sex ? 1 : 2;
    await Get.toNamed(Routes.birthdaySelectPage, arguments: param);
  }
}
