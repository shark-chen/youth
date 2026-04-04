import '../../../../config/environment_config/app_config.dart';
import '../../net_result.dart';
import 'user.dart';

/// FileName config
///
/// @Author 谌文
/// @Date 2025/3/12 16:21
///
/// @Description 用户配置
extension Config on User {
  ///  获取 用户设置的 选择等配置 URL
  Future<NetResult<T>> requestUserChooseConfig<T>(String module) async {
    var params = {'page': module};
    return await get<T>(AppConfig.getUserChooseConfigUrl, params: params);
  }

  /// 更新 用户设置的 选择等配置
  /// params: 添加的
  Future<NetResult<T>> requestUpdateUserChooseConfig<T>(
    String module, {
    String value = '',
    String key = '',
  }) async {
    var params = {'page': module, 'key': key, 'chooseInfo': value};
    return await get<T>(AppConfig.getUpdateUserChooseConfigUrl, params: params);
  }

}
