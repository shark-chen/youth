import 'package:youth/base/base_controller.dart';
import '../../user/user_center/authority/authority.dart';

/// FileName route_detect
///
/// @Author 谌文
/// @Date 2023/11/13 11:29
///
/// @Description 路由检测+ 包含检测参数或者路由跳转条件
class RouterDetect {
  /// 路由检测
  static Future<bool> detect(String? routeName) async {
    /// 获取当前路由名
    String path = RouterDetect.getRouteName(routeName ?? '');
    return true;
  }

  /// 获取当前路由名
  static String getRouteName(String name) {
    if (name == '/') return name;
    Uri uri = Uri.parse(name);
    return '/${uri.pathSegments.last}';
  }
}
