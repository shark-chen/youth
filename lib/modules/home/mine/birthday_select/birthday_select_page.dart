import 'package:youth/base/base_page.dart';
import 'package:flutter/cupertino.dart';

import 'birthday_select_controller.dart';

/// FileName: birthday_select_page
///
/// @Author 谌文
/// @Date 2026/3/26 16:30
///
/// @Description 生日选择-page
class BirthdaySelectPage extends BasePage<BirthdaySelectController> {
  const BirthdaySelectPage({Key? key}) : super(key: key);

  Widget _pickerItem(String text, {required bool selected}) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color:
              selected ? ThemeColor.themeGreenColor : ThemeColor.themeA2Color,
        ),
      ),
    );
  }

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
                        final selectedYear = controller.year.value;
                        final selectedMonth = controller.month.value;
                        final selectedDay = controller.day.value;

                        return Row(
                          children: [
                            Expanded(
                              child: CupertinoPicker(
                                scrollController:
                                    controller.yearScrollController,
                                looping: true,
                                itemExtent: 56,
                                diameterRatio: 1.2,
                                squeeze: 1.0,
                                backgroundColor: Colors.transparent,
                                selectionOverlay: null,
                                onSelectedItemChanged: controller.onYearChanged,
                                children: controller.years
                                    .map((y) => _pickerItem(
                                          '$y',
                                          selected: y == selectedYear,
                                        ))
                                    .toList(),
                              ),
                            ),
                            Expanded(
                              child: CupertinoPicker(
                                scrollController:
                                    controller.monthScrollController,
                                looping: true,
                                itemExtent: 56,
                                diameterRatio: 1.2,
                                squeeze: 1.0,
                                backgroundColor: Colors.transparent,
                                selectionOverlay: null,
                                onSelectedItemChanged:
                                    controller.onMonthChanged,
                                children: controller.months
                                    .map((m) => _pickerItem(
                                          m < 10 ? '0$m' : '$m',
                                          selected: m == selectedMonth,
                                        ))
                                    .toList(),
                              ),
                            ),
                            Expanded(
                              child: CupertinoPicker(
                                scrollController:
                                    controller.dayScrollController,
                                looping: true,
                                itemExtent: 56,
                                diameterRatio: 1.2,
                                squeeze: 1.0,
                                backgroundColor: Colors.transparent,
                                selectionOverlay: null,
                                onSelectedItemChanged: controller.onDayChanged,
                                children: controller.days
                                    .map((d) => _pickerItem(
                                          d < 10 ? '0$d' : '$d',
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
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 45),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.12),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        onPressed: controller.closePage,
                        child: const Text(
                          '上一个',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeColor.themeGreenColor,
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        onPressed: controller.pushCitySetPage,
                        child: const Text(
                          '下一个',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
