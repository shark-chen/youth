import 'package:kellychat/base/base_bindings.dart';
import 'package:kellychat/utils/utils/click_utils.dart';
import 'package:flutter/material.dart';

/// FileName: drawer_get_page
///
/// @Author 谌文
/// @Date 2025/11/25 18:35
///
/// @Description 专业版 GetPage —— 可自定义各种半屏 / 抽屉效果
class DrawerGetPage extends GetPage {
  /// 返回 true 表示使用抽屉效果，false 表示使用原有过渡
  static bool Function()? isTabletCallback;

  /// useDrawer: 手动控制是否使用抽屉效果
  DrawerGetPage({
    required String name,
    required Widget Function() page,
    Bindings? binding,
    List<GetMiddleware>? middlewares,
    bool? opaque = false,
    bool? popGesture = true,
    Transition? transition,
    bool? useDrawer,
    bool Function()? defineDrawer,
    VoidCallback? backTap,
  }) : super(
          name: name,
          page: page,
          binding: binding,
          middlewares: middlewares,
          opaque: opaque ?? false,
          popGesture: popGesture,
          customTransition: (useDrawer ??
                  _shouldUseDrawerTransition(useDrawer, defineDrawer))
              ? CustomDrawerTransition(transition: transition, backTap: backTap)
              : null,
          transitionDuration: const Duration(milliseconds: 300),
          transition: transition,
        );

  /// 判断是否使用抽屉过渡效果
  /// defineDrawer: 自定义什么样的是iPad，需要抽屉
  static bool _shouldUseDrawerTransition(
    bool? useDrawer,
    bool Function()? defineDrawer,
  ) {
    /// 如果明确指定了 useDrawer，则优先使用
    if (useDrawer != null) return useDrawer;

    /// 如果用户设置了自定义判断回调，则使用回调结果  单个
    if (defineDrawer != null) return defineDrawer.call();

    /// 如果用户设置了自定义判断回调，则使用回调结果  全局
    if (isTabletCallback != null) return isTabletCallback?.call() ?? false;

    /// 默认使用屏幕尺寸判断（可选的默认逻辑）
    return isLandscapePad;
  }
}

/// 自动以动画
class CustomDrawerTransition extends CustomTransition {
  CustomDrawerTransition({
    this.transition,
    this.backTap,
  });

  /// 专场动画
  final Transition? transition;

  /// 背景点击事件
  final VoidCallback? backTap;

  @override
  Widget buildTransition(
    BuildContext context,
    Curve? curve,
    Alignment? alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final drawerAlignment = getAlignment();
    final tween = getTween(drawerAlignment);
    return Stack(
      children: [
        /// 半透明背景
        GestureDetector(
          onTap: ClickUtils.debounce(backTap ?? Get.back),
          child: Container(color: Colors.black54),
        ),

        /// 抽屉内容
        SlideTransition(
          position: tween.animate(CurvedAnimation(
            parent: animation,
            curve: curve ?? Curves.easeOut,
          )),
          child: Align(
            alignment: drawerAlignment,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.45,
              child: child,
            ),
          ),
        ),
      ],
    );
  }

  /// 获取动画防线
  Tween<Offset> getTween(Alignment alignment) {
    final alignment = getAlignment();

    /// 动画从上往下- 抽屉在上面
    if (alignment == Alignment.topCenter ||
        alignment == Alignment.topLeft ||
        alignment == Alignment.topRight) {
      return Tween<Offset>(
        begin: const Offset(0.0, -1.0),
        end: Offset.zero,
      );
    } else if (alignment == Alignment.bottomCenter ||
        alignment == Alignment.bottomLeft ||
        alignment == Alignment.bottomRight) {
      /// 动画从下往上- 抽屉在下面
      return Tween<Offset>(
        begin: const Offset(0.0, 1.0),
        end: Offset.zero,
      );
    } else if (alignment == Alignment.centerLeft) {
      /// 动画从左到右- 抽屉在左边
      return Tween<Offset>(
        begin: const Offset(-1.0, 0.0),
        end: Offset.zero,
      );
    } else if (alignment == Alignment.centerRight) {
      /// 动画从右到左- 抽屉在右边
      return Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      );
    }
    return Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    );
  }

  /// 抽屉方向
  Alignment getAlignment() {
    switch (transition) {
      case Transition.rightToLeft:
      case Transition.fade:
      case Transition.fadeIn:
      case Transition.rightToLeftWithFade:
      case Transition.zoom:
      case Transition.noTransition:
      case Transition.cupertino:
      case Transition.size:
      case Transition.circularReveal:
      case Transition.native:
      case null:
        return Alignment.centerRight;
      case Transition.leftToRight:
      case Transition.leftToRightWithFade:
        return Alignment.centerLeft;
      case Transition.upToDown:
      case Transition.topLevel:
        return Alignment.topCenter;
      case Transition.downToUp:
      case Transition.cupertinoDialog:
        return Alignment.bottomCenter;
    }
  }
}
