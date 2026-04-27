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
      /// eyJhbGciOiJIUzUxMiJ9.eyJjcmVhdGVUaW1lIjoxNzc2NDgwNzg2MzA3LCJ1c2VySWQiOjEwMiwic3ViIjoiMTAyIiwiaWF0IjoxNzc2NDgwNzg2LCJleHAiOjE3NzcwODU1ODZ9.ZxqMojcAlPEsRtepDOMWdGN8-1T0noCjQCiDAOW0tDFV31v232hWK2eO7NGbsKgs40S9hppoTN5pRVWRPfKTag
      // return 'Bearer ' +
      //     'eyJhbGciOiJIUzUxMiJ9.eyJjcmVhdGVUaW1lIjoxNzc1ODc1NTYwNzQ4LCJ1c2VySWQiOjEwMiwic3ViIjoiMTAyIiwiaWF0IjoxNzc1ODc1NTYwLCJleHAiOjE3NzY0ODAzNjB9.kS2e3l6dNkYTqvZAM0czA41djt8VJ0K5O4zoo-AEV3jbULaybRZ64KaSxxZ-5BYh2S4dQjwZLC8pWXNCZF6SAA';
      // return 'Bearer ' +
      //     'eyJhbGciOiJIUzUxMiJ9.eyJjcmVhdGVUaW1lIjoxNzc1NDY1Nzg2Nzk3LCJ1c2VySWQiOjEsInN1YiI6IjEiLCJpYXQiOjE3NzU0NjU3ODYsImV4cCI6MTc3NjA3MDU4Nn0.VpXf1-L1wTSOTVp6Su-ge4ntjs1RHb3-v33MAYCZPaaTheJCdR8LN-nfIc9YZz5laXaa8358rXzltai1236Qyw';
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

