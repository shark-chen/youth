import 'package:kellychat/base/base_controller.dart';
import 'package:kellychat/modules/home/mine/edit_mine_info/model/edit_profile_draft.dart';
import 'package:kellychat/modules/home/mine/edit_mine_info/view_model/edit_mine_info_vm.dart';
import 'package:kellychat/modules/home/mine/sex_select/model/gender.dart';
import 'controller/profile_setup_request_controller.dart';
export 'controller/profile_setup_request_controller.dart';
export 'controller/profile_setup_route_controller.dart';
import 'view_model/profile_setup_vm.dart';
import 'controller/profile_setup_route_controller.dart';

/// 登录后完善资料（三页 PageView）
class ProfileSetupController extends BaseController {
  final Rx<ProfileSetupVM> vm = ProfileSetupVM().obs;
  final PageController pageController = PageController();

  ///请先完善信息
  @override
  void onInit() {
    super.onInit();
    vm.value.refresh = vm.refresh;

    /// request - 获取用户注册时候，可选的标签
    requestRegisterTags();
  }

  @override
  void onClose() {
    vm.value.onClear();
    pageController.dispose();
    super.onClose();
  }

  /// 完善基础信息
  ///
  /// 选择性别
  void selectGender(Gender gender) {
    vm.value.stepOne.gender = gender;
    vm.refresh();
  }

  /// 点击头像
  Future<void> clickAvatar() async {
    /// push - 选择图片
    final file = await pushPickAvatarFilePage();
    if (file == null) return;

    /// 配置头像
    vm.value.configAvatarXFile(file);
    final avatarEntity = await requestUploadUserAvatar(file.path);
    if (avatarEntity == null) return;
    vm.value.configAvatarUrl(avatarEntity.url);
    vm.refresh();
  }

  /// MARK - 完善地区，标签信息
  ///
  /// 点击添加标签
  void clickAddCustomTagTap() async {
    if (vm.value.selectTags.length >= EditProfileDraft.maxTags) {
      EasyLoading.showToast('最多${EditProfileDraft.maxTags}个标签');
      return;
    }
    await pushEditNiceNameAlert(
      title: '自定义标签',
      hintText: '请输入标签...',
      sureCall: (value) {
        if (Strings.isEmpty(value)) {
          EasyLoading.showToast('请输入标签');
          return;
        }
        vm.value.clickAddCustomTagTap(value);
        vm.refresh();
        Get.back();
      },
    );
  }

  /// 点击删除自定义标签
  void clickSelectDeleteCustomTag(String value) {
    vm.value.clickSelectDeleteCustomTag(value);
    vm.refresh();
  }

  /// 点击可选标签
  void clickSelectTagName(BubbleModel value) {
    vm.value.clickSelectTagName(value);
    vm.refresh();
  }

  /// MARK - 图片墙 + 简介
  ///
  /// 点击添加图片
  Future<void> clickAddPhoto() async {
    final file = await pickPhotoFile();
    if (file == null) return;
    final imageLinksEntity = await requestUploadPhoto(file.path);
    if (Strings.isEmpty(imageLinksEntity?.url)) return;
    vm.value.addPhoto(imageLinksEntity?.url ?? '');
    vm.refresh();
  }

  /// 删除图片
  void clickDeletePhoto(int index) {
    vm.value.deletePhoto(index);
    vm.refresh();
  }

  /// 点击下一步
  Future<void> clickNext() async {
    if (vm.value.currentStep == 0) {
      /// 第一步校验提示toast
      hideKeyboard();
      if (!vm.value.stepOneCheckToast()) return;
    } else if (vm.value.currentStep == 1) {
      /// 第二步校验提示toast
      if (!vm.value.stepTwoCheckToast()) return;
    } else if (vm.value.currentStep == 2) {
      /// 第三步校验提示toast
      if (!vm.value.stepThreeCheckToast()) return;
    }
    if (vm.value.currentStep >= 2) return;
    vm.value.currentStep = vm.value.currentStep + 1;
    vm.refresh();
    await pageController.nextPage(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOut,
    );
  }

  /// 点击上一步
  Future<void> clickPrevious() async {
    if (vm.value.currentStep < 0) return;
    vm.value.currentStep = vm.value.currentStep - 1;
    vm.refresh();
    await pageController.previousPage(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOut,
    );
  }

  /// 点击完成
  Future<void> clickComplete() async {
    hideKeyboard();
    if (requesting.value) return;
    requesting.value = true;
    try {
      final ok = await requestSavePersistProfile();
      if (!ok) return;
      await Get.offAllNamed(Routes.homePage);
    } finally {
      requesting.value = false;
    }
  }
}
