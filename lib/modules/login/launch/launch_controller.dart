import '../../../base/base_controller.dart';
import '../../user/global.dart';

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
      await UserCenter().init();
      await Get.offAllNamed(Routes.homePage);
    } else {
      /// 如果网络和服务器正常，请求服务器检测更新
      // if (await NetWork.checkNetWork()) {
      /// 检查是否需要更新
      // bool doLogin = await UserService().doLogin();
      // if(doLogin != true) {
      Global.actualLogin.value = false;
      await Get.offAllNamed(Routes.login);
      return;
      // }
      // }
      await Get.offAllNamed(Routes.homePage);
    }
  }
}
