import 'dart:ui';
import 'package:youth/base/base_bindings.dart';
import 'package:youth/base/base_controller.dart';

import '../../../base/base_page.dart';
import 'view/input_phone_mail_view.dart';
import '../view/login_button.dart';
import 'login_controller.dart';
import 'view/input_verify_code_view.dart';
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
        resizeToAvoidBottomInset: true,
        body: Obx(
          () => SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 24.0, right: 24, top: 104),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '登录',
                              style: TextStyles(
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                                color: ThemeColor.whiteColor,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '未注册的手机号登录成功后将自动注册',
                              style: TextStyles(
                                color: ThemeColor.whiteColor.withOpacity(0.6),
                              ),
                            ),
                            SizedBox(height: 32),

                            /// 手机号输入框
                            InputPhoneMailWidget(
                              hint: '请输入手机号'.tr,
                              controller: controller.vm.value.accountController,
                              error:
                                  controller.vm.value.loginModel.accountError,
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
                            SizedBox(height: 12),

                            /// 输入+验证码
                            InputVerifyCodeWidget(
                              hint: LocaleKeys.VerifyCodeTip.tr,
                              controller:
                                  controller.vm.value.verifyCodeController,
                              focusNode:
                                  controller.vm.value.verifyCodeFocusNode,
                              verifyCode:
                                  controller.vm.value.loginModel.verifyImage,
                              error: controller
                                  .vm.value.loginModel.verifyCodeError,
                              onTap: controller.requestVerifyCode,
                            ),
                            SizedBox(height: 40),

                            LoginButton(
                              title: '登录'.tr,
                              onTap: controller.requestLogin,
                            ),
                            const SizedBox(height: 16),

                            ///  隐私协议view
                            PrivacyProtocolWidget(
                              selectTap: controller.checkReadProtocol,
                              onTap: controller.pushPrivacyAgreement,
                              selected:
                                  controller.vm.value.loginModel.agreeProtocol,
                            ),

                            Spacer(),

                            /// 背景图
                            Image.asset(
                              "assets/image/common/login_bg@3x.png",
                              width: screenWidth,
                              height: 141,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
