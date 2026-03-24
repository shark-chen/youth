import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../base/base_controller.dart';
import '../../../network/downloader/downloader.dart';
import 'model/upgrade_config.dart';
import 'upgrade_tool.dart';

/// 安卓才会用到
class DownloadApk {
  Future downloadInstallApk({
    void Function(int, int, {StreamSpeedAssist speedAssist})? onReceiveProgress,
    VoidCallback? onError,
    required UpgradeAndroidConfig config,
  }) async {
    try {
      /// ✅ App 专属外部目录（不需要任何存储权限）
      final directory =
          await getExternalStorageDirectories(type: StorageDirectory.downloads);
      if (directory == null || Lists.isEmpty(directory)) {
        onError?.call();
        return;
      }
      final localPath = directory.first.path;
      final savePath = "$localPath/${config.downloadFileName}";
      final tempPath = "$savePath.temp";
      final apkFile = File(savePath);
      final tempFile = File(tempPath);

      /// 已存在，直接安装
      if (await apkFile.exists()) {
        Get.back();
        await _openApk(savePath, config, onError);
        return;
      }

      /// 开始下载
      await Downloader.streamDownload(
        url: config.downloadUrl!,
        savePath: tempPath,
        onReceiveProgress: onReceiveProgress,
        done: () async {
          /// 覆盖旧文件（更安全）
          if (await apkFile.exists()) {
            await apkFile.delete();
          }
          await tempFile.rename(savePath);
          Get.back();
          await _openApk(savePath, config, onError);
        },
        failed: (error) async => onError?.call(),
      );
    } catch (e, _) {
      onError?.call();
    }
  }

  /// 安卓APK
  Future<void> _openApk(
    String path,
    UpgradeAndroidConfig config,
    VoidCallback? onError,
  ) async {
    try {
      final result = await OpenFile.open(
        path,
        type: "application/vnd.android.package-archive",
        linuxByProcess: true,
      );
      if (result.type != ResultType.done) {
        await _showPermissionToast(
          LocaleKeys.FailedPleaseOfficialDownload.tr,
          () async {
            await launchUrlString(
              config.downloadUrl!,
              mode: LaunchMode.externalApplication,
            );
          },
        );
      }
    } catch (e, _) {
      onError?.call();
    }
  }

  /// 提示用户无文件访问权限，请前往设置
  Future _showPermissionToast(String title, VoidCallback? gotoCallback) async {
    List<DialogAction> list = [];
    if (UpgradeTool.versionInfo?.upgradeType != 2) {
      list.add(
        DialogAction(text: LocaleKeys.Cancel.tr, color: "#000000"),
      );
    }
    list.add(
      DialogAction(
        text: LocaleKeys.Confirm.tr,
        color: "#ff0000",
        onPressed: () {
          UpgradeTool.checkUpgrade();
          gotoCallback?.call();
        },
      ),
    );
    await showCustomAlert(
        DialogMessageModel(title: title, titleFontSize: 14, actions: list));
  }
}
