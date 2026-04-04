import 'package:youth/network/net/entry/user/user.dart';
import '../../../network/network_monitor/network_monitor.dart';
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

    /// request- 后端健康
    requestActuatorHealth();

    /// 开启网络监听
    NetworkMonitor().startMonitor();
    var token = await Global.getAccessToken;
    if (Strings.isEmpty(token) && false) {
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

  /// request- 后端健康
  Future requestActuatorHealth() async {
    var response = await Net.value<User>().requestActuatorHealth();
    if (response.success) {
      return response.data?.data ?? 0;
    }

    // EasyLoading.show();
    // var response = await NetWork.getVerifyImage();
    // EasyLoading.dismiss();
    // if (response.code == 0 && response.data != null) {
    //   vm.value.configVerifyCodeData(response.data);
    //   vm.refresh();
    // } else {
    //   EasyLoading.showToast(response.msg ?? '');
    // }
  }
}
