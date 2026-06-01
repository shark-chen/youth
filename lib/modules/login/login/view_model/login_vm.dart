import 'dart:async';
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kellychat/utils/stores/stores.dart';
import '../../../../base/base_vm.dart';
import '../../../../utils/utils/aes_cbc_util.dart';
import '../model/login_model.dart';
export 'login_param_vm.dart';
export 'login_ui_vm.dart';

/// FileName login_vm
///
/// @Author 谌文
/// @Date 2024/7/9 15:54
///
/// @Description 登录view_model
class LoginVM extends BaseVM {
  LoginModel loginModel = LoginModel();

  /// 手机号
  final phoneController = TextEditingController();
  final FocusNode phoneFocusNode = FocusNode();

  /// 验证码
  final verifyCodeController = TextEditingController();
  final FocusNode verifyCodeFocusNode = FocusNode();

  /// 倒计时
  int seconds = -1;
  Timer? timer;

  void onInit() {
    super.onInit();
    addListener();
  }

  /// 验证码倒计时
  void startSmsCountDown() {
    seconds = 60;
    refresh?.call();
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds <= 0) {
        seconds = 0;
        t.cancel();
      } else {
        seconds--;
      }
      refresh?.call();
    });
  }

  /// 输入监听
  void addListener() {
    /// 账号信息输入时校验
    phoneController
        .addListener(() => loginModel.account = phoneController.text);

    /// 验证码校验
    verifyCodeController.addListener(() {
      loginModel.verifyCode = verifyCodeController.text;
      if (Strings.isEmpty(loginModel.verifyCodeError)) return;
      loginModel.verifyCodeError =
          Strings.isEmpty(loginModel.verifyCode) ? '图形验证码不能为空' : '';
      refresh?.call();
    });
  }

  /// 添加账号输入聚焦离焦的监听
  void addFocusNodeListener({VoidCallback? checkPhoneCall}) {
    phoneFocusNode.addListener(() {
      if (phoneFocusNode.hasFocus) {
        loginModel.accountError = '';
      } else {
        var isNumeric = phoneController.text.isNumeric;
        if (isNumeric) {
          checkPhoneCall?.call();
        } else {
          loginModel.accountError = Strings.isEmpty(loginModel.account)
              ? '手机号不能为空'
              : '';
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

  /// 苹果审核校验
  Future<bool> appleCheck() async {
    if (UserCenter().unsubscribed) {
      /// 注销账户后，10分钟内不能登录
      final limitTime =
          await Stores(userLat: false).get<int>('unsubscribed_limit_time') ?? 0;
      if ((DateTime.now().millisecondsSinceEpoch / 1000).round() - limitTime <
          600) {
        EasyLoading.showToast('该用户已被注销');
        return false;
      }
    }
    return true;
  }
}
