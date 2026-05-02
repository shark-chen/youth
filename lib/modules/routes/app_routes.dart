part of 'app_pages.dart';

/// 路由来源方式- 主要是机型的哈，不可加业务哈
enum RouteFrom {
  /// 手机
  iPhone,

  /// iPad
  iPad,
}

abstract class Routes {
  static const splash = '/';
  static const login = "/login";
  static const register = "/register";
  static const homePage = "/homePage";
  static const cameraWebView = "/cameraWebView";
  static const webView = "/webview";
  static const serviceAlterPage = "/serviceAlterPage";
  static const networkLookPage = "/networkLookPage";
  static const backCameraWebView = "/backCameraWebView";
  static const backWebView = "/backWebview";
  static const sexInfoPage = '/sexInfoPage';
  static const brithInfoPage = '/brithInfoPage';
  static const regionInfoPage = '/regionInfoPage';
  static const doingListPage = '/doingListPage';
  static const inviteRecordPage = '/inviteRecordPage';
  static const userInfoPage = '/userInfoPage';
  static const beatRecordPage = '/beatRecordPage';
  static const chatPage = '/chatPage';
  static const sexSelectPage = '/sexSelectPage';
  static const birthdaySelectPage = '/birthdaySelectPage';
  static const citySelectPage = '/citySelectPage';
  static const citySetPage = '/citySetPage';
  static const minePage = '/minePage';
  static const aboutKellyChatPage = '/aboutKellyChatPage';
  static const userAgreementPage = '/userAgreementPage';
  static const privacyPolicyPage = '/privacyPolicyPage';
  static const minorProtectionPage = '/minorProtectionPage';
  static const feedbackPage = '/feedbackPage';
  static const editMineInfoPage = '/editMineInfoPage';
  static const editPrivateMessagePage = '/editPrivateMessagePage';
  static const reportPage = '/reportPage';
  static const reportSubmitPage = '/reportSubmitPage';
  static const doingPage = '/doingPage';
}
