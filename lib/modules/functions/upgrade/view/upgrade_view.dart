import 'dart:io';
import '../../../../base/base_controller.dart';
import '../../../../base/base_page.dart';
import '../../../../network/downloader/stream_speed_assist.dart';
import '../../../../utils/router_observer/router_observer.dart';
import '../model/upgrade_config.dart';
import '../upgrade_tool.dart';

const _kAnimationDuration = 300;

/// 升级弹框
class UpgradeDialog extends StatefulWidget {
  final UpgradeConfig info;

  const UpgradeDialog({Key? key, required this.info}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UpgradeDialogState createState() => _UpgradeDialogState();
}

class _UpgradeDialogState extends State<UpgradeDialog>
    with TickerProviderStateMixin, RouterObserver {
  late AnimationController _controller;
  bool enterNewStatus = false;
  bool enterNewStatus2 = false;
  bool showContinue = false;

  @override
  void dispose() {
    super.dispose();
    UpgradeTool.updateFewDays();
  }

  // 下载进度
  double progress = 0.0;
  StreamSpeedAssist? speedAssist;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: _kAnimationDuration));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return routerObserver(
        context,
        () => Material(
              type: MaterialType.transparency,
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: _kAnimationDuration),
                  width: 320,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    color: Theme.of(context).dialogBackgroundColor,
                  ),
                  child: enterNewStatus

                      /// 下载APK进度条
                      ? _buildAndroidUpgradeProgress(context)

                      /// 升级提示框
                      : _buildUpgradeContent(context),
                ),
              ),
            ), onWillPop: () async {
      return !(widget.info.isForce ?? true);
    });
  }

  /// 下载APK进度条
  Widget _buildAndroidUpgradeProgress(BuildContext context) =>
      AnimatedContainer(
        duration: const Duration(milliseconds: _kAnimationDuration),
        height: enterNewStatus2 ? (showContinue ? 200 : 148) : 250,
        child: Stack(
          children: [
            /// 下载中断，继续下载按钮
            Positioned(
              top: 20,
              left: 16,
              right: 16,
              child: FadeTransition(
                opacity: _controller,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: showContinue
                        ? LocaleKeys.Failed.tr
                        : LocaleKeys.Downloading.tr,
                    style: const TextStyle(
                        color: ThemeColor.thickBlackColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ), // 标题
            Positioned(
              bottom: showContinue ? 87 : 34,
              left: 21,
              right: 21,
              child: FadeTransition(
                opacity: _controller,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      speedAssist?.getSpeedString() ?? '--kb/s',
                      style: TextStyle(
                          color: ThemeColor.versionColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    Visibility(
                      visible: true,
                      child: Text(
                        "${(progress * 100).toStringAsFixed(2)}%",
                        style: const TextStyle(
                            color: ThemeColor.thickBlackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ), // 网速进度
            AnimatedPositioned(
              onEnd: () {
                _controller.forward();
              },
              duration: const Duration(milliseconds: _kAnimationDuration),
              top: enterNewStatus2 ? 76 : 0,
              left: enterNewStatus2 ? 21 : 0,
              right: enterNewStatus2 ? 21 : 0,
              child: AnimationShaderMask(
                stops: const [1, 0],
                colors: [
                  (showContinue
                      ? ThemeColor.brightRedColor
                      : ThemeColor.greenColor),
                  ThemeColor.thinGrayColor,
                ],
                progress: progress,
                duration: const Duration(milliseconds: _kAnimationDuration),
                child: AnimatedContainer(
                  height: enterNewStatus2 ? 12 : 20,
                  duration: const Duration(milliseconds: _kAnimationDuration),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: enterNewStatus2
                          ? Colors.white
                          : ThemeColor.greenColor,
                      borderRadius:
                          BorderRadius.circular(enterNewStatus2 ? 12 : 0)),
                ),
              ),
            ), //下载进度条
            showContinue
                ? Positioned(
                    bottom: 52,
                    left: 0,
                    right: 0,
                    height: 1,
                    child: Container(
                      color: ThemeColor.lineColor,
                    ),
                  )
                : Container(),
            showContinue
                ? Positioned(
                    bottom: 0,
                    left: 21,
                    right: 21,
                    child: TextButton(
                        onPressed: () async {
                          await _onAndroidDownload();
                        },
                        child: Text(
                          LocaleKeys.TryAgain.tr,
                          style: const TextStyle(
                            color: ThemeColor.blueColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        )),
                  )
                : Container(),
          ],
        ),
      );

  /// 升级提示框
  Widget _buildUpgradeContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FadeTransition(
          opacity: _controller,
          child: SlideTransition(
            position: Tween<Offset>(
                    begin: const Offset(0, -0.5), end: const Offset(0, 0))
                .animate(_controller),
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Image.asset("assets/image/icons/upgrade_bg@3x.png"),
                if (widget.info.isForce == false)
                  IconButton(
                    icon: Image.asset("assets/image/icons/close@3x.png",
                        height: 28, width: 28),
                    onPressed: () {
                      UpgradeTool.updateFewDays();
                      Get.back();
                    },
                  ),
              ],
            ),
          ),
        ),
        FadeTransition(
          opacity: _controller,
          child: SlideTransition(
            position: Tween<Offset>(
                    begin: const Offset(0, -0.5), end: const Offset(0, 0))
                .animate(_controller),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.DiscoverNewVersion.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: ThemeColor.thickBlackColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w700),
                maxLines: 1,
              ),
            ),
          ),
        ),
        Container(
          height: 120,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          alignment: Alignment.topLeft,
          child: FadeTransition(
            opacity: _controller,
            child: SlideTransition(
              position: Tween<Offset>(
                      begin: const Offset(0, -0.5), end: const Offset(0, 0))
                  .animate(_controller),
              child: SingleChildScrollView(
                child: Text(widget.info.content ?? '',
                    style: const TextStyle(
                        color: ThemeColor.thickBlackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.6)),
              ),
            ),
          ),
        ),
        FadeTransition(
          opacity: _controller,
          child: Container(height: 26, color: Colors.white70),
        ),
        FadeTransition(
          opacity: _controller,
          child: SlideTransition(
            position: Tween<Offset>(
                    begin: const Offset(0, 0.5), end: const Offset(0, 0))
                .animate(_controller),
            child: Container(
              height: 48,
              width: 260,
              decoration: BoxDecoration(
                color: ThemeColor.darkBlueColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextButton(
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.resolveWith((states) {
                  return Colors.transparent;
                })),
                child: Text(LocaleKeys.UpdateNow.tr,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
                onPressed: () async {
                  if (Platform.isIOS || isGoogle) {
                    /// 跳转到苹果商城
                    UpgradeTool.openAppStore();
                    UpgradeTool.updateFewDays();
                  } else {
                    /// 安卓开始下载APK包
                    await _startProgressAnimation();
                    UpgradeTool.updateFewDays();
                  }
                },
              ),
            ),
          ),
        ),
        FadeTransition(
          opacity: _controller,
          child: Container(height: 36, color: Colors.white),
        ),
      ],
    );
  }

  /// 开始下载APK进度条UI
  Future _startProgressAnimation() async {
    showContinue = false;
    final future = _controller.reverse();
    future.whenComplete(() async {
      setState(() {
        enterNewStatus = true;
      });
      await _onAndroidDownload();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          enterNewStatus2 = true;
        });
      });
    });
  }

  /// 开始下载
  Future _onAndroidDownload() async {
    if (showContinue == true) {
      setState(() {
        showContinue = false;
      });
    }
    await widget.info.androidInfo.upgradeFromDownload(
        onReceiveProgress: (received, total, {StreamSpeedAssist? speedAssist}) {
      setState(() {
        progress = total == 0 ? 0.0 : (received / total);
        this.speedAssist = speedAssist;
      });
    }, onError: () {
      setState(() {
        showContinue = true;
      });
    });
  }
}

/// 动画
class AnimationShaderMask extends ImplicitlyAnimatedWidget {
  /// Creates a widget that animates its opacity implicitly.
  ///
  /// The [progress] argument must not be null and must be between 0.0 and 1.0,
  /// inclusive. The [curve] and [duration] arguments must not be null.
  const AnimationShaderMask({
    Key? key,
    this.child,
    required this.progress,
    required this.colors,
    this.stops,
    Curve curve = Curves.linear,
    required Duration duration,
    VoidCallback? onEnd,
    this.alwaysIncludeSemantics = false,
  })  : assert(progress >= 0.0 && progress <= 1.0),
        super(key: key, curve: curve, duration: duration, onEnd: onEnd);

  final Widget? child;
  final double progress;
  final bool alwaysIncludeSemantics;
  final List<Color> colors;
  final List<double>? stops;

  @override
  ImplicitlyAnimatedWidgetState<AnimationShaderMask> createState() =>
      _AnimationShaderMaskState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('progress', progress));
  }
}

class _AnimationShaderMaskState
    extends ImplicitlyAnimatedWidgetState<AnimationShaderMask> {
  Tween<double>? _progress;
  late Animation<double> _opacityAnimation;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _progress = visitor(_progress, widget.progress,
            (dynamic value) => Tween<double>(begin: value as double))
        as Tween<double>?;
  }

  @override
  void didUpdateTweens() {
    _opacityAnimation = animation.drive(_progress!);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacityAnimation,
      builder: (BuildContext context, Widget? child) {
        return ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(colors: widget.colors, stops: widget.stops)
                .createShader(Rect.fromLTWH(
                    0, 0, rect.width * _opacityAnimation.value, rect.height));
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
