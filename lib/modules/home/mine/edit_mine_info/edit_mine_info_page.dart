import 'package:kellychat/base/base_page.dart';
import 'edit_mine_info_controller.dart';
import 'model/edit_profile_draft.dart';
import 'view/edit_basic_info_section.dart';
import 'view/edit_bottom_actions.dart';
import 'view/edit_photo_wall_section.dart';
import 'view/edit_private_section.dart';
import 'view/edit_signature_section.dart';
import 'view/edit_tags_section.dart';

/// FileName: edit_mine_info_page
///
/// @Author 谌文
/// @Date 2026/4/12 22:51
///
/// @Description 编辑资料（区块见 `view/`）
class EditMineInfoPage extends BasePage<EditMineInfoController> {
  const EditMineInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ThemeColor.themeColor,
      appBar: AppBarKit.appBar(controller.title ?? ''),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              final v = controller.vm.value;
              final d = v.draft;
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /// 基础信息
                    EditBasicInfoSection(
                      avatarUrl: d.avatarUrl,
                      avatarLocalPath: d.pendingAvatarLocalPath,
                      nickname: d.nickname,
                      genderText: v.genderDisplay(),
                      birthdayText: d.birthday ?? '',
                      regionText: v.regionDisplay(),
                      onAvatar: controller.onAvatarTap,
                      onNickname: controller.clickEditNiceName,
                      onGender: controller.pushEditGenderAlert,
                      onBirthday: controller.onBirthdayTap,
                      onRegion: controller.pushRegionPickerAlert,
                    ),
                    const SizedBox(height: 12),

                    /// 标签view
                    EditTagsSection(
                      tags: List<String>.from(d.tags),
                      maxTags: EditProfileDraft.maxTags,
                      profileCardTagCount: EditProfileDraft.profileCardTagCount,
                      onReorder: controller.onTagReorder,
                      onAdd: controller.clickAddTags,
                    ),
                    const SizedBox(height: 12),

                    /// 个人简介
                    EditSignatureSection(
                      controller: v.signatureController,
                      maxLength: EditProfileDraft.maxSignatureLength,
                    ),
                    const SizedBox(height: 16),

                    /// 图片墙
                    EditPhotoWallSection(
                      photos: List<String>.from(d.photos),
                      crossAxisCount: 2,
                      spacing: 10,
                      onAdd: controller.clickAddPhoto,
                      onRemove: controller.onRemovePhoto,
                    ),
                    const SizedBox(height: 20),

                    /// 密码设置
                    EditPrivateSection(
                      privateContent: controller
                          .vm.value.userPrivateInfoEntity?.wishDescription,
                      onAiTap: controller.clickAddPrivacyMessage,
                      passwordHint:
                          true == controller.vm.value.draft.hasPrivateContent
                              ? ''
                              : '未设置过密码',
                      passwordBtnTitle:
                          true == controller.vm.value.draft.hasPrivateContent
                              ? '修改密码'
                              : '设置密码',
                      onChangePasswordTap: controller.clickModifyPassword,
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              );
            }),
          ),
          Obx(
            () => EditBottomActions(
              saveEnable: controller.requesting.value,
              onCancel: controller.onCancel,
              onSave: controller.onSave,
            ),
          ),
        ],
      ),
    );
  }
}
