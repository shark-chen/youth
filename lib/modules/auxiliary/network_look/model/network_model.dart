/// FileName network_model
///
/// @Author 谌文
/// @Date 2023/10/8 19:44
///
/// @Description 网络数据模型
class NetworkModel {
  /// 标题
  String? title;

  /// 网络成功或者失败
  bool? succeed;

  /// 请求参数
  String? requestParameters;

  /// 响应数据
  String? responseParameters;

  /// 时间
  String? time;

  /// 其他信息
  String? other;

  /// 展开还是收起， 默认收起
  bool? unfold;

  NetworkModel({
    this.title,
    this.time,
    this.succeed = true,
    this.requestParameters,
    this.responseParameters,
    this.unfold = false,
    this.other,
  });
}
