import '../../../../config/environment_config/app_config.dart';
import '../../../../tripartite_library/store/preferences.dart';
import '../../../../utils/stores/stores.dart';
import 'network_model.dart';

/// FileName network_model_utils
///
/// @Author 谌文
/// @Date 2023/10/8 20:15
///
/// @Description 网络数据处理类
/// 黑名单
var blackSet = {
  '/cgi-bin/webhook/send',
  'https://qyapi.weixin.qq.com',
};

class NetworkModelUtils {
  static final NetworkModelUtils _instance = NetworkModelUtils._();

  factory NetworkModelUtils() => _instance;

  NetworkModelUtils._();

  List<NetworkModel> netDataLists = <NetworkModel>[];

  bool? isOpen;

  /// 摇一摇是否打开（正式环境下，是大关闭的，此值不在生效）
  Future<bool> get open async {
    isOpen ??= await Stores()
            .get<bool>(UserConfigEnum.shakeLookNetWork, userLat: false) ??
        true;
    return isOpen ?? true;
  }

  void setOpen(bool open) {
    isOpen = open;
    Stores().put<bool>(UserConfigEnum.shakeLookNetWork, open, userLat: false);
  }

  ///悬浮API是否开启
  bool? apiIsOpen;

  /// 悬浮API是否打开（正式环境下，是大关闭的，此值不在生效）
  Future<bool> get apiOpen async {
    apiIsOpen ??= await Stores().get<bool>('apiIsOpenKey') ?? true;
    print(await Stores().get<bool>('apiIsOpenKey') ?? true);
    return apiIsOpen ?? true;
  }

  void setApiOpen(bool open) {
    apiIsOpen = open;
    Stores().put<bool>('apiIsOpenKey', open);
  }

  /// 添加网络数据
  /// baseUrl - 域名
  /// path - path
  /// succeed 网络成功或者失败
  /// requestParameters 请求参数
  /// responseParameters 响应数据
  /// other 其他
  void addNetworkData({
    String? baseUrl,
    String? path,
    bool? succeed,
    String? requestParameters,
    String? responseParameters,
    String? other,
  }) async {
    if (blackSet.contains(path) || blackSet.contains(baseUrl)) return;
    if (AppConfig.env == Environment.dev ||
        AppConfig.env == Environment.alpha) {
      if (!(await open)) return;
      if (netDataLists.length > 200) {
        netDataLists.removeRange(200, netDataLists.length);
      }
      netDataLists.insert(
        0,
        NetworkModel(
            title: path,
            time: DateTime.now().toLocal().toString(),
            succeed: succeed,
            requestParameters: requestParameters,
            responseParameters: responseParameters,
            other: other),
      );
    }
  }
}
