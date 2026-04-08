import 'package:youth/base/base_page.dart';
import 'package:flutter/cupertino.dart';
import 'birthday_select_controller.dart';
import 'view/birthday_picker_cell.dart';
import 'view/bottom_double_btn_view.dart';

/// FileName: birthday_select_page
///
/// @Author 谌文
/// @Date 2026/3/26 16:30
///
/// @Description 生日选择-page
class BirthdaySelectPage extends BasePage<BirthdaySelectController> {
  const BirthdaySelectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeColor.themeColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 70),
            Text(
              '选择生日',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '完善性别、生日、地区信息后，即可开始使用',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.6),
              ),
            ),
            Expanded(
              child: Center(
                child: SizedBox(
                  height: 240,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 56,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      Obx(() {
                        final v = controller.vm.value;
                        final selectedYear = v.pickerModel.selectYear;
                        final selectedMonth = v.pickerModel.selectMonth;
                        final selectedDay = v. pickerModel.selectDay;

                        return Row(
                          children: [
                            Expanded(
                              child: CupertinoPicker(
                                scrollController: v.pickerModel.yearScrollController,
                                looping: false,
                                itemExtent: 56,
                                diameterRatio: 1.2,
                                squeeze: 1.0,
                                backgroundColor: Colors.transparent,
                                selectionOverlay: null,
                                onSelectedItemChanged: controller.onYearChanged,
                                children: v.pickerModel.years
                                    .map(
                                      (y) => BirthdayPickerCell(
                                        text: '$y',
                                        selected: y == selectedYear,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            Expanded(
                              child: CupertinoPicker(
                                scrollController: v.pickerModel.monthScrollController,
                                looping: false,
                                itemExtent: 56,
                                diameterRatio: 1.2,
                                squeeze: 1.0,
                                backgroundColor: Colors.transparent,
                                selectionOverlay: null,
                                onSelectedItemChanged:
                                    controller.onMonthChanged,
                                children: v.pickerModel.pickerMonths
                                    .map((m) => BirthdayPickerCell(
                                          text: m < 10 ? '0$m' : '$m',
                                          selected: m == selectedMonth,
                                        ))
                                    .toList(),
                              ),
                            ),
                            Expanded(
                              child: CupertinoPicker(
                                scrollController: v.pickerModel.dayScrollController,
                                looping: false,
                                itemExtent: 56,
                                diameterRatio: 1.2,
                                squeeze: 1.0,
                                backgroundColor: Colors.transparent,
                                selectionOverlay: null,
                                onSelectedItemChanged: controller.onDayChanged,
                                children: v.pickerModel.days
                                    .map((d) => BirthdayPickerCell(
                                          text: d < 10 ? '0$d' : '$d',
                                          selected: d == selectedDay,
                                        ))
                                    .toList(),
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),

            /// 上一个 下一个
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 45),
              child: BottomDoubleBtnWidget(
                leftTitle: '上一个',
                leftTap: controller.closePage,
                rightTitle: '下一个',
                rightTap: controller.updateUserInfo,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
