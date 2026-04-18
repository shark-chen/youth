import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:youth/base/base_controller.dart';
import 'package:youth/network/net/entry/auxiliary/auxiliary.dart';

/// FileName: feedback_controller
///
/// @Author 谌文
/// @Date 2026/4/12 21:31
///
/// @Description 意见反馈（UI 稿）；提交接口待后端对接后接入 Net
class FeedbackController extends BaseController {
  static const int maxContentLength = 200;
  static const int maxImages = 3;

  /// 底部展示号码；复制到剪贴板为纯数字
  static const String servicePhoneDisplay = '135 4332 3545';
  static const String servicePhoneRaw = '13543323545';

  late final TextEditingController contentController;
  late final TextEditingController contactController;

  /// 已选本地图片路径
  final RxList<String> imagePaths = <String>[].obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    title = '反馈';
    contentController = TextEditingController();
    contactController = TextEditingController();
  }

  @override
  void onClose() {
    contentController.dispose();
    contactController.dispose();
    super.onClose();
  }

  bool get canAddImage => imagePaths.length < maxImages;

  Future<void> pickImage() async {
    if (!canAddImage) return;
    try {
      final x = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      if (x == null) return;
      imagePaths.add(x.path);
    } catch (_) {
      EasyLoading.showToast('选择图片失败');
    }
  }

  void removeImageAt(int index) {
    if (index < 0 || index >= imagePaths.length) return;
    imagePaths.removeAt(index);
  }

  Future<void> copyServicePhone() async {
    await Clipboard.setData(const ClipboardData(text: servicePhoneRaw));
    EasyLoading.showToast(LocaleKeys.copySuccessfully.tr);
  }

  Future<void> submit() async {
    final text = contentController.text.trim();
    if (text.isEmpty) {
      EasyLoading.showToast(LocaleKeys.pleaseEnter.tr);
      return;
    }
    if (requesting.value) return;
    requesting.value = true;
    try {
      EasyLoading.show(status: LocaleKeys.Commiting.tr);
      final response = await Net.value<Auxiliary>().requestFeedbackSubmit(
        content: text,
        images: imagePaths.isEmpty ? '' : imagePaths.join(','),
        contact: contactController.text.trim(),
      );
      EasyLoading.dismiss();
      if (response.success) {
        EasyLoading.showToast(response.msg ?? LocaleKeys.submitSuccess.tr);
        Future.delayed(Duration(seconds: 2), Get.back);
      } else {
        EasyLoading.showToast(response.msg ?? LocaleKeys.SubmitFailed.tr);
      }
    } catch (_) {
      EasyLoading.dismiss();
      EasyLoading.showToast(LocaleKeys.SubmitFailed.tr);
    } finally {
      requesting.value = false;
    }
  }
}
