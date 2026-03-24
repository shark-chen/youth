import '../../../generated/locales.g.dart';
import 'package:get/get.dart';
import '../../../utils/extension/strings/strings.dart';

/// FileName load_utils
///
/// @Author 谌文
/// @Date 2024/4/8 16:40
///
/// @Description Toast字符串处理工具
class LoadUtils {
  static String toast(String toast, {String? scan}) {
    /// 需要在外面单独处理一下报错内容
    if (toast.contains('orderStatusIsNotProcessing') ||
        toast.contains('orderInspectionCompletedError')) {
      return toast;
    }

    if (toast.contains(scan ?? '-+')) {
      return toast;
    }
    if (Strings.isNotEmpty(scan)) {
      return '${LocaleKeys.CurrentScan.tr}:【$scan】\n$toast';
    }
    return toast;
  }
}
