/// FileName base_request
///
/// @Author 谌文
/// @Date 2023/9/12 11:10
///
/// @Description 基础请求类
enum RequestMethod { get, post }

abstract class BaseRequest {
  ///
  String baseUrl() => "";

  /// 请求URL
  String requestUrl();

  /// 请求方式
  RequestMethod requestMethod() => RequestMethod.post;
}