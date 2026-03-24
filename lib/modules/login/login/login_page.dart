import 'dart:ui';
import 'package:youth/tripartite_library/uuid/udid_util.dart';
import '../../../base/base_page.dart';
import 'view/account_check_box_view.dart';
import 'view/input_phone_mail_view.dart';
import '../view/login_button.dart';
import 'login_controller.dart';
import 'view/accounts_view.dart';
import 'view/input_password_view.dart';
import 'view/input_verify_code_view.dart';
import 'view/login_bottom_view.dart';
import 'view/privacy_protocol_view.dart';

/// FileName login_page
///
/// @Author 谌文
/// @Date 2024/7/8 14:34
///
/// @Description 登录页面
class LoginPage extends BasePage<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.hideKeyboard();
        controller.vm.value.showUsers.value = false;
        controller.vm.refresh();
      },
      child: Scaffold(
        backgroundColor: ThemeColor.themeColor,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQueryData.fromWindow(window).padding.top),
          child: const SafeArea(top: true, child: Offstage()),
        ),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 24.0, right: 24, top: 82),
            child: Obx(
              () => Stack(
                children: [
                  Column(
                    children: [
                      Text(
                        '手机号登录',
                        style: TextStyles(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: ThemeColor.whiteColor,
                        ),
                      ),

                      SizedBox(height: 24),

                      Text(
                        '未注册的手机号登录成功后将自动注册',
                        style: TextStyles(
                          color: ThemeColor.personalBackColor,
                        ),
                      ),

                      SizedBox(height: 24),

                      /// 手机号输入框
                      Obx(
                        () => InputPhoneMailWidget(
                          title: '',
                          hint: '请输入手机号'.tr,
                          showArea: controller.vm.value.showArea,
                          controller: controller.vm.value.accountController,
                          error: controller.vm.value.loginModel.accountError,
                          focusNode: controller.vm.value.accountFocusNode,
                          inputTap: () {
                            controller.vm.value.showUsers.value = true;
                            controller.vm.value.showUsers.refresh();
                          },
                          onFieldSubmittedTap: (value) {
                            FocusScope.of(context).requestFocus(
                                controller.vm.value.passwordFocusNode);
                            controller.vm.value.showUsers.value = false;
                            controller.vm.refresh();
                          },
                        ),
                      ),

                      /// 输入+验证码
                      InputVerifyCodeWidget(
                        hint: LocaleKeys.VerifyCodeTip.tr,
                        controller: controller.vm.value.verifyCodeController,
                        focusNode: controller.vm.value.verifyCodeFocusNode,
                        verifyCode: controller.vm.value.loginModel.verifyImage,
                        error: controller.vm.value.loginModel.verifyCodeError,
                        onTap: controller.requestVerifyCode,
                      ),
                      SizedBox(height: 10),

                      LoginButton(
                        title: '登录并验证'.tr,
                        onTap: controller.requestLogin,
                      ),
                      const SizedBox(height: 16),

                      ///  隐私协议view
                      PrivacyProtocolWidget(
                        selectTap: controller.checkReadProtocol,
                        onTap: controller.pushPrivacyAgreement,
                        selected: controller.vm.value.loginModel.agreeProtocol,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
