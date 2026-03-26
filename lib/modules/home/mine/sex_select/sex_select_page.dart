import 'dart:ui';
import 'package:youth/base/base_controller.dart';
import 'package:youth/base/base_page.dart';
import 'sex_select_controller.dart';

/// FileName: sex_select_page
///
/// @Author 谌文
/// @Date 2026/3/25 23:51
///
/// @Description 性别选择-页面-page
class SexSelectPage extends BasePage<SexSelectController> {
  const SexSelectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.themeColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 70 + topPadding),
          Text(
            '选择性别',
            style: TextStyles(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: ThemeColor.whiteColor,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '完善性别、生日、地区信息后，即可开始使用',
            style: TextStyles(
              color: ThemeColor.whiteColor.withOpacity(0.6),
            ),
          ),
          SizedBox(height: 60),

          /// 男
          Container(
            height: 120,
            margin: EdgeInsets.only(left: 45, right: 45),
            decoration: BoxDecoration(
              color: ThemeColor.poolBlueColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '男',
                  style: TextStyles(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: ThemeColor.textBlackColor,
                  ),
                ),
                Icon(Icons.nat),
              ],
            ),
          ),
          SizedBox(height: 16),

          /// 女
          Container(
            height: 120,
            margin: EdgeInsets.only(left: 45, right: 45),
            decoration: BoxDecoration(
              color: ThemeColor.inputBgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.nat),
                Text(
                  '女',
                  style: TextStyles(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: ThemeColor.whiteColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Container()),
          GestureDetector(
            onTap: controller.pushBirthdaySelectPage,
            child: Container(
              height: 48,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 45, right: 45),
              decoration: BoxDecoration(
                color: ThemeColor.themeGreenColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                '继续',
                style: TextStyles(
                  color: ThemeColor.themeBlackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: 79),
        ],
      ),
    );
  }
}
