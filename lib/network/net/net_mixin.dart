import 'request.dart';
import 'request/dio/dio_net.dart';
import 'package:dio/dio.dart';
import '../../config/environment_config/app_config.dart';
import '../../generated/locales.g.dart';
import 'net_cache.dart';
import 'net_mixin.dart';
export 'entry/user/user.dart';

export 'entry/auxiliary/auxiliary.dart';
export 'entry/auxiliary/wechat.dart';
import 'package:get/get.dart';
import 'net_result.dart';
import 'package:dio/dio.dart' as Dio;

/// FileName net
///
/// @Author 谌文
/// @Date 2024/4/18 22:02
///
/// @Description 网络请求类
/// 标记已经添加过缓存截获类
abstract class NetMixin<T> with NetCache<T> implements Net<T> {
  /// 第三方请求类- 不设置默认使用 Dio框架， 对应类DioNet
  @override
  Request? request;

  /// MARK - Net，提供默认实现
  /// 基础地址
  @override
  String? baseUrl = AppConfig.apiHost;

  /// 接口path
  @override
  String? path = '';

  @override
  Duration receiveTimeout = Duration(milliseconds: 60000);

  /// 链接超时时间
  @override
  Duration connectTimeout = Duration(milliseconds: 60000);

  /// 发送数据超时时间
  @override
  Duration sendTimeout = Duration(milliseconds: 60000);

  /// MARK - NetCache 辅助接口实现辅助属性
  /// 此参数不需要设置，你在调用cache或caches方法时，会自动默认标记为true,或通过cache参数控制是否，对当前请求进行缓存
  bool isCache = false;

  /// 接口返回Response数据，是否需要带出上次缓存的数据
  /// 此参数不需要设置，你在调用cache或caches方法时，你可设置此参数
  bool isResponseCache = false;

  /// 缓存回调，使用方不需要设值，调用cache或caches会自动赋值
  ValueChanged? cacheCall;

  /// 缓存使用的唯一key
  String? identify;

  /// 调用此方法即表示启用缓存
  /// isList: 当传入的泛型S，需要转成模型List时候，isList = true
  /// key: 默认已连接为存储KEY
  /// cache: 是否缓存请求的数据，默认缓存，
  /// responseCache: 是否在请求返回上，带上上次的缓存数据，用啥存用呢？
  /// 比如用户的配置,这些配置是很少改动的，可以直接拿配置缓存数据 （如用户筛选条件）可以先拿缓存筛选配置数据 去获取用户其他接口数据，之后 配置接口数据返回了数据，
  /// 可以用来判断网络配置数据与缓存的配置数据是不是一样的，如果是一样的，就没必要再刷新业务嘛
  @override
  T cache<E>(
    ValueChanged<E?>? callBack, {
    String? key,
    bool? cache = true,
    bool? responseCache = false,
  }) {
    if (cache == false) return this as T;
    try {
      isCache = cache ?? true;
      this.isResponseCache = responseCache ?? false;
      if (callBack == null) return this as T;
      cacheCall =
          (v) => callBack.call((NetResult<E>.fromJson(v).value ?? null) as E?);
    } finally {
      return (this..identify = key) as T;
    }
  }

  /// caches与cache的区别就是解析成的模型是模型列表
  /// identify:缓存key: url+identify
  /// responseCache: 是否在请求返回上，带上上次的缓存数据，用啥存用呢？
  /// 比如用户的配置，再拿取了缓存数据后，刷新了页面，之后接口数据返回了数据，
  /// 需要判断与上次缓存的配置数据是不是一样的，如果是一样的，就没必要再刷新业务嘛
  @override
  T caches<E>(
    ValueChanged<List<E>>? callBack, {
    String? key,
    bool? cache = true,
    bool? responseCache = false,
  }) {
    if (cache == false) return this as T;
    try {
      isCache = cache ?? true;
      this.isResponseCache = responseCache ?? false;
      if (callBack == null) return this as T;
      cacheCall = (v) => callBack.call(NetResult<E>.fromJson(v).values);
    } finally {
      return (this..identify = key) as T;
    }
  }

  /// 配置拦截器
  @override
  void addInterceptors(List<Interceptor> interceptors) {
    return (request ??= Request.value<DioNet>()).addInterceptors(interceptors);
  }

  /// Handy method to make http GET request, which is a alias of  [dio.fetch(RequestOptions)].
  @override
  Future<NetResult<M>> get<M>(
    String path, {
    Map<String, dynamic>? params,
  }) async {
    try {
      this.path = path;
      await configNetOption(this);
      return await (request ??= Request.value<DioNet>())
          .get(path, params: composeParams(params));
    } catch (e) {
      return NetResult.error(msg: LocaleKeys.NetworkError.tr, message: "e:$e");
    }
  }

  /// Handy method to make http POST request, which is a alias of  [dio.fetch(RequestOptions)].
  /// M: 传入模型类，请求到的数据会自动解析成对应的模型类
  /// data: body参数
  /// isFormData: true,会自动把data包
  @override
  Future<NetResult<M>> post<M>(
    String path, {
    data,
    bool? isFormData = false,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    try {
      this.path = path;
      await configNetOption(this);
      return await (request ??= Request.value<DioNet>()).post(
        path,
        data: isFormData == true ? Dio.FormData.fromMap(data) : data,
        params: composeParams(params),
        options: options,
      );
    } catch (e) {
      return NetResult.error(msg: LocaleKeys.NetworkError.tr, message: "e:$e");
    }
  }

  /// Convenience method to make an HTTP PUT request.
  @override
  Future<NetResult<M>> put<M>(
    String path, {
    data,
    bool? isFormData = false,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    try {
      this.path = path;
      await configNetOption(this);
      return await (request ??= Request.value<DioNet>()).put(
        path,
        data: isFormData == true ? Dio.FormData.fromMap(data) : data,
        params: composeParams(params),
        options: options,
      );
    } catch (e) {
      return NetResult.error(msg: LocaleKeys.NetworkError.tr, message: "e:$e");
    }
  }

  /// 清空
  @override
  Future clear() async {
    (request ??= Request.value<DioNet>()).clear();
  }

  /// 获取存储key
  String getStoreKey() {
    return '${baseUrl}${path}${identify ?? ''}';
  }

  /// 自定义请求头/其他配置设置
  Future configNetOption(NetMixin mixin) async {
    (request ??= Request.value<DioNet>()).configNetOption(mixin);
  }

  /// 请求参数统一处理
  Map<String, dynamic>? composeParams(Map<String, dynamic>? params) {
    if (isCache == false) return params;
    return {
      'isCache': isCache,
      'isResponseCache': isResponseCache,
      'cacheCall': cacheCall,
      'identify': identify,
    }..addAll(params ?? {});
  }
}
