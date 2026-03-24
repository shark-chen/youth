import 'package:flutter/animation.dart';

class ScanAnimation {
  /// 起始之间的线性插值器 从 0.05 到 0.95 百分比。
  Tween<double>? rotationTween;
  late Animation? animation;
  AnimationController? animationController;
  late TickerProvider vsync;

  ScanAnimation(
      {required this.vsync,
      this.animation,
      this.animationController,
      this.rotationTween}) {
    rotationTween = Tween(begin: 0.25, end: 0.75);
    _initAnimal();
  }

  void _initAnimal() {
    if (animationController == null ||
        animationController!.toStringDetails().contains("DISPOSED")) {
      animationController = AnimationController(
        vsync: vsync,
        duration: const Duration(milliseconds: 2000), //动画时间 3s
      );
    }
    animation = rotationTween?.animate(animationController!)
      ?..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            animationController?.repeat();
          } else if (status == AnimationStatus.dismissed) {
            animationController?.forward();
          }
        },
      );
    animationController?.repeat();
  }

  void dealloc() {
    animationController?.dispose();
    animationController = null;
  }
}
