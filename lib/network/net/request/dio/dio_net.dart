import 'package:kellychat/network/net/net_config/net_config.dart';
import 'package:kellychat/tripartite_library/documents/documents.dart';
import 'package:kellychat/utils/utils/language/language_utils.dart';
import 'package:dio/dio.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import '../../../../config/environment_config/app_config.dart';
import '../../../../modules/user/global.dart';
import '../../../../modules/user/user_center/user_center.dart';
import '../../../../tripartite_library/store/hive/hive_store.dart';
import '../../../../utils/extension/lists/lists.dart';
import '../../../../utils/extension/strings/strings.dart';
import '../../interceptor/auto_login_interceptor.dart';
import '../../interceptor/cache_interceptor.dart';
import '../../interceptor/header_interceptor.dart';
import '../../interceptor/report_interceptor.dart';
import '../../net_mixin.dart';
import '../../net_result.dart';
import '../../request.dart';

/// FileName dio_net
///
/// @Author 谌文
/// @Date 2024/4/19 15:15
///
/// @Description dio
late bool addInterceptor = false;
late bool addCacheInterceptor = false;

class DioNet implements Request {
  factory DioNet.init() => DioNet();

  /// 单利
  static final DioNet _instance = DioNet._();

  factory DioNet() => _instance;

  DioNet._() {}

  Dio? _dio;

  /// get方法
  Dio get dio {
    if (_dio != null) return _dio!;
    return instanceDio();
  }

  /// 初始化dio
  Dio instanceDio() {
    if (_dio != null) return _dio!;
    _dio = Dio();
    // _dio?.options.headers['systemType'] = GetPlatform.isIOS ? 2 : 1;
    _dio?.options
      ?..connectTimeout = Duration(microseconds: 120000)
      ..receiveTimeout = Duration(microseconds: 120000)
      ..sendTimeout = Duration(microseconds: 120000);
    return _dio!;
  }

  /// Handy method to make http GET request, which is a alias of  [dio.fetch(RequestOptions)].
  /// M: 传入模型类，请求到的数据会自动解析成对应的模型类
  @override
  Future<NetResult<M>> get<M>(
    String path, {
    Map<String, dynamic>? params,
  }) async {
    var response = await dio.get(path, queryParameters: params);
    return NetResult<M>.fromResponse(response);
  }

  /// Handy method to make http POST request, which is a alias of  [dio.fetch(RequestOptions)].
  /// M: 传入模型类，请求到的数据会自动解析成对应的模型类
  /// data: body参数
  /// isFormData: true,会自动把data包装成 FormData.fromMap;
  /// params: 链接后面拼接参数
  @override
  Future<NetResult<M>> post<M>(
    String path, {
    data,
    bool? isFormData = false,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    var response = await dio.post(
      path,
      data: data,
      queryParameters: params,
      options: options,
    );
    return NetResult<M>.fromResponse(response);
  }

  /// Handy method to make http POST request, which is a alias of  [dio.fetch(RequestOptions)].
  /// M: 传入模型类，请求到的数据会自动解析成对应的模型类
  /// data: body参数
  /// isFormData: true,会自动把data包装成 FormData.fromMap;
  /// params: 链接后面拼接参数
  @override
  Future<NetResult<M>> put<M>(
    String path, {
    data,
    bool? isFormData = false,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    var response = await dio.put(
      path,
      data: data,
      queryParameters: params,
      options: options,
    );
    return NetResult<M>.fromResponse(response);
  }

  /// Handy method to make http delete request, which is a alias of  [dio.fetch(RequestOptions)].
  /// M: 传入模型类，请求到的数据会自动解析成对应的模型类
  /// data: body参数
  /// params: 链接后面拼接参数
  @override
  Future<NetResult<M>> delete<M>(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    var response = await dio.delete(
      path,
      data: data,
      queryParameters: params,
      options: options,
    );
    return NetResult<M>.fromResponse(response);
  }

  @override
  void clear() {
    addCacheInterceptor = false;
    dio.interceptors
        .removeWhere((interceptor) => interceptor is CacheInterceptor);
  }

  @override
  void addInterceptors(List<Interceptor> interceptors) async {
    if (Lists.isEmpty(interceptors)) return;
    final dioNet = dio;
    interceptors.forEach((element) {
      if (!dioNet.interceptors.contains(element)) {
        dioNet.interceptors.add(element);
      }
    });
  }

  @override
  Future configNetOption(NetMixin mixin) async {
    try {
      final dioNet = dio;
      dioNet.options
        ..baseUrl = mixin.baseUrl ?? AppConfig.apiHost
        ..headers['Authorization'] =
            'Bearer ' + ((await Global.getAccessToken) ?? '')
        ..receiveTimeout = mixin.receiveTimeout
        ..sendTimeout = mixin.sendTimeout
        ..connectTimeout = mixin.connectTimeout;
      if (addInterceptor == false) {
        addInterceptor = true;
        dioNet.interceptors.add(AutoLoginInterceptor());
        dioNet.interceptors.add(ReportInterceptor());
        dioNet.interceptors.add(HeaderInterceptor());
      }
      if (addCacheInterceptor == false) {
        var uid = UserCenter().user?.id;
        if (uid != null) {
          if (addCacheInterceptor == true) return;
          addCacheInterceptor = true;
          dioNet.interceptors.add(CacheInterceptor.assignInstance(
              CacheInterceptor(
                  store: HiveStore(
                      (await Documents().directory).path, 'net_cache',
                      identify: uid.toString()))));
        }
      }
    } catch (_) {}
  }
}
