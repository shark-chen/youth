import 'dart:async';
import 'dart:math';
import 'package:app_settings/app_settings.dart';
import 'package:youth/utils/extension/system_chromes/system_chromes.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/services.dart';
import '../../../generated/locales.g.dart';
import '../../../tripartite_library/gallery_savers/gallery_savers.dart';
import '../../../utils/extension/text_styles.dart';
import '../../../utils/marco/marco.dart';
import '../../alert/alert.dart';
import '../../bottom_alert/bottom_alert.dart';
import 'image_hero.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

/// FileName ImageScreen
///
/// @Author 谌文
/// @Date 2023/9/18 17:18
///
/// @Description 查看图片类
class ImageScreen extends StatefulWidget {
  const ImageScreen({
    Key? key,
    required this.url,
    required this.heroTag,
    this.downloadFn,
  }) : super(key: key);

  final String url;
  final String heroTag;
  final VoidCallback? downloadFn;

  @override
  State<StatefulWidget> createState() {
    return _ImageScreenState();
  }
}

class _ImageScreenState extends State<ImageScreen>
    with TickerProviderStateMixin {
  Animation<double>? _doubleClickAnimation;
  late VoidCallback _doubleClickAnimationListener;
  late AnimationController _doubleClickAnimationController;
  List<double> doubleTapScales = <double>[1.0, 2.0];
  double currentScale = 1.0;
  double fittedScale = 1.0;
  double initialScale = 1.0;
  GlobalKey<ExtendedImageSlidePageState> slidePagekey =
      GlobalKey<ExtendedImageSlidePageState>();

  GlobalKey<ExtendedImageGestureState> extendedImageGestureKey =
      GlobalKey<ExtendedImageGestureState>();

  void close() {
    slidePagekey.currentState!.popPage();
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    SystemChromes.setAllDirectionScreen();
    _doubleClickAnimationController = AnimationController(
        duration: const Duration(milliseconds: 150), vsync: this);
  }

  @override
  void dispose() {
    _doubleClickAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: ((context, orientation) {
        return Container(
          color: Colors.transparent,
          constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height,
          ),
          child: Stack(
            children: [
              /// 背景
              Positioned(
                top: 0,
                left: 0,
                bottom: 0,
                right: 0,
                child: ExtendedImageSlidePage(
                  key: slidePagekey,
                  slideAxis: SlideAxis.both,
                  slidePageBackgroundHandler: (Offset offset, Size size) {
                    if (orientation == Orientation.landscape) {
                      return Colors.black;
                    }
                    double opacity = 0.0;
                    opacity = offset.distance /
                        (Offset(size.width, size.height).distance / 2.0);
                    return Colors.black
                        .withOpacity(min(1.0, max(1.0 - opacity, 0.0)));
                  },
                  slideType: SlideType.onlyImage,
                  slideEndHandler: (
                    Offset offset, {
                    ExtendedImageSlidePageState? state,
                    ScaleEndDetails? details,
                  }) {
                    final vy = details?.velocity.pixelsPerSecond.dy ?? 0;
                    final oy = offset.dy;
                    if (vy > 300 || oy > 100) {
                      return true;
                    }
                    return null;
                  },
                  child: GestureDetector(
                    onTap: close,
                    onLongPress: pushSavePhotoWidget,
                    child: ExtendedImageGesturePageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: ExtendedPageController(
                        initialPage: 0,
                        pageSpacing: 0,
                        shouldIgnorePointerWhenScrolling: false,
                      ),
                      itemCount: 1,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return HeroWidget(
                          tag: widget.heroTag,
                          slidePagekey: slidePagekey,
                          child: ExtendedImage.network(
                            widget.url,
                            extendedImageGestureKey: extendedImageGestureKey,
                            enableSlideOutPage: true,
                            fit: BoxFit.contain,
                            initGestureConfigHandler: (state) {
                              return GestureConfig(
                                minScale: 0.8,
                                animationMinScale: 0.6,
                                maxScale: 2 * fittedScale,
                                animationMaxScale: 2.5 * fittedScale,
                                speed: 1.0,
                                inertialSpeed: 100.0,
                                initialScale: initialScale,
                                initialAlignment: InitialAlignment.topCenter,
                                hitTestBehavior: HitTestBehavior.opaque,
                              );
                            },
                            loadStateChanged: (ExtendedImageState state) {
                              switch (state.extendedImageLoadState) {
                                case LoadState.loading:
                                  return Container(
                                      color: Colors.black,
                                      child: const Center(
                                          child: CircularProgressIndicator(
                                              color: Colors.white)));
                                case LoadState.completed:
                                  final screenHeight =
                                      MediaQuery.of(context).size.height;
                                  final screenWidth =
                                      MediaQuery.of(context).size.width;
                                  final imgHeight =
                                      state.extendedImageInfo?.image.height ??
                                          1;
                                  final imgWidth =
                                      state.extendedImageInfo?.image.width ?? 0;
                                  final imgRatio = imgWidth / imgHeight;
                                  final screenRatio =
                                      screenWidth / screenHeight;
                                  final fitWidthScale = screenRatio / imgRatio;
                                  if (screenRatio > imgRatio) {
                                    // Long Image
                                    initialScale = fitWidthScale;
                                    fittedScale = fitWidthScale;
                                    doubleTapScales[1] = fitWidthScale;
                                  } else {
                                    fittedScale =
                                        1 / fitWidthScale; // fittedHeight
                                    doubleTapScales[1] = 1 / fitWidthScale;
                                  }
                                  break;
                                case LoadState.failed:
                                  return Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Image.asset(
                                          "assets/image/icons/image_placeholder@2x.png",
                                          fit: BoxFit.fill),
                                    ),
                                  );
                              }
                              return null;
                            },
                            onDoubleTap: (ExtendedImageGestureState state) {
                              ///you can use define pointerDownPosition as you can,
                              ///default value is double tap pointer down postion.
                              final Offset? pointerDownPosition =
                                  state.pointerDownPosition;
                              final double? begin =
                                  state.gestureDetails!.totalScale;
                              double end;

                              //remove old
                              _doubleClickAnimation?.removeListener(
                                  _doubleClickAnimationListener);

                              //stop pre
                              _doubleClickAnimationController.stop();

                              //reset to use
                              _doubleClickAnimationController.reset();

                              if (begin == doubleTapScales[0]) {
                                end = doubleTapScales[1];
                              } else {
                                end = doubleTapScales[0];
                              }

                              _doubleClickAnimationListener = () {
                                state.handleDoubleTap(
                                    scale: _doubleClickAnimation!.value,
                                    doubleTapPosition: pointerDownPosition);
                              };
                              _doubleClickAnimation =
                                  _doubleClickAnimationController.drive(
                                      Tween<double>(begin: begin, end: end));

                              _doubleClickAnimation!
                                  .addListener(_doubleClickAnimationListener);

                              _doubleClickAnimationController.forward();
                            },
                            mode: ExtendedImageMode.gesture,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              /// 底部的关闭图标按钮
              Positioned(
                left: 10,
                bottom: 50,
                child: IconButton(
                  icon: Image.asset(
                    'assets/image/icons/close@3x.png',
                    height: 35,
                    width: 35,
                  ),
                  color: Colors.white70,
                  iconSize: 35,
                  onPressed: close,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  /// push - 打开保存图片弹框
  Future pushSavePhotoWidget() async {
    return showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        builder: (BuildContext context) {
          return Container(
            width: screenWidth,
            height: 103 + bottomPadding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                    height: 50,
                    child: Text(LocaleKeys.Save.tr,
                        style: TextStyles(fontSize: 15)),
                  ),
                ),
                Container(
                    height: 3,
                    width: screenWidth,
                    color: Color(0xFF919099).withOpacity(0.2)),
                GestureDetector(
                  onTap: Get.back,
                  child: Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    height: 50,
                    child: Text(LocaleKeys.Cancel.tr,
                        style: TextStyles(fontSize: 15)),
                  ),
                ),
              ],
            ),
          );
        },
        context: context);
  }

}
