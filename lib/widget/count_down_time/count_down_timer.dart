import 'package:flutter/material.dart';

/// FileName count_down_timer
///
/// @Author 谌文
/// @Date 2025/6/26 17:18
///
/// @Description 大屏倒计时
// ignore: must_be_immutable
class CountdownTimer extends StatefulWidget {
  CountdownTimer({
    required this.countdown,
    this.countdownCompleted,
  });

  /// 倒计时
  int countdown = 3;

  /// 倒计完成回调
  VoidCallback? countdownCompleted;

  @override
  _CountdownTimerState createState() => _CountdownTimerState(countdown, countdownCompleted);
}

class _CountdownTimerState extends State<CountdownTimer>
    with TickerProviderStateMixin {
  int _countdown;

  /// 倒计完成回调
  VoidCallback? _countdownCompleted;

  _CountdownTimerState(this._countdown, this._countdownCompleted);

  late AnimationController _controller;
  late String _countdownText;

  @override
  void initState() {
    super.initState();
    _countdownText = _countdown.toString();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..addListener(() {
        setState(() {
          if (_controller.isCompleted) {
            if (_countdown > 0) {
              _countdown--;
              _countdownText = _countdown.toString();
              _controller.reset();
              _controller.forward();
            } else {
              _countdownCompleted?.call();
            }
          }
        });
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final scaleValue =
              Tween<double>(begin: 1.5, end: 1).animate(_controller);
          var opacity = (0.55 + (scaleValue.value - 1) * 0.45);
          opacity = opacity > 1 ? 1 : ((opacity < 0) ? 0 : opacity);
          return Transform.scale(
            scale: scaleValue.value,
            child: Text(
              _countdownText,
              style: TextStyle(
                color: Colors.white.withOpacity(opacity),
                fontSize: (100 + (scaleValue.value - 1) * 40),
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        },
      ),
    );
  }
}
