import 'package:youth/base/base_controller.dart';

/// FileName: city_set_controller
///
/// @Author 谌文
/// @Date 2026/3/26 22:29
///
/// @Description 地区设置-controller
class CitySetController extends BaseController {
  @override
  void onInit() async {
    super.onInit();
  }

  /// push-首页页面-page
  Future pushHomePage() async {
    await Get.offAllNamed(Routes.homePage);
  }
}
