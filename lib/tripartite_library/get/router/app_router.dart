import 'package:youth/modules/routes/route_detect/route_detect.dart';
import 'package:get/get.dart';

/// FileName Router
///
/// @Author 谌文
/// @Date 2023/11/28 13:28
///
/// @Description 路由截获
class AppRouter {
  /// Pushes a new named `page` to the stack.
  static Future<T?>? toNamed<T>(
    String page, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) async {
    if (await RouterDetect.detect(page)) {
      return Get.toNamed(page,
          arguments: arguments,
          id: id,
          preventDuplicates: preventDuplicates,
          parameters: parameters);
    }
    return null;
  }
}
