import 'package:flutter/gestures.dart';
import 'package:youth/config/environment_config/app_config.dart';
import '../../../../base/base_controller.dart';
import '../login_controller.dart';

/// FileName: login_route_controller
///
/// @Author 谌文
/// @Date 2026/3/4 16:53
///
/// @Description 登录控制器-路由-controller
extension LoginRouteController on LoginController {
  /// MARK - PUSH
  /// push-打开意思协议弹框
  Future pushPrivacyPop() async {
    var result = false;
    await pushDialogAlert(
      customContentWidget: Padding(
        padding: EdgeInsets.only(left: 12, right: 12, top: 15),
        child: RichText(
          text: TextSpan(
            text: LocaleKeys.ReadAndAgree.tr,
            style: TextStyle(
                fontSize: 16,
                color: ThemeColor.themeA2Color,
                fontWeight: FontWeight.w600),
            children: <TextSpan>[
              TextSpan(
                text: " ${'《用户协议》、《隐私政策》、《未成年人个人信息保护规则》'.tr}",
                style: const TextStyle(
                    fontSize: 16, color: ThemeColor.themeGreenColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = pushPrivacyAgreement,
              ),
            ],
          ),
        ),
      ),
      leftTitle: '不同意',
      rightTitle: '同意',
      rightTitleColor: ThemeColor.black6Color,
      rightTitleBgColor: ThemeColor.themeGreenColor,
      rightTap: () {
        vm.value.loginModel.agreeProtocol = true;
        result = true;
        Get.back();
        vm.refresh();
      },
    );
    return result;
  }

  /// push -跳转隐私协议
  Future pushPrivacyAgreement() async {
    await Get.toNamed(Routes.webView, parameters: {
      'url': AppConfig.aboutUrl,
      'title': LocaleKeys.privacyPolicy.tr,
      'showTitle': "true",
    });
  }

  /// push-性别选择-页面-page
  Future pushSexSelectPage() async {
    await Get.toNamed(Routes.sexSelectPage);
  }

  /// push-网络服务地址页面
  Future pushServiceAlterPage() async {
    if (environment == Environment.prod) return;
    await Get.toNamed(Routes.serviceAlterPage);
  }
}
