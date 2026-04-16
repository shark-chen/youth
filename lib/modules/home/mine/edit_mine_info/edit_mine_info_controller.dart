import 'package:youth/base/base_controller.dart';
import 'package:youth/network/net/entry/user/user.dart';
import 'package:youth/widget/region_picker/region_picker_sheet.dart';
import 'view/edit_gender_sheet_widget.dart';
import 'view_model/edit_mine_info_vm.dart';
export 'controller/edit_mine_info_route_controller.dart';
import 'controller/edit_mine_info_route_controller.dart';
import 'controller/edit_mine_info_request_controller.dart';

/// FileName: edit_mine_info_controller
///
/// @Author 谌文
/// @Date 2026/4/12 22:51
///
/// @Description 编辑资料：路由、弹窗、保存流程（数据处理在 [EditMineInfoVM]）
class EditMineInfoController extends BaseController {
  Rx<EditMineInfoVM> vm = EditMineInfoVM().obs;

  @override
  void onInit() {
    super.onInit();
    title = '编辑资料';
    vm.value.refresh = vm.refresh;
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    EasyLoading.show();
    final err = await vm.value.loadFromServer();
    EasyLoading.dismiss();
    if (err != null && err.isNotEmpty) {
      EasyLoading.showToast(err);
    }
    vm.refresh();
  }

  @override
  void onClose() {
    vm.value.disposeExtra();
    super.onClose();
  }

  void onCancel() {
    Get.back();
  }

  Future<void> onSave() async {
    if (requesting.value) return;
    requesting.value = true;
    EasyLoading.show(status: LocaleKeys.Commiting.tr);
    final err = await vm.value.persistProfile();
    EasyLoading.dismiss();
    requesting.value = false;
    if (err != null && err.isNotEmpty) {
      EasyLoading.showToast(err);
      return;
    }
    EasyLoading.showToast(LocaleKeys.submitSuccess.tr);
    Get.back(result: true);
  }

  /// request - 标签走独立接口 PUT /api/user/tags
  Future requestUpdateUserTags() async {
    EasyLoading.show();
    final response = await Net.value<User>().requestUpdateUserTags(
      tags: List<String>.from(vm.value.draft.tags),
    );
    EasyLoading.dismiss();
    if (response.success) {
      EasyLoading.showToast('标签保存成功');
    } else {
      EasyLoading.showToast(response.msg ?? '标签保存失败');
    }
  }

  /// 点击编辑昵称
  Future<void> clickEditNiceName() async {
    await pushEditNiceNameAlert(
      title: '编辑昵称',
      text: vm.value.draft.nickname,
      sureCall: (value) {
        vm.value.applyNickname(value);
        Get.back();
        vm.refresh();
      },
    );
  }

  /// 点击添加标签
  Future<void> clickAddTags() async {
    await pushEditNiceNameAlert(
      title: '添加标签',
      sureCall: (value) async  {
        vm.value.addTag(value);
        Get.back();
        await requestUpdateUserTags();
        vm.refresh();
      },
    );
  }

  Future<void> onAvatarTap() async {
    await vm.value.pickAvatarFile();
    vm.refresh();
  }

  Future<void> onBirthdayTap() async {
    final ctx = Get.context;
    if (ctx == null) return;
    final now = DateTime.now();
    final initial = vm.value.birthdayAsDate() ?? DateTime(now.year - 25);
    final picked = await showDatePicker(
      context: ctx,
      initialDate: initial,
      firstDate: DateTime(1900),
      lastDate: now,
      builder: (c, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: ThemeColor.themeGreenColor,
              surface: ThemeColor.doingListCellBgColor,
            ),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
    if (picked != null) {
      vm.value.setBirthday(picked);
      vm.refresh();
    }
  }

  void onTagReorder(int oldIndex, int newIndex) {
    vm.value.reorderTags(oldIndex, newIndex);
    vm.refresh();
  }

  Future<void> onAddTagTap() async {
    final ctx = Get.context;
    if (ctx == null) return;
    final tec = TextEditingController();
    final result = await showDialog<String>(
      context: ctx,
      builder: (c) {
        return AlertDialog(
          backgroundColor: ThemeColor.inputBgColor,
          title: Text(
            '添加标签',
            style: TextStyle(color: ThemeColor.whiteColor),
          ),
          content: TextField(
            controller: tec,
            autofocus: true,
            style: TextStyle(color: ThemeColor.whiteColor),
            decoration: InputDecoration(
              hintText: '例如：🎬 看电影',
              hintStyle: TextStyle(
                color: ThemeColor.whiteColor.withOpacity(0.45),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(c),
              child: Text(
                '取消',
                style: TextStyle(color: ThemeColor.themeA2Color),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(c, tec.text),
              child: Text(
                '确定',
                style: TextStyle(color: ThemeColor.themeGreenColor),
              ),
            ),
          ],
        );
      },
    );
    tec.dispose();
    if (result != null) {
      vm.value.addTag(result);
      vm.refresh();
    }
  }

  Future<void> onAddPhotoTap() async {
    await vm.value.pickPhotoFile();

    vm.refresh();
    String? fileName = vm.value.draft.photos.last.split('/').last;

    requestUploadPhoto(filePath: vm.value.draft.photos.last, filename: fileName);
  }

  void onRemovePhoto(int index) {
    vm.value.removePhotoAt(index);
    vm.refresh();
  }

  void onPrivateAiTap() {
    EasyLoading.showToast('敬请期待');
  }

  void onChangePasswordTap() {
    EasyLoading.showToast('修改密码功能即将开放');
  }
}
