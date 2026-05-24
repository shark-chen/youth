import 'dart:io';
import 'package:kellychat/config/environment_config/app_config.dart';
import 'package:kellychat/utils/stores/stores.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../utils/extension/strings/strings.dart';
import '../../utils/utils/language/lang_value.dart';

class Global {
  static LangValue _langValue = LangValue.en;
  static String cookies = "";
  static List<Cookie> cookieList = [];
  static bool canEnableNotice = false;
  static bool? newScan;
  static var accessToken = "".obs;
  static var actualLogin = false.obs;
  static var lang = langValue.obs;

  /// 获取之前登录的token
  static Future<String?> get getAccessToken async {
    try {
      if (accessToken.isNotEmpty) {
        return accessToken.value;
      }
      accessToken.value =
          await Stores().get<String>('appLoginToken', userLat: false) ?? '';
      return accessToken.value;
    } catch (_) {
      return accessToken.value;
    }
  }

  /// 设置保存token
  static Future setAccessToken(String token) async {
    try {
      if (Strings.isEmpty(token)) return;
      if (token == accessToken.value) {
        return token;
      }
      accessToken.value = token;
      await Stores().put('appLoginToken', token, userLat: false);
      await setTokenTime(DateTime.now().millisecondsSinceEpoch);
      return token;
    } catch (_) {
      return token;
    }
  }

  /// 获取token保存时间
  static Future<int?> get getTokenTime async {
    return await Stores().get<int>('appLoginTokenTime', userLat: false);
  }

  /// 设置token保存时间
  static Future setTokenTime(int time) async {
    await Stores().put('appLoginTokenTime', time, userLat: false);
  }

  /// 清除token保存时间
  static Future clearTokenTime() async {
    await Stores().put('appLoginTokenTime', 0, userLat: false);
  }

  /// 设置登录
  static Future<bool> clearAccessToken() async {
    accessToken.value = "";
    await Stores().put('appLoginToken', '', userLat: false);
    await clearTokenTime();
    return true;
  }

  static void clear() {
    cookies = "";
    cookieList = [];
    canEnableNotice = false;
    clearAccessToken();
  }

  static LangValue get langValue {
    Locale? deviceLocale;
    if (AppConfig.env == Environment.dev ||
        AppConfig.env == Environment.alpha) {
      deviceLocale = Get.locale;
    } else {
      // deviceLocale = Get.deviceLocale;
      deviceLocale = Get.locale;
    }
    _langValue = LangValue.en;
    if (deviceLocale != null) {
      Map map = {
        "id": LangValue.id,
        "in": LangValue.id,
        "th": LangValue.th,
        "vi": LangValue.vi,
        "vn": LangValue.vi,
        "zh": LangValue.zh,
        "cn": LangValue.zh,
      };
      _langValue = map[deviceLocale.languageCode] ?? LangValue.en;
    }
    return _langValue;
  }

  static String get langCodeByVoice {
    Locale? deviceLocale;
    if (AppConfig.env == Environment.dev ||
        AppConfig.env == Environment.alpha) {
      deviceLocale = Get.locale;
    } else {
      deviceLocale = Get.deviceLocale;
    }
    return deviceLocale != null ? deviceLocale.languageCode : "";
  }

  static String get langStringValue {
    switch (langValue) {
      case LangValue.en:
        return "EN";
      case LangValue.id:
        return "ID";
      case LangValue.vi:
        return "VN";
      case LangValue.th:
        return "TH";
      case LangValue.zh:
        return "ZH";
      default:
        return "EN";
    }
  }

  static List<WebViewCookie> get webviewCookies {
    List<WebViewCookie> res = [];
    for (var cookie in cookieList) {
      res.add(WebViewCookie(
          name: cookie.name,
          value: Uri.decodeFull(cookie.value),
          domain: AppConfig.clientHost,
          path: '/'));
      res.add(WebViewCookie(
          name: cookie.name,
          value: Uri.decodeFull(cookie.value),
          domain: AppConfig.clientHost,
          path: '/'));
    }
    return res;
  }
}
