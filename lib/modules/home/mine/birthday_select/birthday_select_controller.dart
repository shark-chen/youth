import 'package:youth/base/base_controller.dart';

/// FileName: birthday_select_controller
///
/// @Author 谌文
/// @Date 2026/3/26 16:30
///
/// @Description
class BirthdaySelectController extends BaseController {
  final int minYear;
  final int maxYear;

  late final List<int> years;
  final List<int> months = List<int>.generate(12, (i) => i + 1);
  final RxList<int> days = <int>[].obs;

  final RxInt year = DateTime.now().year.obs;
  final RxInt month = DateTime.now().month.obs;
  final RxInt day = DateTime.now().day.obs;

  late final FixedExtentScrollController yearScrollController;
  late final FixedExtentScrollController monthScrollController;
  late final FixedExtentScrollController dayScrollController;

  BirthdaySelectController({
    int? minYear,
    int? maxYear,
    DateTime? initialDate,
  })  : minYear = minYear ?? 1900,
        maxYear = maxYear ?? DateTime.now().year {
    final init = initialDate ?? DateTime.now();
    year.value = init.year.clamp(this.minYear, this.maxYear);
    month.value = init.month.clamp(1, 12);
    day.value = init.day.clamp(1, 31);
  }

   @override
   void onInit() async {
       super.onInit();
       title = '选择生日';

       years = List<int>.generate(maxYear - minYear + 1, (i) => minYear + i);

       yearScrollController = FixedExtentScrollController(
         initialItem: (year.value - minYear).clamp(0, years.length - 1),
       );
       monthScrollController = FixedExtentScrollController(
         initialItem: (month.value - 1).clamp(0, 11),
       );

       _rebuildDays(tryJump: false);
       dayScrollController = FixedExtentScrollController(
         initialItem: (day.value - 1).clamp(0, days.length - 1),
       );
   }

   @override
   void onClose() {
     yearScrollController.dispose();
     monthScrollController.dispose();
     dayScrollController.dispose();
     super.onClose();
   }

   DateTime get selectedDate =>
       DateTime(year.value, month.value, day.value);

   String get selectedDateText {
     String two(int v) => v < 10 ? '0$v' : '$v';
     return '${year.value}-${two(month.value)}-${two(day.value)}';
   }

   void onYearChanged(int index) {
     if (index < 0 || index >= years.length) return;
     year.value = years[index];
     _rebuildDays(tryJump: true);
   }

   void onMonthChanged(int index) {
     if (index < 0 || index >= months.length) return;
     month.value = months[index];
     _rebuildDays(tryJump: true);
   }

   void onDayChanged(int index) {
     if (index < 0 || index >= days.length) return;
     day.value = days[index];
   }

   int _daysInMonth(int y, int m) {
     final firstOfNextMonth = (m == 12) ? DateTime(y + 1, 1, 1) : DateTime(y, m + 1, 1);
     return firstOfNextMonth.subtract(const Duration(days: 1)).day;
   }

   void _rebuildDays({required bool tryJump}) {
     final maxDay = _daysInMonth(year.value, month.value);
     final newDays = List<int>.generate(maxDay, (i) => i + 1);
     days.assignAll(newDays);

     if (day.value > maxDay) {
       day.value = maxDay;
       if (tryJump) {
         WidgetsBinding.instance.addPostFrameCallback((_) {
           try {
             dayScrollController.jumpToItem(day.value - 1);
           } catch (_) {}
         });
       }
     }
   }
}