import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kellychat/base/base_stateless_widget.dart';
import 'package:kellychat/modules/home/mine/edit_mine_info/model/edit_profile_draft.dart';
import 'package:kellychat/modules/home/mine/edit_mine_info/view/edit_photo_wall_section.dart';
import 'package:kellychat/modules/home/mine/edit_mine_info/view/edit_signature_section.dart';
import 'package:kellychat/utils/utils/theme_color.dart';
import '../profile_setup_controller.dart';
import 'profile_setup_brief_view.dart';

/// FileName profile_setup_showcase_view
///
/// @Author 谌文
/// @Date 2024/7/8 14:34
///
/// @Description 照片墙与个人简介 - widget
class ProfileSetupShowcaseWidget extends BaseStatelessWidget {
  const ProfileSetupShowcaseWidget({
    super.key,
    this.addPhotoTap,
    this.removePhotoTap,
    this.photos,
    this.briefController,
  });

  /// 添加图片点击
  final VoidCallback? addPhotoTap;

  /// 移除图片点击
  final ValueChanged<int>? removePhotoTap;

  /// 图片墙url
  final List<String>? photos;

  /// 简介
  final TextEditingController? briefController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              '展示一下自己吧',
              style: TextStyle(
                color: ThemeColor.whiteColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 44),
          Text(
            '照片墙 (最多9张)',
            style: TextStyle(
              color: ThemeColor.whiteColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),

          /// 图片墙
          EditPhotoWallSection(
            title: '',
            content: '',
            photos: photos ?? [],
            crossAxisCount: 2,
            spacing: 10,
            onAdd: addPhotoTap,
            onRemove: removePhotoTap,
            onReorder: (int oldIndex, int newIndex) {},
          ),
          const SizedBox(height: 20),

          /// 简介
          ProfileSetupBriefWidget(
            controller: briefController,
            maxLength: EditProfileDraft.maxSignatureLength,
          ),
        ],
      ),
    );
  }
}
