import 'package:youth/base/base_controller.dart';
import 'package:dio/dio.dart' as Api;
import '../../net/entry/auxiliary/wechat.dart';
import '../config/report_config.dart';
import '../report_util.dart';

/// FileName wechat_report
///
/// @Author 谌文
/// @Date 2024/8/5 16:28
///
/// @Description 企业微信上报
String record = '';

class WechatReport {
  /// 发送日志
  static Future requestReport(String msg, {bool? record = false}) async {
    try {
      if (!whiteList.contains(UserCenter().user?.phone)) return;
      await Net.value<Wechat>().requestSendText(msg: msg);
      if (record == true) {
        ReportUtil().record(msg, ping: true);
      }
    } catch (_) {}
  }

  /// 请求上报日志文件
  static Future requestReportFile() async {
    final file = await ReportConfig.getReportFile();
    final formData = Api.FormData.fromMap({
      'media': await Api.MultipartFile.fromFile(file.path,
          filename: 'BigSeller_log_${UserCenter().user?.phone}.txt'),
    });
    if (!file.existsSync()) {
      return EasyLoading.showToast('no data upload');
    }
    EasyLoading.show(status: LocaleKeys.Uploading.tr);
    var response =
        await Net.value<Wechat>().requestUploadMedia(data: formData);
    if (Strings.isNotEmpty(response.response?.data['media_id'])) {
      await requestUploadFile(response.response?.data['media_id'] ?? '');
    } else {
      EasyLoading.showToast(response.response?.data['errmsg'] ?? response.msg);
    }
  }

  /// 发送文件
  static Future requestUploadFile(String mediaId) async {
    var response =
        await Net.value<Wechat>().requestUploadFile(mediaId: mediaId);
    if (response.response?.data['errcode'] == 0) {
      await EasyLoading.showToast('success');
      final file = await ReportConfig.getReportFile();
      await file.writeAsString('', flush: true);
    } else {
      EasyLoading.showToast(response.response?.data['errmsg'] ?? response.msg);
    }
  }
}
