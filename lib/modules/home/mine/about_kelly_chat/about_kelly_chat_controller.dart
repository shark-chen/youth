import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kellychat/base/base_controller.dart';
import 'dart:io';

/// FileName: about_kelly_chat_controller
///
/// @Author 谌文
/// @Date 2026/4/12 21:00
///
/// @Description 关于 KellyChat
class AboutKellyChatController extends BaseController {
  /// 展示用版本号，如 1.0.0
  final RxString appVersion = '1.0.0'.obs;

  /// App Store / 应用市场（按需替换为实际上架地址）
  static const String _iosStoreUrl = 'https://apps.apple.com/app/id0000000000';
  static const String _androidMarketUrl =
      'https://play.google.com/store/apps/details?id=com.example.youth';

  @override
  void onInit() {
    super.onInit();
    title = '关于 KellyChat';
    _loadPackageInfo();
  }

  Future<void> _loadPackageInfo() async {
    try {
      final info = await PackageInfo.fromPlatform();
      appVersion.value = info.version;
    } catch (_) {}
  }

  /// 用户协议（H5，与配置 type=1 对齐）
  Future<void> openUserAgreement() async {
    await Get.toNamed(Routes.userAgreementPage);
  }

  /// 隐私政策（H5，与配置 type=2 对齐）
  Future<void> openPrivacyPolicy() async {
    await Get.toNamed(Routes.privacyPolicyPage);
  }

  /// 未成年人信息保护规则（H5，与配置 type=2 对齐）
  Future<void> pushMessageProtection() async {
    await Get.toNamed(Routes.minorProtectionPage);
  }

  /// 版本更新：跳转应用商店
  Future<void> openAppStore() async {
    final uri = Uri.parse(
      Platform.isIOS ? _iosStoreUrl : _androidMarketUrl,
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      EasyLoading.showToast('无法打开应用商店');
    }
  }

  /// 反馈：进入反馈页
  Future pushFeedback() async {
    await Get.toNamed(Routes.feedbackPage);
  }
}
