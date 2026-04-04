import '../../../modules/user/user_center/user_center.dart';
export 'string_unit.dart';
import "package:intl/intl.dart";
import '../doubles/doubles.dart';

/// FileName strings
///
/// @Author 谌文
/// @Date 2024/5/29 15:56
///
/// @Description
extension Strings on String {
  /// 判断字符串是否为空
  static bool isEmpty(dynamic str) {
    if (str != null && str is String && str.isNotEmpty) {
      return false;
    }
    return true;
  }

  /// 判断字符串是否不为空
  static bool isNotEmpty(dynamic str) {
    return !Strings.isEmpty(str);
  }

  /// 当为空时，则展示--
  String get defaultValue {
    return Strings.isNotEmpty(this) ? this : '--';
  }

  /// 千分位加,号
  static String formatNumber(
    num number, {
    String? format = '#,###.##',
    int? places = 2,
  }) {
    double roundedValue = Doubles.roundDouble(
        double.tryParse(number.toString()) ?? 0.0, places ?? 2);
    NumberFormat formatter;
    formatter = NumberFormat(format);
    var result = formatter.format(roundedValue);
    return result;
  }

  /// 保留小数位数
  static String places(String? value, {int? fixed = 2}) {
    return Doubles.value(value).toStringAsFixed(fixed ?? 2);
  }

  /// 首字母大写
  static String? capitalize(String? str) {
    if (Strings.isEmpty(str)) {
      return str;
    }
    return '${str?[0].toUpperCase()}${str?.substring(1)}';
  }

  /// 首字母大写
  String? get capitalizes {
    if (Strings.isEmpty(this)) {
      return this;
    }
    return '${this[0].toUpperCase()}${this.substring(1)}';
  }

  /// 去除前面的0
  static String removeLeadingZeros(String input, String defaultValue) {
    /// 去除前导零
    if (input.isEmpty) return defaultValue;

    /// 使用正则表达式去除前导零
    var replaceFirst = input.replaceFirst(RegExp('^0+'), '');
    if (Strings.isEmpty(replaceFirst)) {
      return defaultValue;
    }
    return replaceFirst;
  }

  /// 判断是个字符串是否是数字
  /// 判断字符串是否都是数字
  bool get isNumeric {
    if (Strings.isEmpty(this)) return false;

    /// 更全面的正则表达式，匹配各种数字格式
    final numericRegex = RegExp(r'^[+-]?(\d+([.]\d*)?|[.]\d+)([eE][+-]?\d+)?$');
    return numericRegex.hasMatch(this);
  }

  /// 去除JS字符串中的a标签
  static String removeAnchorTags(String jsString) {
    RegExp exp = RegExp(r"<[^>]*>");
    return jsString.replaceAll(exp, "");
  }

  static String? breakWord(String? word) {
    if (word == null || word.isEmpty) {
      return word;
    }
    String breakWord = ' ';
    for (var element in word.runes) {
      breakWord += String.fromCharCode(element);
      breakWord += '\u200B';
    }
    return breakWord;
  }

  /// 分钟，小时等，小于等于9时，前面加0，操作
  static String timeZero(int value) {
    if (value > 9 || value < -9) return value.toString();
    return '0${value.toString()}';
  }

  /// 忽略大小写比较字符串
  bool equalIgnoreCase(String str) {
    return this.toLowerCase() == str.toLowerCase();
  }

  /// 不是数字的话，默认返回0
  double get getDouble {
    if (this.isNumeric == true) {
      return double.tryParse(this) ?? 0;
    }
    return 0;
  }

  /// 不是数字的话，默认返回0
  int get getInt {
    if (this.isNumeric == true) {
      return int.tryParse(this) ?? 0;
    }
    return 0;
  }

  /// 保留两位小数, 这个只会返回有效的 两位小数，如2.1， 而不是是2.10
  String get twoPlaces {
    return Doubles.value(this).toStringAsFixed(2);
  }

  /// 正则判断是否包含 HTML 标签
  bool get containsHtmlTag {
    final reg = RegExp(r'<[^>]+>');
    return reg.hasMatch(this);
  }
}
