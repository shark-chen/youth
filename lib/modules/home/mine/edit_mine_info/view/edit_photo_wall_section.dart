import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kellychat/utils/utils/theme_color.dart';
import 'package:kellychat/widget/image_look/image_look.dart';

import '../model/edit_profile_draft.dart';

/// 照片墙：2×2 宫格，「前3张展示在资料卡」说明
class EditPhotoWallSection extends StatelessWidget {
  const EditPhotoWallSection({
    super.key,
    required this.photos,
    required this.crossAxisCount,
    required this.spacing,
    required this.onAdd,
    required this.onRemove,
  });

  final List<String> photos;
  final int crossAxisCount;
  final double spacing;
  final VoidCallback onAdd;
  final void Function(int index) onRemove;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final pad = 16.0 * 2;
    final slot = (width - pad - spacing * (crossAxisCount - 1)) / crossAxisCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '照片墙',
          style: TextStyle(
            color: ThemeColor.whiteColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '前${EditProfileDraft.profileCardPhotoCount}张将展示在个人资料卡',
          style: TextStyle(
            color: ThemeColor.secondaryTextColor,
            fontSize: 12,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (var i = 0; i < photos.length; i++)
              _PhotoCell(
                pathOrUrl: photos[i],
                size: slot,
                onRemove: () => onRemove(i),
              ),
            if (photos.length < EditProfileDraft.maxPhotos)
              _AddCell(size: slot, onTap: onAdd),
          ],
        ),
      ],
    );
  }
}

class _PhotoCell extends StatelessWidget {
  const _PhotoCell({
    required this.pathOrUrl,
    required this.size,
    required this.onRemove,
  });

  final String pathOrUrl;
  final double size;
  final VoidCallback onRemove;

  bool get _isRemote =>
      pathOrUrl.startsWith('http://') || pathOrUrl.startsWith('https://');

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: _isRemote
              ? ImageLookWidget(
                  width: size,
                  height: size,
                  imgUrl: pathOrUrl,
                  imgBorderRadius: BorderRadius.circular(12),
                )
              : Image.file(
                  File(pathOrUrl),
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                ),
        ),
        Positioned(
          top: -5,
          right: -5,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: ThemeColor.brightRedColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                size: 14,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AddCell extends StatelessWidget {
  const _AddCell({required this.size, required this.onTap});

  final double size;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: ThemeColor.doingListCellBgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: ThemeColor.whiteColor.withOpacity(0.9),
                size: 28,
              ),
              const SizedBox(height: 4),
              Text(
                '添加',
                style: TextStyle(
                  color: ThemeColor.secondaryTextColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
