import 'dart:async';
import 'package:youth/modules/user/global.dart';
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

  @override
  Future<void> onInit() async {
    super.onInit();
    vm.value.refresh = vm.refresh;
  }

  /// mark - method
  ///
  /// 点击登录
  Future clickLogin() async {
    hideKeyboard();
    vm.refresh();

    /// 校验手机号验证码
    bool isCheck = vm.value.checkLogin;
    if (isCheck != true) return;

    /// 是否同意隐私协议
    if (vm.value.loginModel.agreeProtocol == false) {
      /// push-打开意思协议弹框
      if (await pushPrivacyPop() == false) return;
    }

    /// 请求登录
    UserInfoEntity? user = await requestLogin(
      phone: vm.value.phoneController.text,
      code: vm.value.verifyCodeController.text,
    );
    if (user == null) return;
    if (Strings.isEmpty(user.token)) {
      EasyLoading.showToast('登录失败');
      return;
    }

    /// 设置保存token
    Global.setAccessToken(user.token ?? '');
    if (true == user.isNewUser) {
      /// push-个人信息补充模块页面
      await pushSexSelectPage();
    } else {
      await Get.offAllNamed(Routes.homePage);
    }
  }

  /// 点击发送验证码
  Future clickSendSmsCode() async {
    /// 还在倒计时中
    if (!vm.value.sendSmsEnable) return;

    /// 是否是手机号
    if (!vm.value.checkPhone) return;
    final send = await requestSmsSend(phone: vm.value.phoneController.text);
    if (send == true) {
      /// 发送成功，开始倒计时
      vm.value.startSmsCountDown();
    }
  }

  /// 选中隐私协议
  void checkReadProtocol(bool? value) async {
    if (value != null) {
      vm.value.loginModel.agreeProtocol = value;
      vm.refresh();
    }
  }

  /// mark - request
  ///
  /// request - 请求登录
  Future<UserInfoEntity?> requestLogin({
    required String phone,
    required String code,
  }) async {
    var response = await Net.value<User>().requestAuthLogin<UserInfoEntity>(
      phone: phone,
      code: code,
    );
    if (response.succeed) {
      return response.value;
    } else {
      EasyLoading.showToast(response.msg ?? '');
      return null;
    }
  }

  /// request - 请求登录
  Future<bool?> requestSmsSend({
    required String phone,
  }) async {
    var response = await Net.value<User>().requestSmsSend(
      phone: phone,
    );
    if (response.success) {
      return true;
    } else {
      EasyLoading.showToast(response.msg ?? '');
      return false;
    }
  }
}
