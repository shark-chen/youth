import 'dart:typed_data';

import '../../../../utils/utils/aes_cbc_util.dart';

/// FileName login_model
///
/// @Author 谌文
/// @Date 2024/7/9 16:01
///
/// @Description 登录模型
class LoginModel {
  /// 邮箱
  String account = '';

  /// 邮箱错误
  String? accountError;

  /// 密码
  String password = '';

  /// 加密后的密码
  String encryptPassword = '';

  /// 密码错误
  String? passwordError;

  /// 输入的验证码
  String verifyCode = '';

  /// 密码错误
  String? verifyCodeError;

  /// 验证码
  String accessCode = '';

  /// 验证码图片
  Uint8List? verifyImage;

  /// 是否选择同意隐私协议
  bool? agreeProtocol = false;

  /// 密码显示是否加密状态
  bool? obscureText = true;

  /// 是否选择同意记住账户信息
  bool? agreeSaveAccount = false;

  Map<String, String> toJson() {
    var result = {
      "account": account,
      'password': AesCbcUtil.encrypt(password),
      "accessCode": accessCode,
      'picVerificationCode': verifyCode,
    };
    return result;
  }
}
