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
  /// 登录
  Future<NetResult<T>> requestAuthLogin<T>({
    required String phone,
    required String code,
  }) async {
    var params = {
      'phone': phone,
      'code': code,
    };
    return await post<T>(
      AppConfig.getAuthLoginUrl,
      data: params,
    );
  }

  /// 发送验证码
  Future<NetResult<T>> requestSmsSend<T>({
    required String phone,
  }) async {
    var params = {'phone': phone};
    return await post<T>(
      AppConfig.getSmsSendUrl,
      data: params,
    );
  }
}
