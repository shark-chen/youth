import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../tripartite_library/store/store.dart';
import '../../../utils/extension/strings/strings.dart';
import '../../../utils/utils/model_utils.dart';
import 'package:flutter/foundation.dart';

/// FileName cache_interceptor
///
/// @Author 谌文
/// @Date 2024/4/22 20:11
///
/// @Description 网络请求拦截器 数据缓存
class CacheInterceptor extends Interceptor {
  CacheInterceptor({this.store});

  /// 本地缓存数据库
  Store? store;

  /// 外部赋值式单利
  static late CacheInterceptor _instance;

  static CacheInterceptor get instance => _instance;

  static CacheInterceptor assignInstance(CacheInterceptor instance) {
    _instance = instance;
    return _instance;
  }

  /// The callback will be executed before the request is initiated.
  ///
  /// If you want to continue the request, call [handler.next].
  ///
  /// If you want to complete the request with some custom data，
  /// you can resolve a [Response] object with [handler.resolve].
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    Map<String, dynamic> queryParameters = options.queryParameters;
    try {
      var isCache = ModelUtils.convert<bool>(queryParameters['isCache']);
      if (isCache != true) return;
      if (queryParameters['cacheCall'] != null &&
          queryParameters['cacheCall'] is ValueChanged) {
        var identify = ModelUtils.convert<String>(queryParameters['identify']);
        store?.get<String>(getStoreKey(options, identify: identify)).then((v) {
          // if (Strings.isEmpty(v)) return;
          // v = null;
          (queryParameters['cacheCall'] as ValueChanged).call(jsonDecode(v ?? '{}'));
        });
      }
    } catch (e) {
      print(e);
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
      Map<String, dynamic> queryParameters =
          response.requestOptions.queryParameters;
      var isCache = ModelUtils.convert<bool>(queryParameters['isCache']);
      if (isCache == true) {
        queryParameters.remove("cacheCall");
        Map? data = ModelUtils.convert<Map>(response.data);
        int? code = ModelUtils.convert<int>(data?['code']);
        if (code == 0) {
          var identify =
              ModelUtils.convert<String>(queryParameters['identify']);
          store?.put(getStoreKey(response.requestOptions, identify: identify),
              jsonEncode(response.data));
        }
        var isResponseCache =
            ModelUtils.convert<bool>(queryParameters['isResponseCache']);
        if (isResponseCache == true) {
          var identify =
              ModelUtils.convert<String>(queryParameters['identify']);
          var value = await store?.get<String>(
              getStoreKey(response.requestOptions, identify: identify));
          if (Strings.isEmpty(value)) return;
          response.extra = jsonDecode(value!);
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
      // If response status code is 404, fetch data from cache
    }
    // For other errors, proceed with normal error handling
    return handler.next(err);
  }

  /// 获取存储key
  String getStoreKey(RequestOptions options, {String, identify}) {
    return '${options.baseUrl}${options.path}${identify ?? ''}';
  }
}

/// 非截获请求式 获取数据缓存
extension CacheInterceptors on CacheInterceptor {
  Future getCache(String key, ValueChanged? cacheCall) async {
    var result = await store?.get<String>(key);
    if (result != null) {
      cacheCall?.call(jsonDecode(result));
    }
  }
}
