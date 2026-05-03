import 'dart:ui' show ImageFilter;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kellychat/utils/utils/theme_color.dart';

import '../edit_birthday_sheet_vm.dart';
import 'edit_birthday_picker_cell.dart';

/// 全屏遮罩 + 底部生日滚轮（点遮罩、X、「确定」均以当前滚轮日期 [Navigator.pop]）
class EditBirthdaySheetDialog extends StatefulWidget {
  const EditBirthdaySheetDialog({
    super.key,
    required this.initialDate,
  });

  final DateTime initialDate;

  @override
  State<EditBirthdaySheetDialog> createState() => _EditBirthdaySheetDialogState();
}

class _EditBirthdaySheetDialogState extends State<EditBirthdaySheetDialog> {
  late final EditBirthdaySheetVM _vm;

  @override
  void initState() {
    super.initState();
    _vm = EditBirthdaySheetVM(initialDate: widget.initialDate);
    _vm.initPickers();
  }

  @override
  void dispose() {
    _vm.disposeScrollControllers();
    super.dispose();
  }

  void _popWithSelection() {
    Navigator.of(context).pop<DateTime>(_vm.selectedDate);
  }

  void _onWheelChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) return;
        _popWithSelection();
      },
      child: Material(
        type: MaterialType.transparency,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _popWithSelection,
                child: Container(color: Colors.black54),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _EditBirthdaySheetPanel(
                vm: _vm,
                onWheelChanged: _onWheelChanged,
                onClose: _popWithSelection,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EditBirthdaySheetPanel extends StatelessWidget {
  const _EditBirthdaySheetPanel({
    required this.vm,
    required this.onWheelChanged,
    required this.onClose,
  });

  final EditBirthdaySheetVM vm;
  final VoidCallback onWheelChanged;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final v = vm.pickerModel;
    final selectedYear = v.selectYear;
    final selectedMonth = v.selectMonth;
    final selectedDay = v.selectDay;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ThemeColor.textBlackColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 8, 12, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '修改生日',
                  style: TextStyle(
                    color: ThemeColor.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                onPressed: onClose,
                icon: Icon(
                  Icons.close,
                  color: ThemeColor.whiteColor.withOpacity(0.65),
                  size: 22,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 240,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: ThemeColor.blackColor.withOpacity(0.42),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: ThemeColor.whiteColor.withOpacity(0.08),
                          ),
                        ),
                        child: const SizedBox(height: 56, width: double.infinity),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CupertinoPicker(
                        scrollController: v.yearScrollController,
                        looping: false,
                        itemExtent: 56,
                        diameterRatio: 1.2,
                        squeeze: 1.0,
                        backgroundColor: Colors.transparent,
                        selectionOverlay: null,
                        onSelectedItemChanged: (i) {
                          vm.onYearChanged(i);
                          onWheelChanged();
                        },
                        children: v.years
                            .map(
                              (y) => EditBirthdayPickerCell(
                                text: '$y',
                                selected: y == selectedYear,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Expanded(
                      child: CupertinoPicker(
                        scrollController: v.monthScrollController,
                        looping: false,
                        itemExtent: 56,
                        diameterRatio: 1.2,
                        squeeze: 1.0,
                        backgroundColor: Colors.transparent,
                        selectionOverlay: null,
                        onSelectedItemChanged: (i) {
                          vm.onMonthChanged(i);
                          onWheelChanged();
                        },
                        children: v.pickerMonths
                            .map(
                              (m) => EditBirthdayPickerCell(
                                text: m < 10 ? '0$m' : '$m',
                                selected: m == selectedMonth,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Expanded(
                      child: CupertinoPicker(
                        scrollController: v.dayScrollController,
                        looping: false,
                        itemExtent: 56,
                        diameterRatio: 1.2,
                        squeeze: 1.0,
                        backgroundColor: Colors.transparent,
                        selectionOverlay: null,
                        onSelectedItemChanged: (i) {
                          vm.onDayChanged(i);
                          onWheelChanged();
                        },
                        children: v.days
                            .map(
                              (d) => EditBirthdayPickerCell(
                                text: d < 10 ? '0$d' : '$d',
                                selected: d == selectedDay,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: onClose,
            child: Container(
              decoration: BoxDecoration(
                color: ThemeColor.themeGreenColor,
                borderRadius: BorderRadius.circular(24),
              ),
              alignment: Alignment.center,
              height: 50,
              width: double.infinity,
              child: Text(
                '确定',
                style: TextStyle(
                  color: ThemeColor.themeColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
