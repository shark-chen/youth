import 'dart:io';

import 'package:flutter/material.dart';
import 'package:youth/utils/utils/theme_color.dart';
import 'package:youth/widget/image_look/image_look.dart';

import 'edit_mine_card.dart';

/// 基础信息：头像、昵称、性别、生日、地区
class EditBasicInfoSection extends StatelessWidget {
  const EditBasicInfoSection({
    super.key,
    required this.avatarUrl,
    required this.avatarLocalPath,
    required this.nickname,
    required this.genderText,
    required this.birthdayText,
    required this.regionText,
    required this.onAvatar,
    required this.onNickname,
    required this.onGender,
    required this.onBirthday,
    required this.onRegion,
  });

  final String avatarUrl;
  final String? avatarLocalPath;
  final String nickname;
  final String genderText;
  final String birthdayText;
  final String regionText;
  final VoidCallback onAvatar;
  final VoidCallback onNickname;
  final VoidCallback onGender;
  final VoidCallback onBirthday;
  final VoidCallback onRegion;

  @override
  Widget build(BuildContext context) {
    return EditMineCard(
      child: Column(
        children: [
          _row(
            label: '头像',
            onTap: onAvatar,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _avatarThumb(),
                const SizedBox(width: 8),
                _chevron(),
              ],
            ),
          ),
          _divider(),
          _row(
            label: '昵称',
            value: nickname.isEmpty ? '未设置' : nickname,
            onTap: onNickname,
          ),
          _divider(),
          _row(
            label: '性别',
            value: genderText,
            onTap: onGender,
          ),
          _divider(),
          _row(
            label: '生日',
            value: birthdayText.isEmpty ? '未设置' : birthdayText,
            onTap: onBirthday,
          ),
          _divider(),
          _row(
            label: '地区',
            value: regionText.isEmpty ? '未设置' : regionText,
            onTap: onRegion,
          ),
        ],
      ),
    );
  }

  Widget _avatarThumb() {
    final local = avatarLocalPath;
    if (local != null && local.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.file(
          File(local),
          width: 40,
          height: 40,
          fit: BoxFit.cover,
        ),
      );
    }
    return ImageLookWidget(
      width: 40,
      height: 40,
      imgUrl: avatarUrl,
      imgBorderRadius: BorderRadius.circular(20),
    );
  }

  Widget _chevron() {
    return Icon(
      Icons.chevron_right,
      color: ThemeColor.whiteColor.withOpacity(0.35),
      size: 22,
    );
  }

  Widget _row({
    required String label,
    String? value,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              SizedBox(
                width: 72,
                child: Text(
                  label,
                  style: TextStyle(
                    color: ThemeColor.whiteColor.withOpacity(0.85),
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: trailing ??
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              value ?? '',
                              textAlign: TextAlign.right,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: ThemeColor.whiteColor,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          _chevron(),
                        ],
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 16,
      endIndent: 16,
      color: ThemeColor.whiteColor.withOpacity(0.08),
    );
  }
}
