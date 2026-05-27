import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kellychat/utils/extension/strings/strings.dart';
import 'package:kellychat/utils/utils/theme_color.dart';
import 'base/image_screen.dart';

/// FileName image_look
///
/// @Author 谌文
/// @Date 2023/11/7 18:54
///
/// @Description 点击图片可放大widget
class ImageLookWidget extends StatelessWidget {
  const ImageLookWidget({
    Key? key,
    required this.imgUrl,
    this.heroTag,
    this.width = 66.0,
    this.height = 66.0,
    this.color,
    this.decoration,
    this.borderColor,
    this.imgBorderRadius,
    this.fit,
    this.onTap,
    this.enlargeLook = true,
    this.autoSize = false,
  }) : super(key: key);

  /// 图片资源url
  final String imgUrl;

  /// 用来定位缩放图片用
  final String? heroTag;

  /// 宽
  final double? width;

  /// 高
  final double? height;

  /// of a particular [ShapeDecoration], consider using a [ClipPath] widget.
  final Decoration? decoration;

  /// This value is ignored if [clipper] is non-null.
  final BorderRadiusGeometry? imgBorderRadius;

  /// The default varies based on the other fields. See the discussion at
  /// [paintImage].
  final BoxFit? fit;

  /// 点击图片回调
  final VoidCallback? onTap;

  /// 颜色
  final Color? color;

  /// 边框颜色
  final Color? borderColor;

  /// 是否可以点击打开图片
  final bool? enlargeLook;

  /// 自动适应宽高
  final bool? autoSize;

  double get _layoutWidth => width ?? 66.0;

  double get _layoutHeight => height ?? 66.0;

  /// 默认头像占位（加载中 / 失败 / 无 URL）
  Widget _avatarPlaceholder() {
    final side = _layoutWidth < _layoutHeight ? _layoutWidth : _layoutHeight;
    return Container(
      width: autoSize == true ? null : _layoutWidth,
      height: autoSize == true ? null : _layoutHeight,
      alignment: Alignment.center,
      color: ThemeColor.white15Color,
      child: Icon(
        Icons.person_rounded,
        size: side * 0.48,
        color: ThemeColor.whiteColor.withOpacity(0.45),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget container = ClipRRect(
      borderRadius: imgBorderRadius ?? BorderRadius.circular(4),
      child: Strings.isNotEmpty(imgUrl)
          ? CachedNetworkImage(
              fit: fit,
              imageUrl: imgUrl,
              width: autoSize == true ? null : (width ?? 66.0),
              height: autoSize == true ? null : (height ?? 66.0),
              placeholder: (context, url) => _avatarPlaceholder(),
              errorWidget: (context, url, error) => _avatarPlaceholder(),
            )
          : SizedBox(
              width: _layoutWidth,
              height: _layoutHeight,
              child: _avatarPlaceholder(),
            ),
    );
    if (autoSize != true) {
      container = Container(
        width: width ?? 66.0,
        height: height ?? 66.0,
        decoration: decoration ??
            BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(
                  color: borderColor ?? Colors.transparent, width: 1.0),
            ),
        child: container,
      );
    }
    if (enlargeLook == false) {
      return container;
    } else {
      return GestureDetector(
          onTap: () {
            onTap?.call();
            Navigator.of(context).push<void>(
              PageRouteBuilder(
                opaque: false, // set to false
                pageBuilder: (_, __, ___) => ImageScreen(
                  url: imgUrl,
                  heroTag: (heroTag ?? ''),
                ),
              ),
            );
          },
          child:
              Hero(tag: heroTag ?? UniqueKey().toString(), child: container));
    }
  }
}
