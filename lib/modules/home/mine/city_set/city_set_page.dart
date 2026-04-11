import 'package:youth/base/base_page.dart';
import '../birthday_select/view/bottom_double_btn_view.dart';
import 'city_set_controller.dart';
import 'view/input_location_view.dart';

/// FileName: city_set_page
///
/// @Author 谌文
/// @Date 2026/3/26 22:29
///
/// @Description 地区设置-page
class CitySetPage extends BasePage<CitySetController> {
  const CitySetPage({Key? key}) : super(key: key);

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
              '你在哪里',
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
            const SizedBox(height: 28),

            /// 选择城市
            InputLocationWidget(
              hint: '选择城市'.tr,
              // controller: controller.vm.value.accountController,
              // error: controller.vm.value.loginModel.accountError,
              // focusNode: controller.vm.value.accountFocusNode,
              inputTap: controller.pushRegionPickerPage,
              onFieldSubmittedTap: (value) {
                // FocusScope.of(context).requestFocus(
                //     controller.vm.value.passwordFocusNode);
                // controller.vm.value.showUsers.value = false;
                // controller.vm.refresh();
              },
            ),

            Expanded(child: Container()),

            /// 上一个，完成
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 45),
              child: BottomDoubleBtnWidget(
                leftTitle: '上一个',
                leftTap: controller.closePage,
                rightTitle: '完成',
                rightTap: controller.clickFinish,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
