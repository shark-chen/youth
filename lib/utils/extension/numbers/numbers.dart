import "package:youth/utils/extension/strings/strings.dart";
import "package:intl/intl.dart";

/// FileName number
///
/// @Author 谌文
/// @Date 2024/10/15 14:35
///
/// @Description 金额格式化
extension NumberFormats on NumberFormat {
  static String value(dynamic number) {
    if (number == null) return number;
    try {
      var format = NumberFormat("#,##0.00", "en_US");
      if (number.toString().isNumeric == false) {
        return number.toString().replaceAll(RegExp(r'\.?0*$'), '');
      }
      if (!(number is num)) {
        number = num.tryParse(number.toString());
      }
      var result = format.format(number);
      return result.replaceAll(RegExp(r'\.?0*$'), '');
    } catch (_) {
      return number;
    }
  }
}
