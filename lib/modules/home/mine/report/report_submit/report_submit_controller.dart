import 'package:image_picker/image_picker.dart';
import 'package:youth/base/base_controller.dart';
import 'package:youth/modules/home/mine/edit_mine_info/model/image_links_entity.dart';
import 'package:youth/network/net/entry/user/user.dart';
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

  /// 上传单张图片（与 [EditMineInfoReuestController.requestUploadPhoto] 一致，不在此重复 EasyLoading）
  Future<String?> _requestUploadPhoto(String path) async {
    if (Strings.isEmpty(path)) return null;
    final response = await Net.value<User>()
        .requestUploadUserAvatarFromPath<ImageLinksEntity>(
      path,
      filename: path.split('/').last,
    );
    if (response.succeed) {
      return response.value?.url ?? '';
    }
    EasyLoading.showToast('图片上传失败');
    return null;
  }

  Future<void> submit() async {
    final text = contentController.text.trim();
    if (text.isEmpty && imagePaths.isEmpty) {
      EasyLoading.showToast('请填写举报描述或上传图片证据');
      return;
    }
    final rid = reasonId?.trim();
    if (rid == null || rid.isEmpty) {
      EasyLoading.showToast('缺少举报类型');
      return;
    }
    final uidStr = reportedUserId?.trim();
    final reportedUid = int.tryParse(uidStr ?? '');
    if (reportedUid == null || reportedUid <= 0) {
      EasyLoading.showToast('缺少被举报用户信息');
      return;
    }
    if (requesting.value) return;
    requesting.value = true;
    try {
      EasyLoading.show(status: LocaleKeys.Commiting.tr);
      final urls = <String>[];
      for (final path in imagePaths) {
        final url = await _requestUploadPhoto(path);
        if (url == null || url.isEmpty) {
          EasyLoading.dismiss();
          return;
        }
        urls.add(url);
      }
      final imagesParam = urls.isEmpty ? '' : urls.join(',');
      final reasonText =
          (reasonLabel != null && reasonLabel!.isNotEmpty)
              ? reasonLabel!
              : (ReportReasonData.labelForReasonId(rid) ?? rid);
      final response = await Net.value<User>().requestReportSubmit<dynamic>(
        reportedUserId: reportedUid,
        reportType: ReportReasonData.reportTypeForReasonId(rid),
        reason: reasonText,
        description: text,
        images: imagesParam,
      );
      EasyLoading.dismiss();
      final ok = response.code == 200 || response.code == 0;
      if (ok) {
        final tip = response.msg;
        EasyLoading.showToast(
          (tip != null && tip.isNotEmpty) ? tip : LocaleKeys.submitSuccess.tr,
        );
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
