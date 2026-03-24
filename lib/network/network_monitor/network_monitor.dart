import 'package:youth/base/base_controller.dart';
import 'package:youth/config/environment_config/app_config.dart';
import 'package:youth/utils/marco/debug_print.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dart_ping_ios/dart_ping_ios.dart';
import 'package:dart_ping/dart_ping.dart';
import '../reporter/report_util.dart';
import 'model/network_status_model.dart';

/// FileName network_monitor
///
/// @Author 谌文
/// @Date 2023/9/15 10:04
///
/// @Description 网络监听类
class NetworkMonitor {
  static NetworkMonitor? _instance;

  NetworkMonitor._();

  factory NetworkMonitor() {
    _instance ??= NetworkMonitor._();
    return _instance!;
  }

  ConnectivityResult? connectivityResult;

  /// 网络状态
  Map<ConnectivityResult, NetworkStatusModel> networkMap = {
    ConnectivityResult.mobile: NetworkStatusModel(
        networkType: 'mobile', info: 'Mobile Network (4G/5G)'),
    ConnectivityResult.wifi:
        NetworkStatusModel(networkType: 'wifi', info: '手机连接了WiFi'),
    ConnectivityResult.vpn:
        NetworkStatusModel(networkType: 'vpn', info: '手机连接了VPN'),
    ConnectivityResult.bluetooth:
        NetworkStatusModel(networkType: 'bluetooth', info: '设备通过蓝牙连接'),
    ConnectivityResult.none:
        NetworkStatusModel(networkType: 'none', info: '设备未连接到任何网络'),
    ConnectivityResult.ethernet:
        NetworkStatusModel(networkType: 'ethernet', info: '有线网络'),
    ConnectivityResult.other:
        NetworkStatusModel(networkType: 'other', info: '设备连接到未知网络'),
  };

  /// 开始网络检测
  void startMonitor({bool? monitor = false}) {
    if (environment != Environment.prod || monitor == true) {
      try {
        /// 上报需要知道网络状态
        ReportUtil().listenNetworkMonitor();
        checkNetworkStatus();
        Connectivity().onConnectivityChanged.listen((result) {
          checkNetworkStatus();
        });
      } catch (_) {}
    }
  }

  /// 分析网络类型
  Future<void> checkNetworkStatus() async {
    connectivityResult = (await (Connectivity().checkConnectivity())).first;
    EventBusManager().fire(networkMap[connectivityResult]);
  }

  /// ping一下当前网络
  /// 由于ping会有多次回调，callbackOne： 表示回调一次还是全部回调
  Ping? _ping;

  Future ping({
    ValueChanged<NetworkStatusModel>? complete,
    bool? callbackOne,
    int? count = 1,
  }) async {
    try {
      if (isIOS) {
        DartPingIOS.register();
      }
      if (_ping != null) {
        await _ping?.stop();
        _ping = null;
      }
      _ping = Ping('www.bigseller.pro', count: count ?? 1);
      List list = [];
      _ping?.stream.listen((event) {
        list.add(event);
        var model = networkMap[connectivityResult];
        var result = NetworkStatusModel(
          networkType: model?.networkType ?? '',
          info: model?.info ?? '',
          networkStatus: list.toString(),
        );
        EventBusManager().fire(result);
        DebugPrint(list.toString());
        complete?.call(result);
        if (callbackOne ?? false) {
          complete = null;
        }
      });
    } catch (_) {}
  }
}
