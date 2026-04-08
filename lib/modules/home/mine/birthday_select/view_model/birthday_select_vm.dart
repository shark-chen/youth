import 'package:youth/base/base_vm.dart';
import '../model/birthday_picker_model.dart';

/// FileName: birthday_select_vm
///
/// @Author 谌文
/// @Date 2026/3/28 23:18
///
/// @Description 生日选择-vm（日期区间、滚轮数据）
class BirthdaySelectVM extends BaseVM {
  BirthdaySelectVM({
    int? minYear,
    int? maxYear,
    DateTime? initialDate,
  }) : pickerModel = BirthdayPickerModel(
          minYear: minYear ?? 1949,
          maxYear: maxYear ?? DateTime.now().year,
        ) {
    final picked = clampBirthdayToPast(
      initialDate,
      minYear: pickerModel.minYear,
      maxYear: pickerModel.maxYear,
    );
    pickerModel.selectYear = picked.year;
    pickerModel.selectMonth = picked.month;
    pickerModel.selectDay = picked.day;
  }

  @override
  void onInit() {}

  /// 滚轮与选中值纯数据
  final BirthdayPickerModel pickerModel;

  DateTime get selectedDate => DateTime(
        pickerModel.selectYear,
        pickerModel.selectMonth,
        pickerModel.selectDay,
      );

  String get selectedDateText {
    String two(int v) => v < 10 ? '0$v' : '$v';
    return '${pickerModel.selectYear}-${two(pickerModel.selectMonth)}-${two(pickerModel.selectDay)}';
  }

  /// 最早可选 1949-10-01
  static DateTime earliestAllowedBirthday() => DateTime(1949, 10, 1);

  /// 最晚可选为昨天（不含今天）
  static DateTime latestAllowedBirthday() {
    final n = DateTime.now();
    final today = DateTime(n.year, n.month, n.day);
    return today.subtract(const Duration(days: 1));
  }

  static DateTime clampBirthdayToPast(
    DateTime? initialDate, {
    required int minYear,
    required int maxYear,
  }) {
    final latest = latestAllowedBirthday();
    final floor = earliestAllowedBirthday();
    final now = DateTime.now();
    var raw = initialDate ?? DateTime(now.year - 20, now.month, now.day);
    if (raw.isAfter(latest)) raw = latest;
    if (raw.isBefore(floor)) raw = floor;
    final yearCap = maxYear < latest.year ? maxYear : latest.year;
    final yearLow = minYear < floor.year ? floor.year : minYear;
    var y = raw.year.clamp(yearLow, yearCap);
    final minMonth = y == floor.year ? floor.month : 1;
    final maxMonth = (y == latest.year) ? latest.month : 12;
    var m = raw.month.clamp(minMonth, maxMonth);
    var maxDay = daysInMonthFor(y, m);
    if (y == latest.year && m == latest.month) {
      maxDay = maxDay < latest.day ? maxDay : latest.day;
    }
    final minDay = (y == floor.year && m == floor.month) ? floor.day : 1;
    var d = raw.day.clamp(minDay, maxDay);
    var result = DateTime(y, m, d);
    if (result.isAfter(latest)) {
      result = latest;
    }
    if (result.isBefore(floor)) {
      result = floor;
    }
    return result;
  }

  static int daysInMonthFor(int y, int m) {
    final firstOfNextMonth =
        (m == 12) ? DateTime(y + 1, 1, 1) : DateTime(y, m + 1, 1);
    return firstOfNextMonth.subtract(const Duration(days: 1)).day;
  }

  /// 初始化年份
  void initYearList() {
    final latest = latestAllowedBirthday();
    final endYear =
        pickerModel.maxYear < latest.year ? pickerModel.maxYear : latest.year;
    pickerModel.years = List<int>.generate(
      endYear - pickerModel.minYear + 1,
      (i) => pickerModel.minYear + i,
    );
  }

  /// 年份列表与滚轮控制器（在页面 onInit 中调用一次）
  void initPickers() {
    initYearList();
    pickerModel.yearScrollController = FixedExtentScrollController(
      initialItem: (pickerModel.selectYear - pickerModel.minYear)
          .clamp(0, pickerModel.years.length - 1),
    );
    rebuildMonths(tryJump: false);
    final monthIndex =
        pickerModel.pickerMonths.indexOf(pickerModel.selectMonth);
    pickerModel.monthScrollController = FixedExtentScrollController(
      initialItem: monthIndex >= 0 ? monthIndex : 0,
    );
    rebuildDays(tryJump: false);
    final floor = earliestAllowedBirthday();
    final minD = (pickerModel.selectYear == floor.year &&
            pickerModel.selectMonth == floor.month)
        ? floor.day
        : 1;
    pickerModel.dayScrollController = FixedExtentScrollController(
      initialItem:
          (pickerModel.selectDay - minD).clamp(0, pickerModel.days.length - 1),
    );
  }

  void disposeScrollControllers() {
    pickerModel.yearScrollController.dispose();
    pickerModel.monthScrollController.dispose();
    pickerModel.dayScrollController.dispose();
  }

  /// 选择年
  void onYearChanged(int index) {
    if (index < 0 || index >= pickerModel.years.length) return;
    pickerModel.selectYear = pickerModel.years[index];
    rebuildMonths(tryJump: true);
    rebuildDays(tryJump: true);
  }

  /// 选择月
  void onMonthChanged(int index) {
    if (index < 0 || index >= pickerModel.pickerMonths.length) return;
    pickerModel.selectMonth = pickerModel.pickerMonths[index];
    rebuildDays(tryJump: true);
  }

  /// 选择日
  void onDayChanged(int index) {
    if (index < 0 || index >= pickerModel.days.length) return;
    pickerModel.selectDay = pickerModel.days[index];
  }

  /// 选择年后，重置月
  void rebuildMonths({required bool tryJump}) {
    final latest = latestAllowedBirthday();
    final floor = earliestAllowedBirthday();
    final startMonth = pickerModel.selectYear > floor.year ? 1 : floor.month;
    final endMonth = pickerModel.selectYear < latest.year ? 12 : latest.month;
    final newMonths = startMonth <= endMonth
        ? List<int>.generate(endMonth - startMonth + 1, (i) => startMonth + i)
        : <int>[floor.month];
    pickerModel.pickerMonths
      ..clear()
      ..addAll(newMonths);
    if (!pickerModel.pickerMonths.contains(pickerModel.selectMonth)) {
      pickerModel.selectMonth = pickerModel.pickerMonths.last;
      if (tryJump) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          try {
            pickerModel.monthScrollController
                .jumpToItem(pickerModel.pickerMonths.length - 1);
          } catch (_) {}
        });
      }
    }
  }

  /// 选择月后重置日
  void rebuildDays({required bool tryJump}) {
    final latest = latestAllowedBirthday();
    final floor = earliestAllowedBirthday();
    var maxDay =
        daysInMonthFor(pickerModel.selectYear, pickerModel.selectMonth);
    if (pickerModel.selectYear == latest.year &&
        pickerModel.selectMonth == latest.month) {
      maxDay = maxDay < latest.day ? maxDay : latest.day;
    }
    final minDay = (pickerModel.selectYear == floor.year &&
            pickerModel.selectMonth == floor.month)
        ? floor.day
        : 1;
    final newDays = List<int>.generate(maxDay - minDay + 1, (i) => minDay + i);
    pickerModel.days
      ..clear()
      ..addAll(newDays);
    if (pickerModel.selectDay < minDay) {
      pickerModel.selectDay = minDay;
      if (tryJump) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          try {
            pickerModel.dayScrollController.jumpToItem(0);
          } catch (_) {}
        });
      }
    } else if (pickerModel.selectDay > maxDay) {
      pickerModel.selectDay = maxDay;
      if (tryJump) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          try {
            pickerModel.dayScrollController
                .jumpToItem(pickerModel.selectDay - minDay);
          } catch (_) {}
        });
      }
    }
  }
}
