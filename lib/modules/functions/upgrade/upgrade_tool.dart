import 'package:url_launcher/url_launcher_string.dart';
import 'package:youth/utils/stores/stores.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'model/upgrade_config.dart';
const String appId = "1672011515";
const String downloadUrl =
    "https://www.bigseller.com/api/v1/plugIn/getDownloadUrlByFileType.json?fileType=bigSeller-app";
const String upgradePackageName = "com.meiyunji.bigseller.app.bigseller_app";
const bool isGoogle = false;

/// 3天后
int afterTime = 3 * 24 * 60 * 60000;

class UpgradeTool {
  static UpdateVersionInfo? versionInfo;
  static bool requesting = false;

  /// 检查时候需要更新, clickUpdate: 我的页面点击更新
  static Future<UpdateVersionInfo?> checkUpgrade(
      {bool clickUpdate = false}) async {
    if (requesting) return versionInfo;
    requesting = true;
    var info = await getVersionInfo(needNewest: true);
    requesting = false;
    if (info == null || info.needUpgrade == false) return info;

    /// 我的页面点击更新
    if (clickUpdate == true) {
      if (GetPlatform.isIOS || isGoogle) {
        /// 跳转到商城
        UpgradeTool.openAppStore();
      } else {
        EasyLoading.dismiss();
        await _showUpgrade(info);
      }
    } else {
      /// APP启动自动获取更新
      bool updateFewDays = await UpgradeTool.updateAfterFewDays();
      if (info.upgradeType == 2 ||
          info.upgradeType == 1 && updateFewDays == true) {
        /// 1：弹窗更新提示后，三天内弹窗更新不在提示
        await _showUpgrade(info);
      }
    }
    return versionInfo;
  }

  /// 获取更新信息
  static Future<UpdateVersionInfo?> getVersionInfo(
      {bool needNewest = false}) async {
    if (needNewest == true || versionInfo == null) {
      // var response = await NetWork.getUpdateVersionInfo();
      // if (response.code == 0 && response.data != null) {
      //   versionInfo = UpdateVersionInfo.map(response.data);
      // }
    }
    return versionInfo;
  }

  /// 打开应用商店
  /// packageName iosId
  static Future openAppStore() async {
    try {
      if (GetPlatform.isIOS) {
        return await launchUrlString(
            "itms-apps://itunes.apple.com/app/id$appId");
      } else {
        return await launchUrlString(
            "https://play.google.com/store/apps/details?id=$upgradePackageName");
      }
    } catch (_) {}
  }

  /// 弹框升级
  static Future _showUpgrade(UpdateVersionInfo info) async {
    UpgradeConfig upgradeConfig = UpgradeConfig()
      ..content = info.content
      ..title = 'BigSeller'
      ..newVersion = info.version
      ..isForce = info.upgradeType == 2
      ..androidInfo = (UpgradeAndroidConfig()
        ..downloadUrl = info.url ?? downloadUrl
        ..downloadFileName = "BigSeller-${info.version}.apk")
      ..iosInfo = (UpgradeIOSConfig()..appId = appId);
    await upgradeConfig.showNormalDialog(Get.context!);
  }

  /// 弹框更新，弹过后，3天后再能弹第二次
  static Future<bool> updateAfterFewDays() async {
    int oldTime = await Stores().get<int>('updateAfterFewDays') ?? 0;
    var now = DateTime.now().millisecondsSinceEpoch;
    if ((now - oldTime) > afterTime) {
      return true;
    }
    return false;
  }

  static Future updateFewDays() async {
    var now = DateTime.now().millisecondsSinceEpoch;
    await Stores().put<int>('updateAfterFewDays', now);
  }
}
