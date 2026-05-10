import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:kellychat/tripartite_library/tripartite_library.dart';
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
    this.imageBytes,
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

  /// 图片资源url（大图预览 [ImageScreen] 仍用 URL）
  final String imgUrl;

  /// 已载入内存的本地图字节（优先于网络；不由 Widget 读路径）
  final Uint8List? imageBytes;

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

  /// Hero / 大图预览共用
  String get _effectiveHeroTag =>
      (heroTag != null && heroTag!.isNotEmpty)
          ? heroTag!
          : (Strings.isNotEmpty(imgUrl)
              ? imgUrl
              : 'memory_${imageBytes?.hashCode ?? 0}');

  /// 大图预览 URL：无远程地址时不跳转大图（仅有内存图时）
  String? get _previewUrl =>
      Strings.isNotEmpty(imgUrl) ? imgUrl : null;

  static Widget _errorPlaceholder() {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Image.asset(
        'assets/image/common/hello@3x.png',
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _fixedSizeMemoryImage({
    required Uint8List bytes,
    required double logicalW,
    required double logicalH,
    required int memW,
    required int memH,
  }) {
    return Image.memory(
      bytes,
      width: logicalW,
      height: logicalH,
      fit: fit ?? BoxFit.cover,
      alignment: Alignment.center,
      filterQuality: FilterQuality.medium,
      gaplessPlayback: true,
      cacheWidth: memW,
      cacheHeight: memH,
      errorBuilder: (_, __, ___) => _errorPlaceholder(),
    );
  }

  Widget _autoSizeMemoryImage(Uint8List bytes) {
    return Image.memory(
      bytes,
      fit: fit,
      filterQuality: FilterQuality.medium,
      gaplessPlayback: true,
      errorBuilder: (_, __, ___) => _errorPlaceholder(),
    );
  }

  /// 固定宽高：走 [Image] + [frameBuilder]，内存命中时可同步出图，显著减轻占位闪烁
  Widget _fixedSizeImage({
    required BuildContext context,
    required double logicalW,
    required double logicalH,
    required int memW,
    required int memH,
  }) {
    return Image(
      image: ResizeImage(
        CachedNetworkImageProvider(imgUrl),
        width: memW,
        height: memH,
      ),
      width: logicalW,
      height: logicalH,
      fit: fit ?? BoxFit.cover,
      alignment: Alignment.center,
      filterQuality: FilterQuality.medium,
      gaplessPlayback: true,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded || frame != null) {
          return child;
        }
        return SizedBox(
          width: logicalW,
          height: logicalH,
          child: ColoredBox(
            color: ThemeColor.graynessBgColor.withOpacity(0.06),
          ),
        );
      },
      errorBuilder: (_, __, ___) => _errorPlaceholder(),
    );
  }

  /// autoSize：仍用 CachedNetworkImage；不传 placeholder，内部空占位，避免 Octo 与缺省图切换
  Widget _autoSizeCachedImage() {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      fit: fit,
      fadeInDuration: Duration.zero,
      fadeOutDuration: Duration.zero,
      fadeInCurve: Curves.linear,
      fadeOutCurve: Curves.linear,
      placeholderFadeInDuration: Duration.zero,
      filterQuality: FilterQuality.medium,
      errorWidget: (_, __, ___) => _errorPlaceholder(),
    );
  }

  Widget _buildImageContent(BuildContext context) {
    final logicalW = width ?? 66.0;
    final logicalH = height ?? 66.0;
    final dpr = MediaQuery.devicePixelRatioOf(context);
    final memW =
        autoSize == true ? null : (logicalW * dpr).round().clamp(1, 4096);
    final memH =
        autoSize == true ? null : (logicalH * dpr).round().clamp(1, 4096);

    final bytes = imageBytes;
    if (bytes != null && bytes.isNotEmpty) {
      if (autoSize == true) {
        return _autoSizeMemoryImage(bytes);
      }
      return _fixedSizeMemoryImage(
        bytes: bytes,
        logicalW: logicalW,
        logicalH: logicalH,
        memW: memW!,
        memH: memH!,
      );
    }

    if (Strings.isNotEmpty(imgUrl)) {
      return autoSize == true
          ? _autoSizeCachedImage()
          : _fixedSizeImage(
              context: context,
              logicalW: logicalW,
              logicalH: logicalH,
              memW: memW!,
              memH: memH!,
            );
    }

    return SizedBox(
      width: width ?? 66.0,
      height: height ?? 66.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget container = ClipRRect(
      borderRadius: imgBorderRadius ?? BorderRadius.circular(4),
      child: _buildImageContent(context),
    );
    if (autoSize != true) {
      container = Container(
        width: width ?? 66.0,
        height: height ?? 66.0,
        decoration: decoration ??
            BoxDecoration(
              borderRadius: imgBorderRadius ?? BorderRadius.circular(3),
              border: Border.all(
                  color: borderColor ?? ThemeColor.lineColor, width: 1.0),
            ),
        child: container,
      );
    }
    if (enlargeLook == false) {
      return container;
    }
    final previewUrl = _previewUrl;
    return GestureDetector(
      onTap: () {
        onTap?.call();
        if (previewUrl == null || previewUrl.isEmpty) {
          return;
        }
        Navigator.of(context).push<void>(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (_, __, ___) => ImageScreen(
              url: previewUrl,
              heroTag: _effectiveHeroTag,
            ),
          ),
        );
      },
      child: Hero(tag: _effectiveHeroTag, child: container),
    );
  }
}
