import 'package:flutter/widgets.dart';

/// FileName: birthday_picker_model
///
/// @Author 谌文
/// @Date 2026/4/7 22:59
///
/// @Description 生日滚轮纯数据（仅属性）
class BirthdayPickerModel {
  BirthdayPickerModel({
    required this.minYear,
    required this.maxYear,
    this.selectYear = 1949,
    this.selectMonth = 10,
    this.selectDay = 1,
  })  : days = [],
        pickerMonths = [];

  /// 最小可选择的年份
  final int minYear;

  /// 最大可选择的年份
  final int maxYear;

  /// 选中的年月日
  int selectYear;
  int selectMonth;
  int selectDay;

  /// 年月日数据数组
  late List<int> years;
  final List<int> pickerMonths;
  final List<int> days;

  late final FixedExtentScrollController yearScrollController;
  late final FixedExtentScrollController monthScrollController;
  late final FixedExtentScrollController dayScrollController;
}
