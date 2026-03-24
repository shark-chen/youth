import 'dart:convert';
import '../../../../base/base_vm.dart';
import '../../../../utils/utils/aes_cbc_util.dart';
import '../model/login_model.dart';
import 'login_phone_vm.dart';
export 'login_phone_vm.dart';

/// FileName login_vm
///
/// @Author 谌文
/// @Date 2024/7/9 15:54
///
/// @Description 登录view_model
class LoginVM extends BaseVM {
  LoginModel loginModel = LoginModel();

  /// 是否展示区号
  bool showArea = false;

  RxBool showUsers = false.obs;

  final FocusNode accountFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode verifyCodeFocusNode = FocusNode();

  final accountController = TextEditingController();
  final passwordController = TextEditingController();
  final verifyCodeController = TextEditingController();

  void onInit() {
    super.onInit();
    addListener();


  }

  /// 输入监听
  void addListener() {
    /// 账号信息输入时校验
    accountController
        .addListener(() => loginModel.account = accountController.text);

    /// 密码校验
    passwordController.addListener(() {
      loginModel.password = passwordController.text;
      if (Strings.isEmpty(loginModel.passwordError)) return;
      loginModel.passwordError = Strings.isEmpty(loginModel.password)
          ? LocaleKeys.passwordCannotEmpty.tr
          : '';
      refresh?.call();
    });

    /// 验证码校验
    verifyCodeController.addListener(() {
      loginModel.verifyCode = verifyCodeController.text;
      if (Strings.isEmpty(loginModel.verifyCodeError)) return;
      loginModel.verifyCodeError = Strings.isEmpty(loginModel.verifyCode)
          ? LocaleKeys.graphicVerificationCodeCannotEmpty.tr
          : '';
      refresh?.call();
    });
  }

  /// 添加账号输入聚焦离焦的监听
  void addFocusNodeListener({VoidCallback? checkPhoneCall}) {
    accountFocusNode.addListener(() {
      if (accountFocusNode.hasFocus) {
        loginModel.accountError = '';
        showArea = false;
      } else {
        var isNumeric = accountController.text.isNumeric;
        showArea = isNumeric;
        if (isNumeric) {
          checkPhoneCall?.call();
        } else {
          loginModel.accountError = Strings.isEmpty(loginModel.account)
              ? LocaleKeys.mailPhoneCannotEmpty.tr
              : (!loginModel.account.contains("@")
                  ? LocaleKeys.EmailValid.tr
                  : '');
        }
      }
      refresh?.call();
    });
  }

  /// 获取登录模型数据
  LoginModel getLoginInfo() {
    if (Strings.isNotEmpty(loginModel.password)) {
      loginModel.encryptPassword = AesCbcUtil.encrypt(loginModel.password);
    }
    return loginModel;
  }

  /// 配置验证码数据
  void configVerifyCodeData(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      var base64Image = json['base64Image'];
      loginModel.accessCode = json['accessCode'];
      loginModel.verifyImage =
          Base64Decoder().convert(base64Image.split(",")[1]);
    }
  }

  /// 校验登录
  bool checkLogin() {
    var result = true;
    if (Strings.isEmpty(loginModel.account)) {
      loginModel.accountError = LocaleKeys.mailPhoneCannotEmpty.tr;
      result = false;
    }

    if (showArea == false &&
        Strings.isNotEmpty(loginModel.account) &&
        !loginModel.account.contains("@")) {
      loginModel.accountError = LocaleKeys.EmailValid.tr;
      result = false;
    }

    if (Strings.isEmpty(loginModel.password)) {
      loginModel.passwordError = LocaleKeys.passwordCannotEmpty.tr;
      result = false;
    }

    if (Strings.isEmpty(loginModel.verifyCode)) {
      loginModel.verifyCodeError =
          LocaleKeys.graphicVerificationCodeCannotEmpty.tr;
      result = false;
    }
    return result;
  }

  /// 苹果审核校验
  Future<bool> appleCheck() async {
    if (GetPlatform.isIOS &&
        UserCenter().unsubscribed &&
        "xieling@bigseller.com" == accountController.value.text) {
      /// 注销账户后，10分钟内不能登录
      final limitTime =
          await Stores().get<int>('unsubscribed_limit_time', userLat: false) ??
              0;
      if ((DateTime.now().millisecondsSinceEpoch / 1000).round() - limitTime <
          600) {
        EasyLoading.showToast(LocaleKeys.AccountCanceled.tr);
        return false;
      }
    }
    return true;
  }

  /// 请求参数
  Future<Map<String, dynamic>> toJson() async {
    return {}..addAll(loginModel.toJson());
  }
}


