import 'package:youth/tripartite_library/camera/cameras.dart';

/// FileName: scan_count_down_view
///
/// @Author 谌文
/// @Date 2026/1/6 10:20
///
/// @Description 扫描倒数view
// ignore: must_be_immutable
class ScanCountdownView extends StatefulWidget {
  ScanCountdownView({
    required this.milliseconds,
    this.countdownCompleted,
  });

  /// 倒计时 毫秒
  int milliseconds = 1000;

  /// 倒计完成回调
  VoidCallback? countdownCompleted;

  @override
  _ScanCountdownViewState createState() =>
      _ScanCountdownViewState(milliseconds, countdownCompleted);
}

class _ScanCountdownViewState extends State<ScanCountdownView>
    with TickerProviderStateMixin {
  int _milliseconds;

  /// 倒计完成回调
  VoidCallback? _countdownCompleted;

  _ScanCountdownViewState(this._milliseconds, this._countdownCompleted);

  late AnimationController _controller;
  late String _countdownText;

  @override
  void initState() {
    super.initState();
    _countdownText = (_milliseconds * 1.0 / 1000).toString();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..addListener(() {
        setState(() {
          if (_controller.isCompleted) {
            if (_milliseconds > 0) {
              _milliseconds = _milliseconds - 500;
              _countdownText = (_milliseconds * 1.0 / 1000).toString();
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
    return Visibility(
      visible: !EasyLoading.isShow,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: (topPadding / 2 + 22 + bottomPadding /2)),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(6),
            ),
            padding: EdgeInsets.only(left: 24, right: 24, top: 14, bottom: 14),
            child: Text(
              LocaleKeys.scanCoolingDownPleaseWait.tr
                  .replaceAll('{num}', _countdownText),
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: (topPadding / 2 + 22 + bottomPadding /2))
        ],
      ),
    );
  }
}
