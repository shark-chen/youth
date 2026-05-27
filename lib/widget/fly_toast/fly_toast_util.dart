import 'package:flutter/material.dart';
import 'package:kellychat/utils/utils/theme_color.dart';

/// 从指定屏幕坐标飞入至屏幕中心的胶囊 Toast 工具
class FlyToastUtil {
  FlyToastUtil._();

  static OverlayEntry? _entry;
  static _FlyToastOverlayState? _activeState;

  /// 读取 [key] 对应组件在屏幕上的中心点；无法测量时返回 `null`
  static Offset? globalCenterFromKey(GlobalKey key) {
    final box = key.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return null;
    final topLeft = box.localToGlobal(Offset.zero);
    return topLeft + Offset(box.size.width / 2, box.size.height / 2);
  }

  /// 从 [startCenter]（屏幕坐标）飞入至屏幕中心并展示 [message]
  static void show(
    BuildContext context, {
    required Offset startCenter,
    required String message,
    Color? backgroundColor,
    Color? textColor,
    Duration flyDuration = const Duration(milliseconds: 380),
    Duration stayDuration = const Duration(milliseconds: 2000),
    Duration fadeOutDuration = const Duration(milliseconds: 260),
  }) {
    final bg = backgroundColor ?? ThemeColor.themeGreenColor;
    final fg = textColor ?? ThemeColor.whiteColor;
    _dismiss();
    final overlay = Overlay.of(context, rootOverlay: true);
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (ctx) => _FlyToastOverlay(
        startCenter: startCenter,
        message: message,
        backgroundColor: bg,
        textColor: fg,
        flyDuration: flyDuration,
        stayDuration: stayDuration,
        fadeOutDuration: fadeOutDuration,
        onDismiss: () {
          if (_entry == entry) {
            entry.remove();
            _entry = null;
            _activeState = null;
          }
        },
        onReady: (state) {
          _activeState = state;
          state.play();
        },
      ),
    );
    _entry = entry;
    overlay.insert(entry);
  }

  static void dismiss() => _dismiss();

  static void _dismiss() {
    _activeState?.dismiss(immediate: true);
    _entry?.remove();
    _entry = null;
    _activeState = null;
  }
}

class _FlyToastOverlay extends StatefulWidget {
  const _FlyToastOverlay({
    required this.startCenter,
    required this.message,
    required this.backgroundColor,
    required this.textColor,
    required this.flyDuration,
    required this.stayDuration,
    required this.fadeOutDuration,
    required this.onDismiss,
    required this.onReady,
  });

  final Offset startCenter;
  final String message;
  final Color backgroundColor;
  final Color textColor;
  final Duration flyDuration;
  final Duration stayDuration;
  final Duration fadeOutDuration;
  final VoidCallback onDismiss;
  final void Function(_FlyToastOverlayState state) onReady;

  @override
  State<_FlyToastOverlay> createState() => _FlyToastOverlayState();
}

class _FlyToastOverlayState extends State<_FlyToastOverlay>
    with TickerProviderStateMixin {
  final GlobalKey _bubbleKey = GlobalKey();

  late final AnimationController _flyController;
  late final AnimationController _fadeController;
  late final Animation<double> _flyProgress;
  late final Animation<double> _scale;
  late final Animation<double> _flyOpacity;

  Size? _bubbleSize;

  @override
  void initState() {
    super.initState();
    _flyController = AnimationController(
      vsync: this,
      duration: widget.flyDuration,
    );
    final flyCurve = CurvedAnimation(
      parent: _flyController,
      curve: Curves.easeOutCubic,
    );
    _flyProgress = flyCurve;
    _scale = Tween<double>(begin: 0.85, end: 1).animate(flyCurve);
    _flyOpacity = Tween<double>(begin: 0, end: 1).animate(flyCurve);

    _fadeController = AnimationController(
      vsync: this,
      duration: widget.fadeOutDuration,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measureAndStart();
    });
  }

  void _measureAndStart() {
    final box = _bubbleKey.currentContext?.findRenderObject() as RenderBox?;
    void startFly() => widget.onReady(this);
    if (box != null && box.hasSize) {
      setState(() => _bubbleSize = box.size);
      WidgetsBinding.instance.addPostFrameCallback((_) => startFly());
    } else {
      startFly();
    }
  }

  Offset _screenCenter(BuildContext context) {
    final media = MediaQuery.of(context);
    final height = media.size.height - media.padding.top - media.padding.bottom;
    return Offset(
      media.size.width / 2,
      media.padding.top + height / 2,
    );
  }

  Future<void> play() async {
    if (!mounted) return;
    await _flyController.forward();
    if (!mounted) return;
    await Future<void>.delayed(widget.stayDuration);
    if (!mounted) return;
    await dismiss();
  }

  Future<void> dismiss({bool immediate = false}) async {
    if (!mounted) return;
    if (immediate) {
      _flyController.stop();
      _fadeController.stop();
      widget.onDismiss();
      return;
    }
    await _fadeController.forward();
    if (mounted) {
      widget.onDismiss();
    }
  }

  @override
  void dispose() {
    _flyController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  Widget _buildBubble(BuildContext context) {
    final maxWidth = MediaQuery.sizeOf(context).width - 48;
    return Material(
      color: Colors.transparent,
      child: Container(
        key: _bubbleKey,
        constraints: BoxConstraints(maxWidth: maxWidth),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          widget.message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: widget.textColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.3,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final endCenter = _screenCenter(context);
    final size = _bubbleSize ?? Size.zero;
    final hasSize = _bubbleSize != null;

    return Positioned.fill(
      child: IgnorePointer(
        child: AnimatedBuilder(
          animation: Listenable.merge([_flyController, _fadeController]),
          builder: (context, child) {
            final flyT = hasSize ? _flyProgress.value : 0.0;
            final center = Offset.lerp(widget.startCenter, endCenter, flyT)!;
            final opacity = hasSize
                ? _flyOpacity.value * (1 - _fadeController.value)
                : 0.0;
            final scale = hasSize ? _scale.value : 0.85;

            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: center.dx - size.width / 2,
                  top: center.dy - size.height / 2,
                  child: Opacity(
                    opacity: opacity.clamp(0.0, 1.0),
                    child: Transform.scale(
                      scale: scale,
                      child: child,
                    ),
                  ),
                ),
              ],
            );
          },
          child: _buildBubble(context),
        ),
      ),
    );
  }
}
