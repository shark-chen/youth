import '../../../../config/environment_config/app_config.dart';
import '../../net_result.dart';
import 'user.dart';

/// FileName logistics
///
/// @Author 谌文
/// @Date 2024/6/5 19:24
///
/// @Description 我的-物流
extension Logistics on User {
  /// 请求首页面列表数据
  Future<NetResult<T>> requestLogisticsList<T>() async {
    return await post<T>(AppConfig.getLogisticsUrl);
  }
}
