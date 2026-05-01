import 'package:kellychat/config/environment_config/app_config.dart';
import 'package:kellychat/network/net/net_mixin.dart';
import 'package:kellychat/network/net/net_result.dart';

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
  /// 获取正在做某个标签的用户列表
  Future<NetResult<T>> requestStatusDoing<T>({required int tagId}) async {
    return await get<T>(AppConfig.getStatusDoingUrl(tagId));
  }

  /// DELETE /api/status/doing/{statusId}
  /// 删除某条「正在做」状态（path 与 GET 相同，方法不同）
  Future<NetResult<T>> requestDeleteStatusDoing<T>(
      {required int statusId}) async {
    return await delete<T>(AppConfig.getStatusDoingUrl(statusId));
  }

  /// GET /api/status/my-doing
  Future<NetResult<T>> requestMyDoing<T>() async {
    return await get<T>(AppConfig.getStatusMyDoingUrl);
  }

  /// 发布一个正在做的状态
  /// POST /api/status/doing  body: `{ "tagName": "" }`
  Future<NetResult<T>> requestPostStatusDoing<T>({String tagName = ''}) async {
    return await post<T>(
      AppConfig.postStatusDoingUrl,
      data: <String, dynamic>{'tagName': tagName},
    );
  }

  /// POST /api/knock/send / 向某个用户发送敲一下
  Future<NetResult<T>> requestKnockSend<T>({
    required int toUserId,
    int? tagId,
  }) async {
    var params = {
      'toUserId': toUserId,
      'tagId': tagId,
    };
    return await post<T>(AppConfig.getKnockSendUrl, data: params);
  }

  /// GET /api/knock/received
  Future<NetResult<T>> requestKnockReceived<T>() async {
    return await get<T>(AppConfig.getKnockReceivedUrl);
  }

  /// 敲一下收件箱
  /// GET /api/knock/inbox
  Future<NetResult<T>> requestKnockInbox<T>() async {
    return await get<T>(AppConfig.getKnockInboxUrl);
  }

  /// POST /api/invitation/send
  Future<NetResult<T>> requestInvitationSend<T>({
    required int toUserId,
    required int invitationType,
    required int tagId,
    String message = '',
  }) async {
    return await post<T>(
      AppConfig.postInvitationSendUrl,
      data: <String, dynamic>{
        'toUserId': toUserId,
        'invitationType': invitationType,
        'tagId': tagId,
        'message': message,
      },
    );
  }

  /// POST /api/invitation/generate-code
  /// body: inviteChannel, invitationType, tagId, message
  Future<NetResult<T>> requestInvitationGenerateCode<T>({
    int inviteChannel = 0,
    required int invitationType,
    required int tagId,
    String message = '',
  }) async {
    return await post<T>(
      AppConfig.postInvitationGenerateCodeUrl,
      data: <String, dynamic>{
        'inviteChannel': inviteChannel,
        'invitationType': invitationType,
        'tagId': tagId,
        'message': message,
      },
    );
  }

  /// POST /api/together/create / 发起一起做活动
  Future<NetResult<T>> requestTogetherCreate<T>(
      {required String tagName}) async {
    return await post<T>(
      AppConfig.getTogetherCreateUrl,
      data: {'tagName': tagName},
    );
  }

  /// POST /api/together/{togetherId}/join
  /// 加入一个等待中的一起做活动
  Future<NetResult<T>> requestTogetherJoin<T>(
      {required String togetherId}) async {
    return await post<T>(AppConfig.getTogetherJoinUrl(togetherId));
  }

  /// GET /api/together/my-list 我的邀约列表
  Future<NetResult<T>> requestTogetherMyList<T>() async {
    return await get<T>(AppConfig.getTogetherMyListUrl);
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
