import '../tripartite_library/get/app_route_observer.dart';
import 'base_page.dart';

/// FileName base_router_page
///
/// @Author 谌文
/// @Date 2025/2/6 14:13
///
/// @Description
// ignore: must_be_immutable
abstract class BaseRouterPage<T> extends BasePage<T> implements RouteAware {
  BaseRouterPage({super.key});

  /// 路由类型回调
  ValueChanged<RouteType>? routeTypeCallback;

  /// 安卓手机，添加底部按钮点击返回事件监控， iOS侧滑监控
  /// routerCallback: 实例：
  /// @override
  /// Widget build(BuildContext context) {
  ///    return buildRouter(() => Container()（写好的UI）);
  /// }
  /// onWillPop： 安卓手机底部按钮点击返回事件回调
  /// closeIosSideslip: 是否关闭iOS侧滑
  /// routeTypeCallback: 路由回调
  Widget routerObserver(
      BuildContext context,
      RouterCallback routerCallback, {
        WillPopCallback? onWillPop,
        bool? closeIosSideslip = false,
        ValueChanged<RouteType>? routeTypeCallback,
      }) {
    /// 添加iOS侧滑监控
    if (routeTypeCallback != null) {
      this.routeTypeCallback = routeTypeCallback;
      AppRouteObserver()
          .routeObserver
          .subscribe(this, ModalRoute.of(context)!); //订阅
    }
    if (closeIosSideslip == false && GetPlatform.isIOS) {
      return routerCallback.call();
    } else {
      /// WillPopScope截获 安卓手机底部返回按钮事件
      return WillPopScope(onWillPop: onWillPop, child: routerCallback.call());
    }
  }

  /// 取消路由监控订阅
  void unsubscribe() {
    if (routeTypeCallback != null) {
      AppRouteObserver().routeObserver.unsubscribe(this); //取消订阅
    }
  }

  /// Called when the top route has been popped off, and the current route
  /// shows up.
  @override
  void didPopNext() {
    routeTypeCallback?.call(RouteType.didPopNext);
  }

  /// Called when the current route has been pushed.
  @override
  void didPush() {
    routeTypeCallback?.call(RouteType.didPush);
  }

  /// Called when the current route has been popped off.
  @override
  void didPop() {
    routeTypeCallback?.call(RouteType.didPop);
  }

  /// Called when a new route has been pushed, and the current route is no
  /// longer visible.
  @override
  void didPushNext() {
    routeTypeCallback?.call(RouteType.didPushNext);
  }
}


