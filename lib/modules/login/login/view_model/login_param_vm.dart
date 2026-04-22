import 'package:youth/base/base_controller.dart';
import 'login_vm.dart';

/// FileName: login_param_vm
///
/// @Author 谌文
/// @Date 2026/4/5 23:29
///
/// @Description 登录-参数校验等相关-vm
extension LoginParamVM on LoginVM {
  /// 校验手机号验证码
  bool get checkLogin {
    /// 是否是手机号
    if (!checkPhone) return checkPhone;

    /// 验证码校验
    if (!checkSmsCode) return checkSmsCode;
    return true;
  }

  /// 是否是手机号
  bool get checkPhone {
    if (Strings.isEmpty(phoneController.text)) {
      EasyLoading.showToast('请输入手机号');
      return false;
    }
    final isValidPhone = phoneController.text.isValidPhone;
    if (isValidPhone != true) {
      EasyLoading.showToast('手机号格式不正确');
      return false;
    }
    return true;
  }

  /// 验证码校验
  bool get checkSmsCode {
    final codeIsEmpty = Strings.isEmpty(verifyCodeController.text);
    if (codeIsEmpty) {
      EasyLoading.showToast('验证码不能为空');
      return false;
    }
    return true;
  }

  /// 请求参数
  Future<Map<String, dynamic>> toJson() async {
    return {}..addAll(loginModel.toJson());
  }
}
