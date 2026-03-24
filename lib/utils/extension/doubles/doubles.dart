import 'dart:math';

/// FileName doubles
///
/// @Author 谌文
/// @Date 2024/5/15 18:51
///
/// @Description 扩展
extension Doubles on double {
  static double value(String? value) {
    return double.tryParse(value ?? '0') ?? 0;
  }

  /// 保留两位小数
  double get twoDecimals {
    return Doubles.value(this.toStringAsFixed(2));
  }

  /// 保留四位小数
  double get fourDecimals {
    return Doubles.value(this.toStringAsFixed(4));
  }

  /// 保留两位小数
  static double twoPlaces(String? value) {
    return Doubles.value(Doubles.value(value).toStringAsFixed(2));
  }

  /// 保留两位小数
  static double twoPlacesDouble(double? value) {
    return Doubles.value(value?.toStringAsFixed(2));
  }

  /// 四舍五入方法
  /// places: 保留几位小数
  static double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  /// 是否是整数
  static bool isInteger(num value) {
    return value is int || value % 1 == 0;
  }

  /// 整型就返回整型，不带小数点；小数就返回指定位数的小数
  static String integerOrDecimals(num? value, {int? places}) {
    if (value == null) return '';

    return Doubles.isInteger(value)
        ? value.toInt().toString()
        : value.toStringAsFixed(places ?? 2);
  }
}
