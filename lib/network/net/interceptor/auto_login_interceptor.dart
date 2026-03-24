import 'package:dio/dio.dart';
import '../../../modules/routes/app_pages.dart';
import '../../../modules/user/global.dart';
import '../net_config/ignore_path.dart';
import 'package:get/get.dart' as Get;

/// FileName auto_login_interceptor
///
/// @Author 谌文
/// @Date 2024/5/29 14:20
///
/// @Description 重新登录拦截器
bool loginIng = false;

class AutoLoginInterceptor extends Interceptor {
  /// The callback will be executed before the request is initiated.
  ///
  /// If you want to continue the request, call [handler.next].
  ///
  /// If you want to complete the request with some custom data，
  /// you can resolve a [Response] object with [handler.resolve].
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    /// 已经登录/手动登录 就不需要重新自动登录了
    if (Global.actualLogin.value) return handler.next(options);

    /// 一些登录注册接口不需要拦截
    if (ignoreUrl.contains(options.path)) return handler.next(options);

    /// 如果正在重新过程中，泽不处理其他请求了（还是要做请求的，比如首页请求数据，但直接return了，等自动登录成功了，这个首页请求不会自动触发了）
    if (loginIng) return handler.next(options);

    /// 用户进入APP没登录成功，需要重新自动登录
    loginIng = true;
    try {

    } catch (_) {
    } finally {
      loginIng = false;
    }
  }

  /// The callback will be executed on success.
  /// If you want to continue the response, call [handler.next].
  ///
  /// If you want to complete the response with some custom data directly,
  /// you can resolve a [Response] object with [handler.resolve] and other
  /// response interceptor(s) will not be executed.
  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    return handler.next(response);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 404) {
      // If response status code is 404, fetch data from cache
    }
    // For other errors, proceed with normal error handling
    return handler.next(err);
  }
}
