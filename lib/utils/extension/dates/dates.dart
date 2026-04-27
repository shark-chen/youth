import 'package:kellychat/modules/user/global.dart';
import 'package:intl/intl.dart';

/// FileName date_times
///
/// @Author 谌文
/// @Date 2024/6/19 20:23
///
/// @Description 日期格式化
extension Dates on DateTime {
  /// 获取格式化成yyyy-MM-dd的年月日 日期
  /// day： 0表示当天， -1表示昨天，+1表示明天，以此类推
  static String ymd({int? day}) {
    var date = DateTime.now();
    if (day == null) return DateFormat('yyyy-MM-dd').format(date);
    return DateFormat('yyyy-MM-dd').format(date.add(Duration(days: day)));
  }

  /// 获取格式化成yyyy-MM-dd的年月日 日期
  /// dateTime： 时间字符串
  static String ymdByStr(String dateTime) {
    return DateFormat('yyyy-MM-dd').format(DateTime.parse(dateTime));
  }

  /// 获取格式化成yyyy-MM-dd的年月日 日期
  /// dateTime： 日期
  static String ymdByDateTime(DateTime dateTime) {
    String month =
        (dateTime.month > 9) ? '${dateTime.month}' : '0${dateTime.month}';
    String day = (dateTime.day > 9) ? '${dateTime.day}' : '0${dateTime.day}';
    return '${dateTime.year}-$month-$day';
  }

  /// 获取市区
  static String timeZoneName() {
    DateTime now = DateTime.now();
    int offsetHours = now.timeZoneOffset.inHours;
    return 'GMT${offsetHours >= 0 ? '+' : ''}$offsetHours:00';
  }

  /// 格式化时间戳
  static String formatTimestamp(int timestamp, {String? format}) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var formatter = DateFormat(format ?? 'yyyy-MM-dd HH:mm');
    return formatter.format(date);
  }

  /// 判断当前时间戳是不是今天
  static bool isTimestampToday(int timestamp) {
    /// 将时间戳转换为DateTime
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);

    /// 获取当前日期
    DateTime now = DateTime.now();

    /// 比较年月日是否相同
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// 未满10是，前面加0
  static String addZeroBefore(int num) {
    if (num >= 10) return '${num}';
    if (num >= 0 || num < 10) return '0${num}';
    if (num < 0 || num > -10) return '-0${num}';
    if (num <= -10) return '${num}';
    return '${num}';
  }

  /// 判断是否是今天
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// 判断字符串格式的时间是否是今天
  /// dateTimeStr: '2025-08-27 21:00:00' 格式的时间字符串
  static bool isStringToday(String dateTimeStr) {
    try {
      DateTime date = DateTime.parse(dateTimeStr);
      return isToday(date);
    } catch (e) {
      return false;
    }
  }

  // 年月日 时分
  static String timeFormatHM(DateTime date) {
    Map map = {
      'zh_CN': 'yyyy-MM-dd HH:mm',
      'en_US': 'dd MMM yyyy HH:mm',
      'id': 'dd MMM yyyy HH:mm',
      'vi': 'dd/MM/yyyy HH:mm',
      'th': 'dd MMM yyyy HH:mm'
    };

    final formatVal = map[Global.langValue.value] ?? map['en_US'];
    return DateFormat(formatVal).format(date);
  }
}
