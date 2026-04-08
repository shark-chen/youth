import 'package:youth/base/base_controller.dart';
import 'package:youth/network/net/entry/user/user.dart';
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

  /// mark - request
  /// request - 更新当前登录用户的信息
  /// gender: 性别：0-未知，1-男，2-女
  Future<bool?> requestUpdateUserInfo({
    int? gender,
  }) async {
    var response = await Net.value<User>().requestUpdateUserInfo(
      gender: gender,
    );
    if (response.success) {
      return true;
    } else {
      EasyLoading.showToast(response.msg ?? '');
      return false;
    }
  }

  /// mark - method
  ///
  /// 选择性别
  void selectSex(Sex sex) async {
    vm.value.sex = sex;
    vm.refresh();

    /// request - 更新当前登录用户的信息
    await requestUpdateUserInfo(gender: Sex.boy == vm.value.sex ? 1 : 2);
  }

  /// mark - push
  ///
  /// push-生日选择-页面-page
  Future pushBirthdaySelectPage() async {
    if (vm.value.sex == null) {
      EasyLoading.showToast('请选择性别');
      return;
    }
    await Get.toNamed(Routes.birthdaySelectPage, arguments: vm.value.sex);
  }
}
