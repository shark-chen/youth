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

  /// Hero / 大图预览共用：显式 tag 优先，否则用 URL 稳住 identity（避免 UniqueKey 每次 rebuild）
  String get _effectiveHeroTag =>
      (heroTag != null && heroTag!.isNotEmpty) ? heroTag! : imgUrl;

  static Widget _errorPlaceholder() {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Image.asset(
        'assets/image/common/hello@3x.png',
        fit: BoxFit.fill,
      ),
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

  @override
  Widget build(BuildContext context) {
    final logicalW = width ?? 66.0;
    final logicalH = height ?? 66.0;
    final dpr = MediaQuery.devicePixelRatioOf(context);
    final memW =
        autoSize == true ? null : (logicalW * dpr).round().clamp(1, 4096);
    final memH =
        autoSize == true ? null : (logicalH * dpr).round().clamp(1, 4096);

    Widget container = ClipRRect(
      borderRadius: imgBorderRadius ?? BorderRadius.circular(4),
      child: Strings.isNotEmpty(imgUrl)
          ? (autoSize == true
              ? _autoSizeCachedImage()
              : _fixedSizeImage(
                  context: context,
                  logicalW: logicalW,
                  logicalH: logicalH,
                  memW: memW!,
                  memH: memH!,
                ))
          : SizedBox(
              width: width ?? 66.0,
              height: height ?? 66.0,
            ),
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
    } else {
      return GestureDetector(
          onTap: () {
            onTap?.call();
            Navigator.of(context).push<void>(
              PageRouteBuilder(
                opaque: false, // set to false
                pageBuilder: (_, __, ___) => ImageScreen(
                  url: imgUrl,
                  heroTag: _effectiveHeroTag,
                ),
              ),
            );
          },
          child: Hero(tag: _effectiveHeroTag, child: container));
    }
  }
}
