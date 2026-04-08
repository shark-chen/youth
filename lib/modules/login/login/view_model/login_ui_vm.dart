import 'login_vm.dart';

/// FileName: login_ui_vm
///
/// @Author 谌文
/// @Date 2026/4/6 00:07
///
/// @Description 登录-ui-vm
extension LoginUIVM on LoginVM {
  /// 发送验证码内容
  String get sendSmsTitle {
    if (sendSmsEnable) {
      if (seconds == -1) {
        return '发送验证码';
      }
      return '重新发送';
    }
    return '重新发送 ${seconds}s';
  }

  /// 发送验证码按钮是否可点击
  bool get sendSmsEnable {
    return seconds <= 0;
  }
}
