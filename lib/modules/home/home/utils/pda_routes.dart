import 'package:youth/utils/marco/marco.dart';
import '../../../routes/app_pages.dart';
import '../../../user/user_center/user_center.dart';

/// FileName pda_routes
///
/// @Author 谌文
/// @Date 2023/8/2 13:26
///
/// @Description pda路由管理类
class PdaRoutes {
  static final PdaRoutes _instance = PdaRoutes._();

  factory PdaRoutes() => _instance;

  PdaRoutes._();

  /// 兼容PDA
  Map<String, String> routes = {
    /// 扫描查单
    Routes.scanOrder: Routes.pdaScanOrder,

    /// 扫描发货
    Routes.promptlyShipments: Routes.padPromptlyShipments,
  };

  /// 开启了PDA扫描的话,重定向路由
  Future<String> pageName(String pageName) async {
    /// 是否是大于等于10英寸大小的iPad
    if (pageName.contains(Routes.posOrderPage) && isLandscapePad) {
      return Routes.posLandscapeOrderPage;
    }
    if (!routes.containsKey(pageName)) return pageName;
    bool isCamera = UserCenter().isCamera;
    if (!isCamera) {
      return routes[pageName] ?? pageName;
    }
    return pageName;
  }
}
