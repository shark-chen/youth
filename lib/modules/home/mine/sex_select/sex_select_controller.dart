import 'package:youth/base/base_controller.dart';

/// FileName: sex_select_controller
///
/// @Author 谌文
/// @Date 2026/3/25 23:51
///
/// @Description 性别选择-controller
class SexSelectController extends BaseController {
  @override
  void onInit() async {
    super.onInit();
  }

  /// push-生日选择-页面-page
  Future pushBirthdaySelectPage() async {
    await Get.toNamed(Routes.birthdaySelectPage);
  }
}
