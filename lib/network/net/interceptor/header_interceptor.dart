import 'package:kellychat/utils/marco/debug_print.dart';
import 'package:dio/dio.dart';

/// FileName: header_interceptor
///
/// @Author 谌文
/// @Date 2026/1/26 21:06
///
/// @Description 请求头拦截
class HeaderInterceptor extends Interceptor {
  /// The callback will be executed before the request is initiated.
  ///
  /// If you want to continue the request, call [handler.next].
  ///
  /// If you want to complete the request with some custom data，
  /// you can resolve a [Response] object with [handler.resolve].
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      if (netHeaderEnableLog) {
        DebugPrint('请求： URL: ${options.method} ${options.path}');
        DebugPrint('Headers:');
        options.headers.forEach((key, value) {
          DebugPrint('  $key: $value');
        });
      }
    } catch (_) {
    } finally {
      return handler.next(options);
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
    try {
      if (netHeaderEnableLog) {
        DebugPrint('响应：URL: ${response.realUri}');
        DebugPrint('Status: ${response.statusCode}, Headers:');
        DebugPrint('Headers:');
        response.headers.forEach((key, values) {
          DebugPrint('  $key: $values');
        });

        /// 单独关心 Set-Cookie
        final setCookies = response.headers.map['set-cookie'];
        if (setCookies != null) {
          DebugPrint('Set-Cookie:');
          for (var c in setCookies) {
            DebugPrint('  $c');
          }
        }
      }
    } catch (_) {
    } finally {
      return handler.next(response);
    }
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 404) {
    }
    return handler.next(err);
  }
}
