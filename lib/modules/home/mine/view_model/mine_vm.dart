import 'package:youth/base/base_vm.dart';
import 'package:youth/utils/extension/text_styles.dart';
import '../../../../config/environment_config/app_config.dart';
import '../model/mine_model.dart';

/// FileName mine_vm
///
/// @Author 谌文
/// @Date 2025/2/19 10:04
///
/// @Description 我的页面的VM
class MineVM extends BaseVM {
  /// 我的页面数据
  List<MineModel> rows = [];

  /// 登录过的账户
  List<BubbleModel> accounts = <BubbleModel>[];

  @override
  void onInit() async {
    super.onInit();
  }

  /// 创建我的页面的数据
  Future buildRows() async {
    rows.clear();

    /// 账号
    final accountRoute =
        UserCenter().masterAccount == true ? Routes.accountPage : null;
    rows.add(
      MineModel(
          title: LocaleKeys.loginID.tr,
          content: UserCenter().user?.currentLoginAccount ??
              (UserCenter().user?.account ?? ''),
          routeName: accountRoute,
          showArrow: Strings.isNotEmpty(accountRoute)),
    );

    /// 店铺授权
    rows.add(
      MineModel(title: LocaleKeys.Integrations.tr, routeName: Routes.shopAuth),
    );

    /// 切换语言
    rows.add(
      MineModel(
        title: LocaleKeys.multilingual.tr,
        routeName: Routes.languagePage,
      ),
    );

    /// 设置
    rows.add(
      MineModel(
        title: LocaleKeys.Setting.tr,
        routeName: Routes.settings,
        isSection: true,
      ),
    );

    /// 隐私协议
    rows.add(
      MineModel(
          title: LocaleKeys.privacyPolicy.tr,
          routeName: Routes.webView,
          routeParameter: {
            'title': LocaleKeys.privacyPolicy.tr,
            'url': AppConfig.aboutUrl,
            'showTitle': 'true'
          }),
    );

    /// 引用第三方SDK
    rows.add(
      MineModel(
          title: LocaleKeys.thirdPartySDK.tr,
          routeName: Routes.webView,
          routeParameter: {
            'title': LocaleKeys.thirdPartySDK.tr,
            'url': AppConfig.aboutUrl,
            'showTitle': 'true'
          }),
    );

    /// 联系我们
    rows.add(
      MineModel(
        title: LocaleKeys.contactUs.tr,
        routeName: Routes.contactWayPage,
      ),
    );

    /// 关于BigSeller
    rows.add(
      MineModel(
          title: LocaleKeys.aboutUs.tr,
          routeName: Routes.webView,
          routeParameter: {
            'title': LocaleKeys.aboutUs.tr,
            'url': AppConfig.aboutBigSellerUrl,
            'showTitle': 'true',
          }),
    );

    var version = '';

    /// 版本信息
    rows.add(
      MineModel(
        title: LocaleKeys.VersionInfo.tr,
        content: version,
        showArrow: false,
        isSection: true,
      ),
    );

    /// 注销用户- 只有在iOS设备 xieling@bigseller.com账号才展示
    rows.add(
      MineModel(
        middleContent: LocaleKeys.CancelAccount.tr,
        showArrow: false,
        notVisible: true,
      ),
    );

    /// 切换账号
    rows.add(
      MineModel(
        middleContent: LocaleKeys.switchAccount.tr,
        middleContentStyle: TextStyles(color: ThemeColor.blueBtnColor),
        showArrow: false,
        isSection: true,
      ),
    );

    /// 退出登录
    rows.add(
      MineModel(middleContent: LocaleKeys.LoginOut.tr, showArrow: false),
    );
    refresh?.call();
  }

  /// 配置是否有新版本
  void configIsHaveNewVersion(bool haveNew) {
    for (var value in rows) {
      if (value.title == LocaleKeys.VersionInfo.tr) {
        value.showRed = haveNew;
        return;
      }
    }
  }

  /// 配置用户信息
  Future configAccountInfo() async {
    if (Strings.isEmpty(UserCenter().user?.currentLoginAccount ??
        (UserCenter().user?.account ?? ''))) {
      await UserCenter().userInfo;
    }
    for (var value in rows) {
      if (value.title == LocaleKeys.loginID.tr) {
        value.content = UserCenter().user?.currentLoginAccount ??
            (UserCenter().user?.account ?? '');

        /// iOS设备+xieling@bigseller.com账号
        if (isIOS && value.content == "xieling@bigseller.com") {
          value.showArrow = false;
          value.routeName = null;
        }
      }

      /// 注销用户- 只有在iOS设备 xieling@bigseller.com账号才展示
      if (isIOS &&
          value.middleContent == LocaleKeys.CancelAccount.tr &&
          UserCenter().user?.account == "xieling@bigseller.com") {
        value.notVisible = false;
      }
    }
    refresh?.call();
  }

}
