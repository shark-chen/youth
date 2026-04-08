import 'package:youth/base/base_controller.dart';
import 'package:youth/network/net/entry/user/user.dart';
import 'view_model/birthday_select_vm.dart';

/// FileName: birthday_select_controller
///
/// @Author 谌文
/// @Date 2026/3/26 16:30
///
/// @Description 生日选择-controller（请求、路由）
class BirthdaySelectController extends BaseController {
  /// vm
  late final Rx<BirthdaySelectVM> vm;

  BirthdaySelectController({
    int? minYear,
    int? maxYear,
    DateTime? initialDate,
  }) {
    vm = BirthdaySelectVM(
      minYear: minYear,
      maxYear: maxYear,
      initialDate: initialDate,
    ).obs;
  }

  @override
  void onInit() async {
    super.onInit();
    title = '选择生日';
    vm.value.refresh = vm.refresh;
    vm.value.initPickers();
    vm.refresh();
  }

  @override
  void onClose() {
    vm.value.disposeScrollControllers();
    super.onClose();
  }

  /// mark - method
  ///
  /// 选择年
  void onYearChanged(int index) {
    vm.value.onYearChanged(index);
    vm.refresh();
  }

  /// 选择月
  void onMonthChanged(int index) {
    vm.value.onMonthChanged(index);
    vm.refresh();
  }

  /// 选择日
  void onDayChanged(int index) {
    vm.value.onDayChanged(index);
    vm.refresh();
  }

  /// mark - request
  /// request - 更新当前登录用户的信息
  /// birthday: 生日: 1995-06-15
  Future<bool?> requestUpdateUserInfo({
    String? birthday,
  }) async {
    var response = await Net.value<User>().requestUpdateUserInfo(
      birthday: birthday,
    );
    if (response.success) {
      return true;
    } else {
      EasyLoading.showToast(response.msg ?? '');
      return false;
    }
  }

  /// mark - push
  ///
  /// push-城市选择-页面-page
  Future pushCitySetPage() async {
    final ok = await requestUpdateUserInfo(
      birthday: vm.value.selectedDateText,
    );
    if (ok == true) {
      await Get.toNamed(Routes.citySetPage);
    }
  }
}
