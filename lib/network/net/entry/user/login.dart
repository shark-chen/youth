import '../../../../config/environment_config/app_config.dart';
import '../../net_result.dart';
import 'user.dart';

/// FileName login
///
/// @Author 谌文
/// @Date 2024/10/28 15:58
///
/// @Description 登录相关
extension Login on User {
  /// 注册发送手机号验证码
  Future<NetResult<T>> requestPhoneCode<T>({
    String? phone,
    String? phoneAreaCode,
    String? picVerificationCode,
    String? accessCode,
  }) async {
    var params = {
      'phoneAccountNum': phone,
      'phoneAccountCode': phoneAreaCode?.replaceAll('+', ''),
      'picVerificationCode': picVerificationCode,
      'accessCode': accessCode,
    };
    return await get<T>(AppConfig.getSendRegPhoneCodeUrl, params: params);
  }

  /// 注册
  Future<NetResult<T>> requestRegister<T>(
    Map<String, dynamic> params,
  ) async {
    return await post<T>(AppConfig.getRegisterUrl, params: params);
  }

  ///登录
  Future<NetResult<T>> login<T>({Map<String, dynamic>? param}) async {
    return await post<T>(AppConfig.loginApiUrl, params: param);
  }

  /// 切换账号token,后端校验Token，并刷新获取最新Token
  Future<NetResult<T>> requestSwitchUserCheckLogin<T>({
    int? uid,
    String? mucToken,
  }) async {
    var params = {
      'mucToken': mucToken,
      'uid': uid,
    };
    return await post<T>(AppConfig.switchUserCheckLoginUrl, data: params);
  }
}
