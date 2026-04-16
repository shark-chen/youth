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

  /// POST /api/knock/send / 向某个用户发送敲一下
  Future<NetResult<T>> requestKnockSend<T>({required int toUserId}) async {
    var params = {'toUserId': toUserId};
    return await post<T>(AppConfig.getKnockSendUrl, data: params);
  }

  /// POST /api/together/create / 发起一起做活动
  Future<NetResult<T>> requestTogetherCreate<T>(
      {required String tagName}) async {
    return await post<T>(
      AppConfig.getTogetherCreateUrl,
      data: {'tagName': tagName},
    );
  }

  /// GET /api/match/suggestions
  Future<NetResult<T>> requestMatchSuggestions<T>() async {
    return await get<T>(AppConfig.getMatchSuggestionsUrl);
  }

  /// POST /api/match/search
  Future<NetResult<T>> requestMatchSearch<T>({
    String description = '',
    int page = 0,
    int size = 0,
  }) async {
    return await post<T>(
      AppConfig.getMatchSearchUrl,
      data: <String, dynamic>{
        'description': description,
        'page': page,
        'size': size,
      },
    );
  }
}
