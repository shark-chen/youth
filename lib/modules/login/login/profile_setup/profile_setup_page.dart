import 'package:kellychat/base/base_page.dart';
import 'package:kellychat/modules/home/mine/birthday_select/view/bottom_double_btn_view.dart';
import 'profile_setup_controller.dart';
import 'view/profile_setup_progress_bar.dart';
import 'view/profile_setup_basic_info_view.dart';
import 'view/profile_setup_showcase_view.dart';
import 'view/profile_setup_tags_area_view.dart';
import 'view_model/profile_setup_vm.dart';

/// FileName profile_setup_page
///
/// @Author 谌文
/// @Date 2026/7/8 14:34
///
/// @Description 登录后完善资料（三页可滑动 PageView）
class ProfileSetupPage extends BasePage<ProfileSetupController> {
  const ProfileSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.hideKeyboard,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: ThemeColor.themeColor,
        body: SafeArea(
          child: Obx(
            () {
              final vm = controller.vm.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 44),

                  /// 顶部三步进度条
                  ProfileSetupProgressBar(currentStep: vm.currentStep),
                  SizedBox(height: 24),

                  /// 三个信息补充页面
                  Expanded(
                    child: PageView(
                      controller: controller.pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        /// 完善基本信息模块 page
                        ProfileSetupBasicInfoWidget(
                          avatarUrl: vm.stepOne.avatarUrl,
                          avatarPath: vm.stepOne.avatarPath,
                          avatarTap: controller.clickAvatar,
                          nicknameController: vm.stepOne.nicknameController,
                          gender: vm.stepOne.gender,
                          selectGenderTap: controller.selectGender,
                          birthday: vm.stepOne.birthday,
                          birthdayTap: controller.pushEditBirthdaySheet,
                        ),

                        /// 标签 ，地区 page
                        ProfileSetupTagsAreaWidget(
                          areaTap: controller.pushRegionPickerAlert,
                          area: vm.selectLocation,
                          customTags: vm.stepTwo.customTags,
                          addCustomTagTap: controller.clickAddCustomTagTap,
                          customTagsDeleteTap:
                              controller.clickSelectDeleteCustomTag,
                          optionTags: vm.stepTwo.optionTags,
                          optionTagsTap: controller.clickSelectTagName,
                        ),

                        /// 图片墙 page
                        ProfileSetupShowcaseWidget(
                          addPhotoTap: controller.clickAddPhoto,
                          removePhotoTap: controller.clickDeletePhoto,
                          photos: vm.stepThree.photos,
                          briefController: vm.stepThree.briefController,
                        ),
                      ],
                    ),
                  ),

                  /// 上一个 下一个
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    child: BottomDoubleBtnWidget(
                      leftTitle:
                          controller.vm.value.currentStep != 0 ? '上一步' : '',
                      leftTap: controller.clickPrevious,
                      rightTitle: '下一个',
                      rightEnable: controller.vm.value.nextEnable,
                      rightTap: controller.clickNext,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
