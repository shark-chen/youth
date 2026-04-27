import 'package:kellychat/base/base_controller.dart';
import '../request/dio/dio_net.dart';
import 'bs_cookie_manager.dart';

/// FileName net_config
///
/// @Author 谌文
/// @Date 2024/5/27 16:13
///
/// @Description 请求配置
extension NetConfig on Net {
  /// 加载cookie拦截
  static bool _addCookieInterceptor = false;

  /// 异步初始化 Cookie 拦截器
  static Future<void> initDioCookieInterceptor({bool reInit = false}) async {
    var dio = DioNet().dio;
    if (_addCookieInterceptor == false) {
      _addCookieInterceptor = true;
      try {
        await BsCookieManager.initDioCookieInterceptor(dio, reInit: reInit);
      } catch (e) {
        debugPrint('Failed to init cookie interceptor: $e');
      }
    }
  }

  static Future<void> loadCookie() async {
    await BsCookieManager.loadCookie();
  }

  /// 退出登录清除cookie
  static Future<void> clearCookie() async {
    await BsCookieManager.clearCookie();
    _addCookieInterceptor = false;
    await initDioCookieInterceptor(reInit: true);

  }
}
