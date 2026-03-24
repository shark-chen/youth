import 'dart:async';

/// 网络及预计下载时间工具类
class StreamSpeedAssist {
  int maxLength = 0;
  int currentLength = 0;
  int lastCurrentLength = 0;
  int lastTime = DateTime.now().millisecondsSinceEpoch;
  /// 当前下载速度
  double speed = 0.0;
  /// 预计完成时间
  double planTime = 0.0;

  StreamSpeedAssist() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      handlerDownloadRunning();
    });
  }

  /// 计算网络和预计下载市场
  void handlerDownloadRunning() {
    if (currentLength - lastCurrentLength > 0) {
      speed = ((currentLength - lastCurrentLength) * 1000.0 / (DateTime.now().millisecondsSinceEpoch - lastTime)) / 1024;
      // 计划完成时间
      if(speed > 1) {
        planTime = (maxLength - currentLength) / (speed * 1024.0);
      }
      lastCurrentLength = currentLength;
      lastTime = DateTime.now().millisecondsSinceEpoch;
    } else {
      speed = 0.0;
    }
  }

  /// 获取网速
  String getSpeedString() {
    double speeding = speed;
    String unit = 'kb/s';
    String result = speeding.toStringAsFixed(2);
    if (speeding > 1024 * 1024) {
      unit = 'gb/s';
      result = (speeding / (1024 * 1024)).toStringAsFixed(2);
    } else if (speeding > 1024) {
      unit = 'mb/s';
      result = (speeding / 1024).toStringAsFixed(2);
    }
    return '$result$unit';
  }
}