import 'package:youth/tripartite_library/tripartite_library.dart';
import 'package:youth/utils/extension/strings/strings.dart';

/// 后端lang 值
enum LangValue {
  /// 英语
  en(enValue),

  /// 印尼语
  id(idValue),

  /// 中文
  zh(zhValue),

  /// 越南语
  vi(viValue),

  /// 泰语
  th(thValue),

  /// 缅甸语
  my(myValue);

  const LangValue(this.value);

  final String value;

  /// 定义静态常量
  static const String enValue = 'en_US';
  static const String idValue = 'id';
  static const String zhValue = 'zh_CN';
  static const String viValue = 'vi';
  static const String thValue = 'th';
  static const String myValue = 'my';

  /// 字符串转枚举
  factory LangValue.fromString(String? str) {
    if (Strings.isEmpty(str)) {
      return LangValue.en;
    }
    switch (str) {
      case enValue:
        {
          return LangValue.en;
        }
      case idValue:
        {
          return LangValue.id;
        }
      case zhValue:
        {
          return LangValue.zh;
        }
      case viValue:
        {
          return LangValue.vi;
        }
      case thValue:
        {
          return LangValue.th;
        }
      case myValue:
        {
          return LangValue.my;
        }
      default:
        return LangValue.en;
    }
  }
}
