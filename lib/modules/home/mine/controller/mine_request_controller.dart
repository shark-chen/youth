import 'dart:ui' as ui;
import 'package:youth/modules/functions/upgrade/model/upgrade_config.dart';
import 'package:youth/modules/functions/upgrade/upgrade_tool.dart';
import 'package:youth/modules/home/home/view/tabs.dart';
import 'package:youth/network/net/entry/user/user.dart';
import '../../home/home_controller.dart';
import '../mine_controller.dart';
import '../../../../base/base_controller.dart';

/// FileName: mine_request_controller
///
/// @Author 谌文
/// @Date 2026/1/22 15:12
///
/// @Description 我的页面请求
extension MineRequestController on MineController {
  /// request - 获取服务端最新版本号
  Future requestNewVersion() async {
    UpdateVersionInfo? versionInfo = await UpgradeTool.getVersionInfo();
    if (versionInfo?.needUpgrade == true) {
      /// 配置是否有新版本
      vm.value.configIsHaveNewVersion(versionInfo?.needUpgrade ?? false);
      vm.refresh();
    }
  }

  /// request -请求检查升级
  Future requestCheckUpgrade() async {
    EasyLoading.show();
    UpdateVersionInfo? versionInfo =
        await UpgradeTool.checkUpgrade(clickUpdate: true);
    EasyLoading.dismiss();
    if (versionInfo?.needUpgrade == false) {
      EasyLoading.showToast(LocaleKeys.CurrentIsNewVersion.tr);
    }
    isNewVersion.value = versionInfo?.needUpgrade ?? false;
  }

  /// request -请求退出登录
  Future requestLoginOut() async {
    await showCustomAlert(
        DialogMessageModel(title: LocaleKeys.LoginOutConfirm.tr, actions: [
      DialogAction(text: LocaleKeys.Cancel.tr, color: "#000000"),
      DialogAction(
          text: LocaleKeys.Confirm.tr,
          color: "#ff0000",
          onPressed: () async {
            /// 个人中心数据清空
            EasyLoading.show();
            await UserCenter().clear();
            EventBusManager().fire(AuthTabs.logOut);
            await Get.offAllNamed(Routes.login);
          })
    ]));
  }

  /// request -注销账户
  Future requestUnsubscribeAccount() async {
    await showCustomAlert(
      DialogMessageModel(title: LocaleKeys.SureCancelAccount.tr, actions: [
        DialogAction(text: LocaleKeys.Cancel.tr, color: "#000000"),
        DialogAction(
          text: LocaleKeys.Confirm.tr,
          color: "#ff0000",
          onPressed: () async {
            UserCenter().unsubscribed = true;

            /// 注销账户后，10分钟内不能登录
            await Stores().put<int>('unsubscribed_limit_time',
                (DateTime.now().millisecondsSinceEpoch / 1000).round(),
                userLat: false);

            /// 个人中心数据清空
            await UserCenter().clear();
            await Get.offAllNamed(Routes.login);
          },
        )
      ]),
    );
  }


}
