/// FileName config_model
///
/// @Author 谌文
/// @Date 2023/10/18 16:39
///
/// @Description 环境模型
class ConfigModel {
  ConfigModel({
    this.clientHost,
    this.serverHost,
    this.blogHost,
  });

  /// 客户端地址（H5地址）
  String? clientHost;

  /// 服务端地址
  String? serverHost;

  /// 博客地址
  String? blogHost;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['clientHost'] = clientHost;
    map['serverHost'] = serverHost;
    map['blogHost'] = blogHost;
    return map;
  }
}
