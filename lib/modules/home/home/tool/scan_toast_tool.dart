import '../../../../generated/locales.g.dart';
import '../../../../utils/extension/strings/strings.dart';
import 'package:get/get.dart';

/// FileName scan_toast_tool
///
/// @Author 谌文
/// @Date 2025/1/15 19:10
///
/// @Description 扫描提示工具
class ScanToastTool {
  static String toast(String scan, String msg) {
    String? toast;

    /// 非扫描发货提示
    if (Strings.isEmpty(scan)) {
      toast = msg;
    } else if (msg.contains(scan) == true) {
      /// 扫描提示，后台有错误有包含扫描内容提示时
      toast = '${LocaleKeys.CurrentScan.tr}: ${msg}';
    } else {
      /// 扫描提示，后台有错误没有包含扫描内容提示时
      toast = '${LocaleKeys.CurrentScan.tr}:【${scan}】\n${msg}';
    }
    return toast;
  }
}
