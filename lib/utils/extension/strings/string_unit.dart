/// FileName string_unit
///
/// @Author 谌文
/// @Date 2024/6/14 09:57
///
/// @Description 格式化单位
extension StringUnit on String {
  /// 亿
  static String hundredMillion(int sale) {
    return (sale * 0.00000001).toStringAsFixed(1);
  }

  /// 千万
  static String millions(int sale) {
    return (sale * 0.0000001).toStringAsFixed(1);
  }

  /// 百万
  static String million(num sale, {int fixed = 1}) {
    return (sale * 0.000001).toStringAsFixed(fixed);
  }

  /// 万
  static String tenThousand(int sale) {
    return (sale * 0.0001).toStringAsFixed(1);
  }

  /// 千
  static String thousand(num sale, {int fixed = 1}) {
    return (sale * 0.001).toStringAsFixed(fixed);
  }

  /// 百
  static String hundred(int sale) {
    return sale.toString();
  }
}
