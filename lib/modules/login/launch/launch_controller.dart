import '../../../base/base_controller.dart';
import '../../user/global.dart';
import '../../../network/net/entry/user/user.dart';

/// FileName launch_controller
///
/// @Author 谌文
/// @Date 2023/9/20 09:35
///
/// @Description 启动页控制器
class LaunchController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    var token = await Global.getAccessToken;
    if (Strings.isNotEmpty(token)) {
      var tokenTime = await Global.getTokenTime;
      var now = DateTime.now().millisecondsSinceEpoch;
      var sixDaysMs = 6 * 24 * 60 * 60 * 1000;
      if (tokenTime != null && (now - tokenTime > sixDaysMs)) {
        var response = await Net.value<User>().requestAuthRefresh<String>();
        if (response.success && Strings.isNotEmpty(response.value)) {
          await Global.setAccessToken(response.value ?? '');
        } else {
          await Global.clearAccessToken();
          Global.actualLogin.value = false;
          await Get.offAllNamed(Routes.login);
          return;
        }
      }
      await UserCenter().init();
      await Get.offAllNamed(Routes.homePage);
    } else {
      Global.actualLogin.value = false;
      await Get.offAllNamed(Routes.login);
    }
  }
}
