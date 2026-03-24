import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot_callback/screenshot_callback.dart';
import 'package:youth/base/base_controller.dart';
import '../../network/net/entry/auxiliary/wechat.dart';
import '../../utils/authority/camera_authority.dart';
import 'package:crypto/crypto.dart';

/// FileName screenshot
///
/// @Author 谌文
/// @Date 2025/4/7 11:10
///
/// @Description 截图工具
class Screenshot {
  late ScreenshotCallback screenshotCallback;

  /// 初始化数据
  Future init() async {
    await initScreenshotCallback();
  }

  /// It must be created after permission is granted.
  Future initScreenshotCallback() async {
    bool permission = await CameraAuthority.requestCameraAuthority(
        tip: '截图发送到 - APP-测试环境接口数据群 需要访问相册权限');
    if (!permission) return;
    screenshotCallback = ScreenshotCallback();
    screenshotCallback.addListener(() async => await getLatestScreenshot());
  }

  /// 获取截图
  Future<void> getLatestScreenshot() async {
    final ImagePicker picker = ImagePicker();
    final XFile? screenshot =
        await picker.pickImage(source: ImageSource.gallery);
    if (screenshot != null) {
      print("获取到截图：${screenshot.path}");
      requestUploadFile(screenshot);
    }
  }

  /// 发送图片文件
  static Future requestUploadFile(XFile? screenshotFile) async {
    if (screenshotFile == null) return;

    /// 1. 读取图片内容为 bytes
    Uint8List bytes = await screenshotFile.readAsBytes();

    /// 2. 计算 MD5
    Digest md5Digest = md5.convert(bytes);
    String md5String = md5Digest.toString();

    /// 3. 转为 Base64 字符串
    String base64String = base64Encode(bytes);
    EasyLoading.show();
    var response = await Net.value<Wechat>().requestSendScreenshot(
      base64: base64String,
      md5: md5String,
    );
    if (response.response?.data['errcode'] == 0) {
      EasyLoading.showToast('已发送到《APP-测试环境接口数据群》，不在群里可找谌文加群');
    } else {
      EasyLoading.showToast(response.response?.data['errmsg'] ?? response.msg);
    }
  }
}
