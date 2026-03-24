import 'package:flutter/material.dart';
import '../../../../network/downloader/stream_speed_assist.dart';
import '../../../../utils/utils/model_utils.dart';
import '../download_apk.dart';
import '../view/upgrade_view.dart';

class UpgradeAndroidConfig {
  // you want to download url.
  String? downloadUrl;

  // you want to download file name
  String? downloadFileName;

  DownloadApk downloadApk = DownloadApk();

  // upgrade form download
  Future<bool> upgradeFromDownload({
    void Function(int, int, {StreamSpeedAssist speedAssist})? onReceiveProgress,
    VoidCallback? onError,
  }) async {
    await downloadApk.downloadInstallApk(
      onReceiveProgress: onReceiveProgress,
      config: this,
      onError: onError,
    );
    return false;
  }
}

class UpgradeIOSConfig {
  // app store id
  String? appId;
}

class UpgradeConfig {
  late UpgradeAndroidConfig androidInfo;

  late UpgradeIOSConfig iosInfo;

  // force upgrade?
  bool? isForce;

  // upgrade from background?
  bool? isBackground;

  // upgrade title
  String? title;

  // upgrade content
  String? content;

  // new version name
  String? newVersion;

  // new version code
  int? newVersionCode;

  Future<dynamic> showNormalDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => UpgradeDialog(info: this));
  }
}

class UpdateVersionInfo {
  // true, false 是否需要升级.
  bool? needUpgrade = false;

  /// 1：弹窗更新 2：强制更新，3：不提示更新
  int? upgradeType = 3;

  // 升级提示内容, 通过\n完成换行
  String? content;

  // 当前线上最新版本号
  String? version;

  // 当前线上最新build号
  String? build;

  // APP下载地址
  String? url;

  UpdateVersionInfo();

  UpdateVersionInfo.map(dynamic json) {
    content = ModelUtils.convert<String>(json['content']);
    if (content?.contains('<br />') == true) {
      content = content?.replaceAll(RegExp(r"<br />"), '');
    }
    version = ModelUtils.convert<String>(json['version']);
    build = ModelUtils.convert<String>(json['build']);
    url = ModelUtils.convert<String>(json['url']);
    needUpgrade = ModelUtils.convert<bool>(json['needUpgrade']);
    upgradeType = ModelUtils.convert<int>(json['upgradeType']);
  }
}
