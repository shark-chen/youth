import 'dart:async';

/// FileName: timer_periodic
///
/// @Author 侯占峰
/// @Date 2026/1/4 16:32
///
/// @Description 周期性定时器
class PeriodicTimer {
  Timer? _timer;
  int _currentCount = 0;
  bool _isRunning = false;

  /// 开始周期性计时
  /// [interval] 间隔时间
  /// [callback] 每次执行的函数，参数是当前周期数
  /// [immediate] 是否立即执行第一次
  /// [maxCount] 最大执行次数，null表示无限
  void start({
    required Duration interval,
    required void Function(int count) callback,
    bool immediate = false,
    int? maxCount,
  }) {
    if (_isRunning) stop();

    _currentCount = 0;
    _isRunning = true;

    void execute() {
      if (!_isRunning) return;

      _currentCount++;

      // 检查是否达到最大次数
      if (maxCount != null && _currentCount > maxCount) {
        stop();
        return;
      }

      callback(_currentCount);
    }

    // 立即执行第一次
    if (immediate) execute();

    // 创建定时器
    _timer = Timer.periodic(interval, (_) {
      execute();
    });
  }

  /// 停止计时
  void stop() {
    _timer?.cancel();
    _timer = null;
    _isRunning = false;
  }

  /// 暂停（继续时从当前计数继续）
  void pause() {
    _timer?.cancel();
    _timer = null;
    _isRunning = false;
  }

  /// 继续
  void resume({
    required Duration interval,
    required void Function(int count) callback,
    int? maxCount,
  }) {
    if (!_isRunning) {
      start(
        interval: interval,
        callback: callback,
        immediate: false,
        maxCount: maxCount,
      );
    }
  }

  /// 获取当前周期数
  int get currentCount => _currentCount;

  /// 是否正在运行
  bool get isRunning => _isRunning;

  /// 销毁资源
  void dispose() {
    stop();
  }
}
