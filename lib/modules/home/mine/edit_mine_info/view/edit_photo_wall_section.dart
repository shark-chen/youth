import 'dart:io';
import 'package:kellychat/base/base_stateless_widget.dart';
import 'package:reorderables/reorderables.dart';
import '../model/edit_profile_draft.dart';

/// 照片墙：2×2 宫格，「前3张展示在资料卡」说明
class EditPhotoWallSection extends BaseStatelessWidget {
  const EditPhotoWallSection({
    super.key,
    required this.photos,
    required this.crossAxisCount,
    required this.spacing,
    required this.onAdd,
    required this.onRemove,
    required this.onReorder,
  });

  /// 图片资源
  final List<String> photos;

  /// 图片竖向-间距
  final int crossAxisCount;

  /// 图片横向-间距
  final double spacing;

  /// 点击图片点击
  final VoidCallback onAdd;

  /// 移除图片点击
  final ValueChanged<int> onRemove;

  /// 长按拖动排序（仅照片；添加按钮放在 header，不参与重排）
  final void Function(int oldIndex, int newIndex) onReorder;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final pad = 16.0 * 2;
    final slot =
        (width - pad - spacing * (crossAxisCount - 1)) / crossAxisCount;
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
          '长按拖动排序，最多9张，第1张将展示在资料卡',
          style: TextStyle(
            color: ThemeColor.secondaryTextColor,
            fontSize: 12,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 12),

        /// 图片墙：`header` 为添加格；`children` 长按拖拽排序（与标签一致）
        ReorderableWrap(
          spacing: spacing,
          runSpacing: spacing,
          needsLongPressDraggable: true,
          scrollPhysics: const NeverScrollableScrollPhysics(),
          maxMainAxisCount: crossAxisCount,
          minMainAxisCount: 1,
          header: photos.length < EditProfileDraft.maxPhotos
              ? [
                  _AddCell(
                    width: slot,
                    height: slot * 1.33,
                    onTap: onAdd,
                  ),
                ]
              : null,
          onReorder: onReorder,
          children: [
            for (var i = 0; i < photos.length; i++)
              _PhotoCell(
                key: ValueKey('edit_photo_${photos[i]}_$i'),
                pathOrUrl: photos[i],
                width: slot,
                height: slot * 1.33,
                onRemove: () => onRemove(i),
              ),
          ],
        ),
      ],
    );
  }
}

class _PhotoCell extends StatelessWidget {
  const _PhotoCell({
    super.key,
    required this.pathOrUrl,
    required this.width,
    required this.height,
    required this.onRemove,
  });

  /// 图片地址
  final String pathOrUrl;

  /// 图片宽度
  final double width;

  /// 图片高度
  final double height;

  /// 删除图片点击事件
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
                  width: width,
                  height: height,
                  imgUrl: pathOrUrl,
                  imgBorderRadius: BorderRadius.circular(12),
                  borderColor: Colors.transparent,
                  heroTag: '${pathOrUrl}_edit_photo_wall',
                )
              : Image.file(
                  File(pathOrUrl),
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                ),
        ),
        Positioned(
          top: 3,
          right: 3,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              width: 22,
              height: 22,
              child: Image.asset(
                'assets/image/common/black_close@3x.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AddCell extends StatelessWidget {
  const _AddCell({
    required this.width,
    required this.height,
    required this.onTap,
  });

  /// 图片宽度
  final double width;

  /// 图片高度
  final double height;

  /// 点击添加
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: ThemeColor.themeColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 1,
              color: ThemeColor.three97Color,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: ThemeColor.whiteColor,
                size: 24,
              ),
              const SizedBox(height: 2),
              Text(
                '添加',
                style: TextStyle(
                  color: ThemeColor.whiteColor,
                  fontWeight: FontWeight.w500,
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
