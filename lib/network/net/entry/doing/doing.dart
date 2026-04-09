import 'package:youth/config/environment_config/app_config.dart';
import 'package:youth/network/net/net_mixin.dart';
import 'package:youth/network/net/net_result.dart';

/// FileName: doing
///
/// @Author 谌文
/// @Date 2026/4/8 22:37
///
/// @Description 正在模块
class Doing extends NetMixin<Doing> {
  Doing();

  factory Doing.init() => Doing();

  /// 获取当前热门的正在做标签列表
  Future<NetResult<T>> requestHotTags<T>({
    int? limit = 20,
  }) async {
    var params = {'limit': limit};
    return await get<T>(AppConfig.getStatusHotTagsUrl, params: params);
  }

  /// GET /api/status/doing/{tagId}
  Future<NetResult<T>> requestStatusDoing<T>({required int tagId}) async {
    return await get<T>(AppConfig.getStatusDoingUrl(tagId));
  }
}
