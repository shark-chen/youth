import 'package:kellychat/network/net/entry/user/user.dart';

import '../model/user_info_entity.dart';
import '../user_info_controller.dart';
import 'package:kellychat/base/base_controller.dart';

/// FileName: user_info_request_controller
///
/// @Author 谌文
/// @Date 2026/4/19 15:14
///
/// @Description 用户资料-请求-controller
extension UserInfoRequestController on UserInfoController {
  /// 是否已拉黑 · GET /api/block/check/{blockedUserId}
  Future<bool> requestBlockCheck({
    required String blockedUserId,
  }) async {
    final id = blockedUserId.trim();
    if (id.isEmpty) {
      EasyLoading.showToast('用户无效');
      return false;
    }
    EasyLoading.show();
    final response =
        await Net.value<User>().requestBlockCheck<bool>(blockedUserId: id);
    EasyLoading.dismiss();
    return response.value ?? false;
  }

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

  /// 取消拉黑 · DELETE /api/block/{blockedUserId}
  Future<bool> requestUnblockUser({required String blockedUserId}) async {
    final id = blockedUserId.trim();
    if (id.isEmpty) {
      EasyLoading.showToast('用户无效');
      return false;
    }
    EasyLoading.show();
    final response = await Net.value<User>().requestUnblockUser<dynamic>(
      blockedUserId: id,
    );
    EasyLoading.dismiss();
    if (response.success) {
      EasyLoading.showToast('已取消拉黑');
      vm.refresh();
      return true;
    } else {
      EasyLoading.showToast(response.msg ?? '');
      return false;
    }
  }

  /// mark - request
  ///
  /// 获取个人信息 · GET /api/user/profile
  Future<void> requestUserProfile() async {
    EasyLoading.show();
    final response = await Net.value<User>().cache<UserInfoEntity>((value) {
      vm.value.configUserInfo(value);
      vm.refresh();
    }).requestUserInfo<UserInfoEntity>();
    EasyLoading.dismiss();
    if (response.succeed) {
      vm.value.configUserInfo(response.value);
      vm.refresh();
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }

  /// request -他人信息
  Future<void> requestOtherUserProfile(String userId) async {
    EasyLoading.show();
    final response = await Net.value<User>()
        .requestUserByUserId<UserInfoEntity>(userId: userId);
    EasyLoading.dismiss();
    if (response.succeed) {
      vm.value.configUserInfo(response.value);
      vm.refresh();
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }
}
