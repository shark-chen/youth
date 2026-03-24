/// FileName network_status_model
///
/// @Author 谌文
/// @Date 2023/9/15 11:26
///
/// @Description 网络类型
/// 网络类型
class NetworkStatusModel {
  /// 网络类型
  String networkType;

  /// 网络类型的中文解释
  String info;

  /// 网络状态
  String? networkStatus;

  NetworkStatusModel({
    required this.networkType,
    required this.info,
    this.networkStatus,
  });

  @override
  String toString() {
    return networkType + ':  ' + info + '\nping:  \n' + (networkStatus ?? '') + '\n';
  }
}
