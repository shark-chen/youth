import 'package:youth/network/net/entry/user/user.dart';

import '../user_info_controller.dart';
import 'package:youth/base/base_controller.dart';

/// FileName: user_info_request_controller
///
/// @Author 谌文
/// @Date 2026/4/19 15:14
///
/// @Description 用户资料-请求-controller
extension UserInfoRequestController on UserInfoController {
  /// 拉黑用户
  /// POST /api/block/{blockedUserId}
  Future<bool> requestBlockUser({required String blockedUserId}) async {
    final id = blockedUserId.trim();
    if (id.isEmpty) {
      EasyLoading.showToast('用户无效');
      return false;
    }
    EasyLoading.show();
    final response = await Net.value<User>().requestBlockUser<dynamic>(
      blockedUserId: id,
    );
    EasyLoading.dismiss();
    if (response.success) {
      EasyLoading.showToast('已拉黑');
      vm.refresh();
      return true;
    } else {
      EasyLoading.showToast(response.msg ?? '');
      return false;
    }
  }
}