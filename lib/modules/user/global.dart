import 'dart:io';
import 'package:youth/config/environment_config/app_config.dart';
import 'package:youth/utils/stores/stores.dart';
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

  /// 设置登录
  /// updateSaveAccountToken: 用于更新多账号登录时，当前账号的token
  static Future setAccessToken(
    String token, {
    bool? updateSaveAccountToken = false,
  }) async {
    try {
      if (Strings.isEmpty(token)) return;
      if (token == accessToken.value) {
        return token;
      }
      accessToken.value = token;
      await Stores().put('appLoginToken', token, userLat: false);
      return token;
    } catch (_) {
      return token;
    }
  }

  /// 设置登录
  static Future<bool> clearAccessToken() async {
    accessToken.value = "";
    await Stores().put('appLoginToken', '', userLat: false);
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

class RunTimeCache {
  static Map<String, dynamic> cacheMap = {};

  static void setInt(String key, int value) {
    cacheMap[key] = value;
  }

  static void setString(String key, String value) {
    cacheMap[key] = value;
  }

  static void set(String key, dynamic value) {
    cacheMap[key] = value;
  }

  static int? getInt(String key) {
    return cacheMap[key];
  }

  static String? getString(String key) {
    return cacheMap[key];
  }

  static dynamic get(String key) {
    return cacheMap[key];
  }

  static dynamic delKey(String key) {
    return cacheMap.remove(key);
  }

  static void clear() {
    return cacheMap.clear();
  }
}
