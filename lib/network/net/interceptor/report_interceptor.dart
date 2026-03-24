import 'package:youth/network/net/util/response_util.dart';
import 'package:youth/utils/marco/debug_print.dart';
import 'package:dio/dio.dart';
import '../../../config/environment_config/config.dart';
import '../../../modules/auxiliary/network_look/model/network_model_utils.dart';
import '../../../utils/utils/model_utils.dart';

/// FileName report_interceptor
///
/// @Author 谌文
/// @Date 2024/5/16 14:07
///
/// @Description 上报日志拦截
class ReportInterceptor extends Interceptor {
  /// The callback will be executed before the request is initiated.
  ///
  /// If you want to continue the request, call [handler.next].
  ///
  /// If you want to complete the request with some custom data，
  /// you can resolve a [Response] object with [handler.resolve].
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (environment != Environment.prod || netEnableLog) {
      options.extra['startTime'] = DateTime.now().millisecondsSinceEpoch;
    }
    return handler.next(options);
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
      if (environment != Environment.prod || netEnableLog) {
        Map json = ModelUtils.convert<Map>(response.data) ?? {};
        int code = ModelUtils.convert<int>(json['code']) ?? -1;
        Map requestParameters = ResponseUtil.queryParameters(response);
        final startTime = response.requestOptions.extra['startTime'] ?? 0;
        final endTime = DateTime.now().millisecondsSinceEpoch;
        if (netEnableLog) {
          DebugPrint(
              '${response.requestOptions.path} 接口耗时: ${endTime - startTime} ms');
          DebugPrint(requestParameters);
          DebugPrint(response.data);
          DebugPrint('\n');
        }

        /// 记录日志
        NetworkModelUtils().addNetworkData(
            path:
                '${response.requestOptions.path} \n接口耗时: ${endTime - startTime} ms',
            succeed: code == 0,
            requestParameters: requestParameters.toString(),
            responseParameters: response.data.toString());
      }
    } catch (_) {
    } finally {
      return handler.next(response);
    }
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
