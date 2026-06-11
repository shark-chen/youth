import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:kellychat/base/base_stateless_widget.dart';
import 'package:kellychat/modules/home/mine/sex_select/model/gender.dart';

/// FileName profile_setup_basic_info_view
///
/// @Author 谌文
/// @Date 2024/7/8 14:34
///
/// @Description 完善基础信息 - widget
class ProfileSetupBasicInfoWidget extends BaseStatelessWidget {
  const ProfileSetupBasicInfoWidget({
    super.key,
    this.avatarUrl,
    this.avatarPath,
    this.avatarTap,
    this.nicknameController,
    this.gender,
    this.selectGenderTap,
    this.birthday,
    this.birthdayTap,
  });

  /// 头像url
  final String? avatarUrl;

  /// 头像path
  final String? avatarPath;

  /// 头像点击
  final VoidCallback? avatarTap;

  /// 昵称
  final TextEditingController? nicknameController;

  /// 性别
  final Gender? gender;

  /// 选择性别点击
  final ValueChanged<Gender>? selectGenderTap;

  /// 生日
  final String? birthday;

  /// 生日设置点击
  final VoidCallback? birthdayTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// 完善基础信息
          Center(
            child: Text(
              '完善基础信息',
              style: TextStyle(
                color: ThemeColor.whiteColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text(
              '信息越完整，KellyChat 找人更精准~',
              style: TextStyle(
                color: ThemeColor.white6Color,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 31),

          /// 上传头像widget
          buildAvatarWidget(),
          const SizedBox(height: 32),
          buildTitleWidget('设置昵称'),
          const SizedBox(height: 12),

          /// 请输入昵称输入框 widget
          buildNickInputWidget(),

          const SizedBox(height: 32),
          buildTitleWidget('设置性别'),
          const SizedBox(height: 12),

          /// 设置性别
          Row(
            children: [
              Expanded(
                child: _GenderButton(
                  label: '男',
                  sexIcon: Icon(Icons.male, color: ThemeColor.maleIconColor),
                  selected: gender == Gender.boy,
                  onTap: () => selectGenderTap?.call(Gender.boy),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _GenderButton(
                  label: '女',
                  sexIcon: Icon(
                    Icons.female,
                    color: ThemeColor.femaleIconColor,
                  ),
                  selected: gender == Gender.girl,
                  onTap: () => selectGenderTap?.call(Gender.girl),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          buildTitleWidget('设置生日'),
          const SizedBox(height: 12),

          /// 选择出生日期
          buildBirthdayPickWidget(),
        ],
      ),
    );
  }

  /// 标题
  Widget buildTitleWidget(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 12),
      child: Text(
        text,
        style: TextStyle(
          color: ThemeColor.whiteColor,
          fontSize: 14,
        ),
      ),
    );
  }

  /// 上传头像widget
  Widget buildAvatarWidget() {
    return Center(
      child: GestureDetector(
        onTap: avatarTap,
        child: Column(
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: ThemeColor.inputBgColor,
                shape: BoxShape.circle,
              ),
              child: Strings.isNotEmpty(avatarPath) ||
                      Strings.isNotEmpty(avatarUrl)
                  ? ClipOval(
                      child: Strings.isNotEmpty(avatarUrl)
                          ? ImageLookWidget(
                              width: 108,
                              height: 108,
                              imgUrl: avatarUrl ?? '',
                              imgBorderRadius: BorderRadius.circular(999),
                              borderColor: Colors.transparent,
                              heroTag: '${avatarUrl}_profile_setup_avatar',
                            )
                          : Image.file(
                              File(avatarPath ?? ''),
                              width: 108,
                              height: 108,
                              fit: BoxFit.cover,
                            ),
                    )
                  : Icon(
                      Icons.photo_camera_outlined,
                      color: ThemeColor.whiteColor.withOpacity(0.45),
                      size: 32,
                    ),
            ),
            const SizedBox(height: 12),
            Text(
              '上传头像',
              style: TextStyle(
                color: ThemeColor.white6Color,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 请输入昵称输入框 widget
  Widget buildNickInputWidget() {
    return Container(
      decoration: BoxDecoration(
        color: ThemeColor.inputBgColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: TextField(
        controller: nicknameController,
        maxLength: 30,
        style: TextStyle(color: ThemeColor.whiteColor, fontSize: 15),
        cursorColor: ThemeColor.themeGreenColor,
        decoration: InputDecoration(
          counterText: '',
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          hintText: '请输入昵称...',
          hintStyle: TextStyle(
            color: ThemeColor.whiteColor.withOpacity(0.35),
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  /// 生日选择widget
  Widget buildBirthdayPickWidget() {
    return GestureDetector(
      onTap: birthdayTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: ThemeColor.inputBgColor,
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                Strings.isEmpty(birthday) ? '选择出生日期' : (birthday ?? ''),
                style: TextStyle(
                  color: Strings.isNotEmpty(birthday)
                      ? ThemeColor.whiteColor
                      : ThemeColor.whiteColor.withOpacity(0.35),
                  fontSize: 15,
                ),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: ThemeColor.whiteColor.withOpacity(0.45),
            ),
          ],
        ),
      ),
    );
  }
}

class _GenderButton extends StatelessWidget {
  const _GenderButton({
    required this.label,
    required this.sexIcon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final Icon sexIcon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: ThemeColor.inputBgColor,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected
                ? ThemeColor.themeGreenColor
                : ThemeColor.whiteColor.withOpacity(0.06),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            sexIcon,
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: ThemeColor.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
