import 'package:youth/network/net/net_config/net_config.dart';
import 'package:youth/tripartite_library/uuid/udid_util.dart';
import '../../../base/base_controller.dart';
import '../../../network/net/entry/user/user.dart';
import 'model/component_utils.dart';
import '../../functions/daily_active/daily_active.dart';
import '../../user/global.dart';
import 'model/reLogin_account_entity.dart';
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
  LoginController({ReLoginAccountEntity? reLogin}) {}

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

  /// MARK - method
  /// 选中隐私协议
  void checkReadProtocol(bool? value) async {
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
}
