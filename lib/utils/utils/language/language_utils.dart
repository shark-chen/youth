import 'package:kellychat/utils/extension/strings/strings.dart';
import 'package:kellychat/utils/stores/stores.dart';
import 'package:kellychat/utils/utils/language/lang_value.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
export 'package:kellychat/utils/utils/language/lang_value.dart';

/// FileName: language_utils
///
/// @Author 谌文
/// @Date 2026/1/16 14:51
///
/// @Description 语种工具类
/// 后端语言 映射APP的语言
final LangValueLocaleMap = {
  /// 英语
  LangValue.en: const Locale("en", "US"),

  /// 印尼语
  LangValue.id: const Locale("id", "ID"),

  /// 中文
  LangValue.zh: const Locale("zh", "CN"),

  /// 越南语
  LangValue.vi: const Locale("vi", "LA"),

  /// 泰语
  LangValue.th: const Locale("th", "TH"),

  // /// 泰语
  // LangValue.my: const Locale("my", "MM"),
};

class LanguageUtils {
  /// 通过后端映射的枚举获取语种
  static Locale localeFromLangValue(LangValue langValue) {
    return LangValueLocaleMap[langValue] ?? const Locale("en", "US");
  }

  /// 通过当前APP语言- 获取到对应的后端服务语言
  static LangValue get langValue {
    Locale? deviceLocale = Get.locale;
    if (deviceLocale != null) {
      Map map = {
        "id": LangValue.id,
        "in": LangValue.id,
        "th": LangValue.th,
        "vi": LangValue.vi,
        "vn": LangValue.vi,
        "zh": LangValue.zh,
        "cn": LangValue.zh,
        // "my": LangValue.my,
      };
      return map[deviceLocale.languageCode] ?? LangValue.en;
    }
    return LangValue.en;
  }

  /// 获取APP的语言
  static Future<Locale?> get appLocale async {
    /// 获取上次用户选择的语种
    await Stores().initDeviceLat();
    final language = await getSaveLanguage();
    Locale? locale;
    if (Strings.isNotEmpty(language)) {
      locale =
          LanguageUtils.localeFromLangValue(LangValue.fromString(language));
    } else {
      /// 没有则用设备语言
      locale = Get.deviceLocale;
    }
    return locale;
  }

  /// 存储选择的语言
  static Future saveLanguage(String language) async {
    await Stores().put<String>('equipmentLanguage', language, userLat: false);
  }

  /// 获取存储的语言
  static Future<String?> getSaveLanguage() async {
    return await Stores().get<String>('equipmentLanguage', userLat: false);
  }
}
