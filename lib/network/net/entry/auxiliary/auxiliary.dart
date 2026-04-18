import '../../../../config/environment_config/app_config.dart';
import '../../net_mixin.dart';
import '../../net_result.dart';
export '../../net.dart';

/// FileName auxiliary
///
/// @Author 谌文
/// @Date 2024/8/5 16:34
///
/// @Description 辅助相关接口
class Auxiliary extends NetMixin<Auxiliary> {
  Auxiliary();

  factory Auxiliary.init() => Auxiliary();

  /// 意见反馈提交 · POST /api/feedback/submit
  Future<NetResult<T>> requestFeedbackSubmit<T>({
    required String content,
    String? images,
    String? contact,
  }) async {
    return await post<T>(
      AppConfig.postFeedbackSubmitUrl,
      data: <String, dynamic>{
        'content': content,
        'images': images ?? '',
        'contact': contact ?? '',
      },
    );
  }

  /// 测试请求- post
  Future<NetResult<T>> requestPost<T>(
    String path, {
    data,
    Map<String, dynamic>? params,
  }) async {
    return await post<T>(path, data: data, params: params);
  }

  /// 测试请求 - get
  Future<NetResult<T>> requestGet<T>(
    String path, {
    Map<String, dynamic>? params,
  }) async {
    return await get<T>(path, params: params);
  }
}
