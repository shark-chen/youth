import 'package:dio/dio.dart';
import 'package:youth/network/net/entry/user/user.dart';
import '../../../base/base_controller.dart';
import 'view_model/login_vm.dart';
import 'controller/login_route_controller.dart';
export 'controller/login_route_controller.dart';

/// FileName login_controller
///
/// @Author 谌文
/// @Date 2024/7/8 14:34
///
/// @Description 登录控制器-controller
class LoginController extends BaseController {
  LoginController();

  /// vm
  Rx<LoginVM> vm = LoginVM().obs;

  String uuid = '';

  @override
  Future<void> onInit() async {
    super.onInit();
    vm.value.refresh = vm.refresh;
  }

  /// MARK - request
  /// request - 请求登录
  Future requestLogin() async {
    hideKeyboard();
    vm.refresh();
    if (vm.value.loginModel.agreeProtocol == false) {
      /// push-打开意思协议弹框
      if (await pushPrivacyPop() == false) return;
    }

    /// push-个人信息补充模块页面
    await pushSexSelectPage();
  }

  /// request- 请求验证码
  Future requestVerifyCode() async {
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

  /// request- 后端健康
  Future requestActuatorHealth() async {
    var response = await Net.value<User>().requestActuatorHealth();
    if (response.success) {
      return response.data?.data ?? 0;
    }
  }

  /// MARK - method
  /// 选中隐私协议
  void checkReadProtocol(bool? value) async {
    getData();
    requestActuatorHealth();
    if (value != null) {
      vm.value.loginModel.agreeProtocol = value;
      vm.refresh();
    }
  }

  /// 选中保存账户信息
  void checkSaveAccountInfo(bool? value) async {
    if (value != null) {
      /// 是否选择同意记住账户信息
      vm.value.loginModel.agreeSaveAccount = value;
      UserInfoCenter().agreeSaveAccount = value;
      vm.refresh();
    }
  }

  Future<void> getData() async {
    try {
      final dio = Dio();

      final response = await dio.get(
        'http://localhost:8080/actuator/health',
      );

      print('状态码: ${response.statusCode}');
      print('返回数据: ${response.data}');
    } catch (e) {
      print('请求失败: $e');
    }
  }
}
