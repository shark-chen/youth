import 'package:kellychat/base/base_controller.dart';
import '../user_info/model/user_info_entity.dart';
import 'view_model/edit_mine_info_vm.dart';
export 'controller/edit_mine_info_route_controller.dart';
import 'controller/edit_mine_info_request_controller.dart';
import 'controller/edit_mine_info_route_controller.dart';

/// FileName: edit_mine_info_controller
///
/// @Author 谌文
/// @Date 2026/4/12 22:51
///
/// @Description 编辑资料：路由、弹窗、保存流程 数据处理在
class EditMineInfoController extends BaseController {
  Rx<EditMineInfoVM> vm = EditMineInfoVM().obs;

  @override
  void onInit() async {
    super.onInit();
    title = '编辑资料';
    vm.value.refresh = vm.refresh;

    /// 请求个人信息数据
    await requestData();
  }

  /// 请求个人信息数据
  Future<void> requestData() async {
    /// request - 获取用户信息
    await requestUserInfo();

    /// 获取用户私密信息 · GET /api/user/private
    await requestUserPrivate();
  }

  @override
  void onClose() {
    vm.value.disposeExtra();
    super.onClose();
  }

  /// mark - 个人信息部分 -包含头像，昵称，性别，生日， 地区
  ///
  /// 点击更新个人头像
  Future<void> clickUpdateAvatarTap() async {
    final file = await vm.value.pickAvatarFile();
    if (file == null) return;

    /// request - 上传头像
    final imageLinksEntity = await requestUploadUserAvatar(file.path);
    if (imageLinksEntity == null) return;
    vm.value.draft.avatarUrl = imageLinksEntity.url ?? '';
    vm.refresh();
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

  /// 点击添加秘密
  Future clickAddPrivacyMessage() async {
    final hasPrivateContent = true == vm.value.draft.hasPrivateContent;
    await pushPasswordAlert(
      title: hasPrivateContent ? '验证密码' : '设置密码',
      content: hasPrivateContent ? '请输入当前的6位数字密码' : '使用前，请先设置6位数字密码',
      onConfirm: (password) async {
        if (hasPrivateContent) {
          /// 验证私密信息密码
          final check = await requestUserPrivateVerify(password: password);
          if (check) {
            /// push - 私密语言-页面
            await pushPrivateMessagePage(
              content: vm.value.userPrivateInfoEntity?.wishDescription,
              oldPassword: password,
            );
          }
        } else {
          /// push - 私密语言-页面
          await pushPrivateMessagePage(
            content: vm.value.userPrivateInfoEntity?.wishDescription,
            password: password,
          );
        }

        /// 请求个人信息数据
        await requestData();
      },
    );
  }

  /// 点击修改密码
  Future clickModifyPassword() async {
    await pushPasswordAlert(
      title: '验证密码',
      content: '请输入当前的6位数字密码',
      onConfirm: (oldPassword) async {
        /// 验证私密信息密码
        final check = await requestUserPrivateVerify(password: oldPassword);
        if (check) {
          await pushPasswordAlert(
            title: '更新密码',
            content: '请输入新的6位数字密码',
            onConfirm: (newPassword) async {
              /// 第一次设置私密
              await requestUpdateUserPrivatePassword(
                newPassword: newPassword,
                oldPassword: oldPassword,
              );
            },
          );
        }
      },
    );
  }

  Future<void> onBirthdayTap() async {
    await pushEditBirthdaySheet();
  }

  /// mark - 标签相关事件
  ///
  /// 添加标签
  /// 点击添加标签
  Future<void> clickAddTags() async {
    await pushEditNiceNameAlert(
      title: '编辑标签',
      hintText: '请输入标签...',
      sureCall: (value) async {
        if (Strings.isEmpty(value)) {
          EasyLoading.showToast('请输入标签');
          return;
        }
        vm.value.addTag(value);

        /// 更新用户标签（最多10个）
        await requestUpdateUserTags(tags: vm.value.draft.tags);
        Get.back();
        vm.refresh();
      },
    );
  }

  /// 拖拽标签
  Future<void> onTagReorder(int oldIndex, int newIndex) async {
    vm.value.reorderTags(oldIndex, newIndex);

    /// 更新用户标签（最多10个）
    await requestUpdateUserTags(tags: vm.value.draft.tags);
    vm.refresh();
  }

  /// mark - 图片墙相关事件
  ///
  /// 点击添加图片
  Future<void> clickAddPhoto() async {
    final file = await vm.value.pickPhotoFile();
    final imageLinksEntity = await requestUploadPhoto(file?.path ?? '');
    if (imageLinksEntity == null) return;
    vm.value.draft.photos.add(imageLinksEntity.url ?? '');
    vm.value.addNewImageLinks(imageLinksEntity);
    if (Lists.isNotEmpty(vm.value.draft.photos)) {
      /// 更新照片墙 · PUT /api/user/photos
      await requestUpdateUserPhotos(photos: vm.value.draft.photos);
    }
    vm.refresh();
  }

  /// 删除图片墙某张图片
  Future<void> onRemovePhoto(int index) async {
    vm.value.removePhotoAt(index);

    /// 更新照片墙 · PUT /api/user/photos
    await requestUpdateUserPhotos(photos: vm.value.draft.photos);
    vm.refresh();
  }

  /// 点击保存个人信息
  Future<void> clickSave() async {
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
    EventBusManager().fire(UserInfoEntity());
    Get.back(result: true);
  }
}
