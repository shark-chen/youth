import 'package:dio/dio.dart';
import 'net_mixin.dart';
import 'net_result.dart';
import 'request/request_entry.dart';

/// FileName request
///
/// @Author 谌文
/// @Date 2025/4/7 15:15
///
/// @Description 三方库需要实现的接口
abstract class Request<T> {
  /// Net实例对象
  static T value<T>() => createRequest<T>();

  /// 自定义请求头/其他配置设置
  Future configNetOption(NetMixin mixin);

  /// 配置拦截器
  void addInterceptors(List<Interceptor> interceptors);

  /// 清空
  clear();

  /// Handy method to make http GET request, which is a alias of  [dio.fetch(RequestOptions)].
  /// M: 传入模型类，请求到的数据会自动解析成对应的模型类
  Future<NetResult<M>> get<M>(
    String path, {
    Map<String, dynamic>? params,
  });

  /// Handy method to make http POST request, which is a alias of  [dio.fetch(RequestOptions)].
  /// M: 传入模型类，请求到的数据会自动解析成对应的模型类
  /// data: body参数
  /// isFormData: true,会自动把data包装成 FormData.fromMap;
  /// params: 链接后面拼接参数
  Future<NetResult<M>> post<M>(
    String path, {
    data,
    bool? isFormData = false,
    Map<String, dynamic>? params,
    Options? options,
  });
}
