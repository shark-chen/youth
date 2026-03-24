import 'dart:async';
import 'package:event_bus/event_bus.dart';

/// FileName event_bus_manager
///
/// @Author 谌文
/// @Date 2023/6/19 13:51
///
/// @Description 广播中心类 + 监听者销毁时 一定要取消监听
class EventBusManager {
  static EventBusManager? _instance;

  /// 消息通道
  final _eventBus = EventBus();

  factory EventBusManager() {
    _instance ??= EventBusManager._();
    return _instance!;
  }

  EventBusManager._();

  /// {listen: {T: subscription}}
  /// listen: 标题监听者
  /// T: 监听者监听的类型
  /// subscription: 监听管道
  final Map<dynamic, Map<dynamic, dynamic>> _listenMap = {};

  /// 发送通知
  void fire(event) {
    if (event == null) return;
    _eventBus.fire(event);
  }

  /// 监听通知
  /// listen: 监听者
  /// onData:监听的结果回调
  StreamSubscription<T> listen<T>(
    dynamic listen,
    void Function(T event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    StreamSubscription<T> subscription = _eventBus
        .on<T>()
        .listen(onData, onError: onError, cancelOnError: cancelOnError);
    if (_listenMap[listen] == null) {
      _listenMap[listen] = {T: subscription};
    } else {
      _listenMap[listen]?[T] = subscription;
    }
    return subscription;
  }

  /// 取消监听者监听
  void cancel(dynamic listen) async {
    Map<dynamic, dynamic>? map = _listenMap[listen];
    if (map != null) {
      map.forEach((key, value) async {
        await value.cancel();
      });
      _listenMap.remove(listen);
    }
  }
}
