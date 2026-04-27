import 'package:kellychat/utils/extension/maps/maps.dart';
import 'package:dio/dio.dart';

/// FileName: response_util
///
/// @Author 谌文
/// @Date 2026/3/4 14:31
///
/// @Description 接口响应工具类
class ResponseUtil {
  /// 获取请求参数
  static Map queryParameters(Response response) {
    Map requestParameters = {};
    try {
      if (Maps.isNotEmpty(response.requestOptions.queryParameters)) {
        requestParameters.addAll(response.requestOptions.queryParameters);
      }
      if (Maps.isNotEmpty(response.requestOptions.data)) {
        requestParameters.addAll(response.requestOptions.data);
      }
      if (response.requestOptions.data != null &&
          response.requestOptions.data is FormData) {
        FormData formData = response.requestOptions.data;
        requestParameters.addAll(Map.fromEntries(formData.files));
      }
    } catch (_) {
    } finally {
      return requestParameters;
    }
  }
}
