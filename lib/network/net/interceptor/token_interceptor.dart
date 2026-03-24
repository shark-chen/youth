import 'package:dio/dio.dart';
import '../../../generated/locales.g.dart';
import '../../../modules/routes/app_pages.dart';
import '../../../modules/user/global.dart';
import '../../../modules/user/user_center/user_center.dart';
import 'package:get/get.dart' as Getx;
import '../../../utils/extension/lists/lists.dart';
import '../../../utils/utils/model_utils.dart';
import '../../../widget/alert/custom_alert.dart';

/// FileName token_interceptor
///
/// @Author 谌文
/// @Date 2024/5/28 20:31
///
/// @Description token截获更新
class TokenInterceptor extends Interceptor {
  /// The callback will be executed before the request is initiated.
  ///
  /// If you want to continue the request, call [handler.next].
  ///
  /// If you want to complete the request with some custom data，
  /// you can resolve a [Response] object with [handler.resolve].
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
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
      List<String>? accessTokens = response.headers['mucToken'];
      if (Lists.isNotEmpty(accessTokens)) {
        Global.setAccessToken(accessTokens?.first ?? '', updateSaveAccountToken: true);
      }

      /// 密码发生变更
      passwordChanges(response);
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

  /// 密码发生变更
  Future passwordChanges(Response response) async {
    try {

      Map? data = ModelUtils.convert<Map>(response.data);
      int? code = ModelUtils.convert<int>(data?['code']);
      if (code == 4003) {
        Future.delayed(const Duration(milliseconds: 800), () async {
          await showCustomAlert(DialogMessageModel(
              title: ModelUtils.convert<String>(data?['msg']) ?? '--',
              actions: [

              ]));
        });

        /// 个人中心数据清空
        await UserCenter().clear();
        await Getx.Get.offAllNamed(Routes.login);
      }
    } catch (_) {}
  }
}
