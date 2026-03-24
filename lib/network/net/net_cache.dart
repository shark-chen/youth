import 'package:flutter/foundation.dart';
export 'package:flutter/foundation.dart';

/// FileName net_extend_mixin
///
/// @Author 谌文
/// @Date 2024/4/29 20:34
///
/// @Description 接口缓存协议
abstract class NetCache<T> {
  /// identify:缓存key: url+identify
  T cache<E >(
    ValueChanged<E?>? callBack, {
    String? key,
    bool? cache = true,
    bool? responseCache = false,
  });

  /// caches与cache的区别就是解析成的模型是模型列表
  /// identify:缓存key: url+identify
  T caches<E>(
    ValueChanged<List<E>>? callBack, {
    String? key,
    bool? cache = true,
    bool? responseCache = false,
  });
}
