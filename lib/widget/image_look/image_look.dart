import 'package:youth/tripartite_library/tripartite_library.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
              placeholder: (context, url) => Padding(
                padding: EdgeInsets.all(3),
                child: Image.asset(
                  "assets/image/common/hello@3x.png",
                  fit: BoxFit.fill,
                ),
              ),
              errorWidget: (context, url, error) => Padding(
                padding: EdgeInsets.all(3),
                child: Image.asset(
                  "assets/image/common/hello@3x.png",
                  fit: BoxFit.fill,
                ),
              ),
            )
          : SizedBox(
              width: width ?? 66.0,
              height: height ?? 66.0,
              child: Image.asset(
                "assets/image/common/hello@3x.png",
                fit: BoxFit.fill,
              ),
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
