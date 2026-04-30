import 'dart:async';
import '../../../../base/base_controller.dart';
import '../login_controller.dart';
import 'package:kellychat/config/environment_config/app_config.dart';
import '../view/privacy_protocol_bottom_sheet.dart';

/// FileName: login_route_controller
///
/// @Author 谌文
/// @Date 2026/3/4 16:53
///
/// @Description 登录控制器-路由-controller
extension LoginRouteController on LoginController {
  /// 登录页 - 打开用户协议
  Future<void> openUserAgreementFromLogin() async {
    await Get.toNamed(Routes.userAgreementPage);
  }

  /// 登录页 - 打开隐私政策
  Future<void> openPrivacyPolicyFromLogin() async {
    await Get.toNamed(Routes.privacyPolicyPage);
  }

  /// 登录页 - 打开未成年人个人信息保护规则
  Future<void> openMinorProtectionFromLogin() async {
    await Get.toNamed(Routes.minorProtectionPage);
  }

  /// MARK - PUSH
  /// push-打开意思协议弹框
  Future pushPrivacyPop() async {
    final result = await _showPrivacyBottomSheet();
    return result;
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

  /// push-打开意思协议弹框
  Future<bool> _showPrivacyBottomSheet() async {
    final completer = Completer<bool>();
    await Get.bottomSheet(
      PrivacyProtocolBottomSheet(
        onTapUserAgreement: openUserAgreementFromLogin,
        onTapPrivacyPolicy: openPrivacyPolicyFromLogin,
        onTapMinorProtection: openMinorProtectionFromLogin,
        onDisagree: () {
          if (!completer.isCompleted) completer.complete(false);
          Get.back();
        },
        onAgree: () {
          vm.value.loginModel.agreeProtocol = true;
          vm.refresh();
          if (!completer.isCompleted) completer.complete(true);
          Get.back();
        },
      ),
      enableDrag: false,
      backgroundColor: Colors.transparent,
    );
    if (!completer.isCompleted) {
      completer.complete(false);
    }
    return completer.future;
  }
}
