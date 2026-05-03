import 'package:flutter/widgets.dart';

/// 编辑资料-生日滚轮纯数据（从 [BirthdayPickerModel] 复制，独立路径）
class EditBirthdayPickerModel {
  EditBirthdayPickerModel({
    required this.minYear,
    required this.maxYear,
    this.selectYear = 1949,
    this.selectMonth = 10,
    this.selectDay = 1,
  })  : days = [],
        pickerMonths = [];

  final int minYear;
  final int maxYear;

  int selectYear;
  int selectMonth;
  int selectDay;

  late List<int> years;
  final List<int> pickerMonths;
  final List<int> days;

  late final FixedExtentScrollController yearScrollController;
  late final FixedExtentScrollController monthScrollController;
  late final FixedExtentScrollController dayScrollController;
}
