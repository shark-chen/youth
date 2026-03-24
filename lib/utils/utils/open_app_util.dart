import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:get/get.dart';

/// FileName open_app_util
///
/// @Author 谌文
/// @Date 2025/2/18 13:51
///
/// @Description 打开其他应用APP
class OpenAppUtil {
  static Future<bool> open(
      String openLinks, {
        String? packageName,
        String? iosDownloadUrl,
        String? androidDownloadUrl,
      }) async {
    /// 已经安装，则直接打开APP || 打开商场失败，也试着打开APP，打不开APP，会自动打开浏览器的
    var result = await openInAppSafari(openLinks);
    if(result == false && GetPlatform.isAndroid) {
      result = await openApp(openLinks);
    }
    return result;
  }

  /// 在 App 内嵌 Safari (SFSafariViewController)
  static Future<bool> openInAppSafari(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  /// 打开APP && 安卓用
  static Future openApp(String openLinks) async {
    try {
      return await launchUrlString(openLinks,
          mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }
}