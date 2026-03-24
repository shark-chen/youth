import 'package:youth/network/net/request.dart';
import 'package:dio/dio.dart';
import 'entry/net_entry.dart';
import 'net_result.dart';
export 'package:flutter/foundation.dart';

/// FileName net_mixin
///
/// @Author 谌文
/// @Date 2024/4/18 22:05
///
/// @Description 网络抽象类
abstract class Net<T> {
  /// Net实例对象
  static T value<T>() => createNet<T>();

  /// 第三方请求类
  abstract Request? request;

  /// 基础地址, 没配置则那默认的
  abstract String? baseUrl;

  /// path
  abstract String? path;

  /// 接受数据超时时间
  abstract Duration receiveTimeout;

  /// 链接超时时间
  abstract Duration connectTimeout;

  /// 发送数据超时时间
  abstract Duration sendTimeout;

  /// 配置拦截器
  void addInterceptors(List<Interceptor> interceptors);

  /// 清空
  Future clear();

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
  });
}
