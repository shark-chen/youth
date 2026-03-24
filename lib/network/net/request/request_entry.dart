import 'dio/dio_net.dart';

/// FileName entry
///
/// @Author 谌文
/// @Date 2025/4/7 16:42
///
/// @Description 此种是各种请求三方库
T createRequest<T>() {
  return (requestEntryMap[T.toString()]() as T);
}

/// 实现了Request的三方请求类，使用方可以自由选择使用那个三方库进行接口请求，现阶段只有Dio
late final Map<String, dynamic> requestEntryMap = {
  (DioNet).toString(): DioNet.init,
};
