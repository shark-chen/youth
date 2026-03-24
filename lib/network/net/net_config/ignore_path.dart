import '../../../config/environment_config/app_config.dart';

/// FileName ignore_path
///
/// @Author 谌文
/// @Date 2024/5/29 14:25
///
/// @Description 重新登录忽略的接口
final Set<String> ignoreUrl = {
  AppConfig.loginApiUrl,
  AppConfig.registerApiUrl,
  AppConfig.getRegisterOneStepValidateUrl,
  AppConfig.getSendRegPhoneCodeUrl,
  AppConfig.genVerifyCodeApiUrl,
  AppConfig.sendVerifyCodeApiUrl,
  AppConfig.changeLang,
  AppConfig.checkLogin,
  AppConfig.loginOut,
  AppConfig.isVipAndMaster,
  AppConfig.getUpdateUserSettingUrl,
  AppConfig.getUpdateVersionInfoUrl,
  AppConfig.getAppNewVersion,
  AppConfig.registerMessage,
  AppConfig.getSendErrorUrl,
  AppConfig.getUserRightsUrl,
  AppConfig.phoneCodeAreaRegexUrl,
  AppConfig.getPhoneCodeAreaAndRegexUrl,
  AppConfig.getRegisterUrl,
};
