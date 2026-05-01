import 'package:kellychat/base/base_controller.dart';
import 'view_model/edit_mine_info_vm.dart';
export 'controller/edit_mine_info_route_controller.dart';
import 'controller/edit_mine_info_request_controller.dart';
import 'controller/edit_mine_info_route_controller.dart';

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
    await requestUserInfo();
    await requestUserPrivate();
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
    final err = await requestSavePersistProfile();
    EasyLoading.dismiss();
    requesting.value = false;
    if (err != null && err.isNotEmpty) {
      EasyLoading.showToast(err);
      return;
    }
    EasyLoading.showToast(LocaleKeys.submitSuccess.tr);
    Get.back(result: true);
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
      sureCall: (value) async {
        vm.value.addTag(value);

        /// 更新用户标签（最多10个）
        await requestUpdateUserTags(tags: vm.value.draft.tags ?? []);
        Get.back();
        vm.refresh();
      },
    );
  }

  /// 点击添加秘密
  Future clickAddPrivacyMessage() async {
    if (true == vm.value.draft.hasPrivateContent) {
      await pushPasswordAlert(
        title: '验证密码',
        onConfirm: (password) async {
          /// 验证私密信息密码
          final check = await requestUserPrivateVerify(password: password);
          if (check) {
            /// push - 私密语言-页面
            await pushPrivateMessagePage(
              content: vm.value.userPrivateInfoEntity?.wishDescription,
              oldPassword: password,
            );
          }
        },
      );
    } else {
      await pushPasswordAlert(
        title: '设置密码',
        onConfirm: (password) async {
          /// push - 私密语言-页面
          await pushPrivateMessagePage(
            content: vm.value.userPrivateInfoEntity?.wishDescription,
            password: password,
          );
        },
      );
    }
  }

  /// 点击修改密码
  Future clickModifyPassword() async {
    await pushPasswordAlert(
      title: '验证密码',
      onConfirm: (oldPassword) async {
        /// 验证私密信息密码
        final check = await requestUserPrivateVerify(password: oldPassword);
        if (check) {
          await pushPasswordAlert(
            title: '更新尼玛',
            onConfirm: (newPassword) async {
              /// 第一次设置私密
              final result = await requestUpdateUserPrivatePassword(
                newPassword: newPassword,
                oldPassword: oldPassword,
              );
              Get.back();
            },
          );
        }
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

  /// 点击添加图片
  Future<void> clickAddPhoto() async {
    final file = await vm.value.pickPhotoFile();
    final url = await requestUploadPhoto(file?.path ?? '');
    if (Strings.isEmpty(url)) return;
    vm.value.draft.photos.add(url ?? '');
    if (Lists.isNotEmpty(vm.value.draft.photos)) {
      /// 更新照片墙 · PUT /api/user/photos
      await requestUpdateUserPhotos(photos: vm.value.draft.photos);
    }
    vm.refresh();
  }

  void onRemovePhoto(int index) {
    vm.value.removePhotoAt(index);
    vm.refresh();
  }

  void onPrivateAiTap() {
    EasyLoading.showToast('敬请期待');
  }

  Future<void> onChangePasswordTap() async {
    await pushPasswordAlert(title: '验证密码', onConfirm: (_) {});
  }
}
