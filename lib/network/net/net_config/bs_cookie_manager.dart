import 'dart:io';
import 'package:kellychat/config/environment_config/app_config.dart';
import 'package:kellychat/modules/user/global.dart';
import 'package:kellychat/tripartite_library/documents/documents.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

/// FileName: bs_cookie_manager
///
/// @Author 谌文
/// @Date 2026/1/26 19:26
///
/// @Description cookie管理类
class BsCookieManager {
  /// 使用单例模式确保全局唯一
  static final BsCookieManager _instance = BsCookieManager._();

  factory BsCookieManager() => _instance;

  /// 内部构造函数
  BsCookieManager._();

  /// cookie类
  static PersistCookieJar? _cookieJar;

  /// 获取cookie管理实例（使用懒加载单例）
  static Future<PersistCookieJar> get cookieJar async {
    if (_cookieJar == null) {
      debugPrint('Initializing cookie jar...');

      /// 创建目录（如果不存在）
      Directory appDocDir = await Documents().directory;
      String appDocPath = appDocDir.path + '/.cookies/';
      var dir = Directory(appDocPath);
      if (!await dir.exists()) {
        await dir.create(recursive: true);
        debugPrint('Created cookie directory: $appDocPath');
      }
      _cookieJar = PersistCookieJar(
        ignoreExpires: true,
        storage: FileStorage(appDocPath),
      );
      debugPrint('Cookie jar initialized');
    }
    return _cookieJar!;
  }

  /// 初始化 Dio 的 Cookie 拦截器
  static Future<void> initDioCookieInterceptor(
    Dio dio, {
    bool reInit = false,
  }) async {
    try {
      /// 获取新的 cookie jar（确保使用最新的）
      if (reInit == true) {
        _cookieJar = null;
      }

      /// 获取 cookie jar
      var jar = await cookieJar;

      /// 移除已存在的 CookieManager 拦截器（如果有）
      dio.interceptors
          .removeWhere((interceptor) => interceptor is CookieManager);

      /// 添加新的 CookieManager 拦截器
      dio.interceptors.add(CookieManager(jar));
      debugPrint('Dio cookie interceptor initialized successfully');
    } catch (e, stackTrace) {
      debugPrint('Error initializing Dio interceptor: $e');
      debugPrint('Stack trace: $stackTrace');
    }
  }

  /// 获取cookie列表字符串
  static String getCookies(List<Cookie> cookies) {
    return cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
  }

  /// 加载cookie
  static Future<void> loadCookie() async {
    try {
      debugPrint('=== Start loading cookies ===');
      Uri baseUri = Uri.parse(AppConfig.apiHost);
      debugPrint('Loading cookies for: $baseUri');

      /// 获取cookie jar + 尝试加载cookie
      List<Cookie> list = await (await cookieJar).loadForRequest(baseUri);
      debugPrint('Loaded ${list.length} cookies');

      if (list.isNotEmpty) {
        debugPrint(
            'Cookies found: ${list.map((c) => '${c.name}=${c.value}').toList()}');
      }

      /// 更新全局cookie信息
      Global.cookieList = list;
      Global.cookies = CookieManager.getCookies(list);
      debugPrint('Global cookies updated');

      /// 设置到WebView
      if (list.isNotEmpty) {
        await _setWebViewCookies(list);
      }

      debugPrint('=== Finished loading cookies ===');
    } catch (e, stackTrace) {
      debugPrint('Error loading cookie: $e');
      debugPrint('Stack trace: $stackTrace');
    }
  }

  /// 设置WebView cookies
  static Future<void> _setWebViewCookies(List<Cookie> cookies) async {
    try {
      debugPrint('Setting cookies to WebView...');
      List<Cookie> webViewCookies = [];

      /// 为每个需要的域名设置cookie
      List<String> domains = [
        AppConfig.clientHost,
        AppConfig.apiHost,
        AppConfig.blogHost,
      ];

      for (var cookie in cookies) {
        for (var domain in domains) {
          var webViewCookie = Cookie(cookie.name, cookie.value)
            ..domain = domain
            ..expires = DateTime.now().add(const Duration(days: 30))
            ..httpOnly = false
            ..path = '/';
          webViewCookies.add(webViewCookie);
        }
      }

      /// 清除旧cookie
      await WebviewCookieManager().clearCookies();

      /// 设置新cookie
      await WebviewCookieManager().setCookies(webViewCookies);
      debugPrint(
          'Successfully set ${webViewCookies.length} cookies to WebView');
    } catch (e) {
      debugPrint('Error setting WebView cookies: $e');
    }
  }

  /// 退出登录清除cookie
  static Future<void> clearCookie() async {
    try {
      debugPrint('=== Start clearing cookies ===');

      /// 1. 清除cookie jar
      if (_cookieJar != null) {
        await _cookieJar?.deleteAll();

        /// 等待删除操作完成
        // await Future.delayed(const Duration(milliseconds: 200));
        print('Cookie jar cleared');
      }

      /// 2. 强制删除文件夹
      Directory appDocDir = await Documents().directory;
      String appDocPath = appDocDir.path + '/.cookies/';
      var dir = Directory(appDocPath);
      if (await dir.exists()) {
        try {
          await dir.delete(recursive: true);
          debugPrint('Cookie directory deleted');

          /// 重要：等待文件系统完全删除
          // await Future.delayed(const Duration(milliseconds: 300));

          /// 验证是否真的删除了
          bool stillExists = await dir.exists();
          debugPrint('Directory still exists after delete: $stillExists');
        } catch (e) {
          debugPrint('Error deleting directory: $e');
        }
      }

      /// 3. 重置对象
      _cookieJar = null;

      /// 4. 清除WebView cookies
      await WebviewCookieManager().clearCookies();
      debugPrint('WebView cookies cleared');

      /// 5. 清除内存中的cookie
      Global.cookieList = [];
      Global.cookies = '';
      debugPrint('Global cookie state cleared');

      debugPrint('=== Cookie clearing completed successfully ===');
    } catch (e, stackTrace) {
      debugPrint('Error clearing cookie: $e');
      debugPrint('Stack trace: $stackTrace');
    }
  }

  /// 保存cookie（用于登录成功后）
  static Future<void> saveCookie(List<Cookie> cookies) async {
    try {
      debugPrint('=== Start saving cookies ===');
      debugPrint('Saving ${cookies.length} cookies');

      var jar = await cookieJar;
      Uri baseUri = Uri.parse(AppConfig.apiHost);

      /// 保存新的cookies
      await jar.saveFromResponse(baseUri, cookies);
      debugPrint('Saved new cookies');

      /// 更新全局状态
      Global.cookieList = cookies;
      Global.cookies = getCookies(cookies);

      /// 设置到WebView
      await _setWebViewCookies(cookies);
      debugPrint('=== Finished saving cookies ===');
    } catch (e, stackTrace) {
      debugPrint('Error saving cookie: $e');
      debugPrint('Stack trace: $stackTrace');
    }
  }
}
