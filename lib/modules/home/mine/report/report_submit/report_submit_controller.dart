import 'package:image_picker/image_picker.dart';
import 'package:youth/base/base_controller.dart';
import 'package:youth/utils/authority/photos_authority.dart';

import '../model/report_reason_data.dart';

/// FileName: report_submit_controller
///
/// @Author 谌文
/// @Date 2026/4/19
///
/// @Description 举报证据提交
class ReportSubmitController extends BaseController {
  static const int maxContentLength = 200;
  static const int maxImages = 3;

  late final TextEditingController contentController;

  /// 已选本地图片路径
  final RxList<String> imagePaths = <String>[].obs;

  final ImagePicker _picker = ImagePicker();

  /// 被举报用户 id（路由 `userId`）
  String? reportedUserId;

  /// 举报理由 id（路由 `reasonId`）
  String? reasonId;

  /// 举报理由展示文案
  String? reasonLabel;

  @override
  void onInit() {
    super.onInit();
    title = '举报证据';
    reportedUserId = Get.parameters['userId'];
    reasonId = Get.parameters['reasonId'];
    if (reasonId != null && reasonId!.isNotEmpty) {
      reasonLabel = ReportReasonData.labelForReasonId(reasonId!);
    }
    contentController = TextEditingController();
  }

  @override
  void onClose() {
    contentController.dispose();
    super.onClose();
  }

  bool get canAddImage => imagePaths.length < maxImages;

  Future<void> pickImage() async {
    if (!canAddImage) return;
    if (!await PhotosAuthority.request()) return;
    try {
      final x = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 2048,
        maxHeight: 2048,
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

  Future<void> submit() async {
    final text = contentController.text.trim();
    if (text.isEmpty && imagePaths.isEmpty) {
      EasyLoading.showToast('请填写举报描述或上传图片证据');
      return;
    }
    if (requesting.value) return;
    requesting.value = true;
    try {
      EasyLoading.show(status: LocaleKeys.Commiting.tr);
      // TODO: 对接举报提交接口（描述、图片、reasonId、reportedUserId）
      await Future<void>.delayed(const Duration(milliseconds: 400));
      EasyLoading.dismiss();
      EasyLoading.showToast(LocaleKeys.submitSuccess.tr);
      Get.back();
    } catch (_) {
      EasyLoading.dismiss();
      EasyLoading.showToast(LocaleKeys.SubmitFailed.tr);
    } finally {
      requesting.value = false;
    }
  }
}
