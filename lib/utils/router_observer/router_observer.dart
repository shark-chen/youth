import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';

typedef RouterCallback = Widget Function();

/// FileName router_observer
///
/// @Author 谌文
/// @Date 2024/3/8 10:28
///
/// @Description
class RouterObserver {
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
  }) {
    if (closeIosSideslip == false && GetPlatform.isIOS) {
      return routerCallback.call();
    } else {
      /// WillPopScope截获 安卓手机底部返回按钮事件
      return WillPopScope(onWillPop: onWillPop, child: routerCallback.call());
    }
  }
}
