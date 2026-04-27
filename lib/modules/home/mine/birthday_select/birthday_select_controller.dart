import 'package:kellychat/base/base_controller.dart';
import '../sex_select/model/user_info_param.dart';
import 'view_model/birthday_select_vm.dart';

/// FileName: birthday_select_controller
///
/// @Author 谌文
/// @Date 2026/3/26 16:30
///
/// @Description 生日选择-controller（请求、路由）
class BirthdaySelectController extends BaseController {
  /// vm
  Rx<BirthdaySelectVM> vm = BirthdaySelectVM().obs;

  /// 构造函数
  BirthdaySelectController({UserInfoParam? userInfoParam}) {
    vm.value.userInfoParam = userInfoParam;
    if (userInfoParam == null) {
      vm.value.userInfoParam = UserInfoParam();
    }
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

  /// mark - push
  ///
  /// push-城市选择-页面-page
  Future pushCitySetPage() async {
    vm.value.userInfoParam?.birthday = vm.value.selectedBirthday;
    await Get.toNamed(
      Routes.citySetPage,
      arguments: vm.value.userInfoParam,
    );
  }
}
