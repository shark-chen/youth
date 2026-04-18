import 'package:youth/network/net/entry/user/user.dart';
import 'package:youth/network/net/net.dart';
import 'package:youth/network/net/net_result.dart';
import '../../user_info/model/user_info_entity.dart';
import '../edit_mine_info_controller.dart';
import '../model/user_private_info_entity.dart';
import 'package:youth/base/base_controller.dart';

/// FileName: edit_mine_info_request_controller
///
/// @Author 谌文
/// @Date 2026/4/16 16:20
///
/// @Description
extension EditMineInfoReuestController on EditMineInfoController {
  /// 获取当前登录用户的信息
  Future requestUserInfo() async {
    EasyLoading.show();
    final response = await Net.value<User>().cache<UserInfoEntity>((value) {
      vm.value.applyUserInfo(value);
      vm.refresh();
    }).requestUserInfo<UserInfoEntity>();
    EasyLoading.dismiss();
    if (response.succeed) {
      vm.value.applyUserInfo(response.value);
      vm.refresh();
    } else {
      EasyLoading.showToast(response.msg ?? LocaleKeys.NetworkError.tr);
    }
  }

  /// 获取用户私密信息 · GET /api/user/private
  Future<NetResult<dynamic>> requestUserPrivate() async {
    final response =
        await Net.value<User>().requestUserPrivate<UserPrivateInfoEntity>();
    if (response.succeed) {
      vm.value.userPrivateInfoEntity = response.value;
      vm.refresh();
    }
    return response;
  }

  /// 第一次设置私密
  /// 更新用户私密信息 · PUT /api/user/private
  Future<NetResult<dynamic>> requestUpdateUserPrivate({
    required String wishDescription,
    required String password,
     String? oldPassword,
  }) async {
    final response = await Net.value<User>().requestUpdateUserPrivate<dynamic>(
      wishDescription: wishDescription,
      password: password,
      oldPassword: oldPassword,
    );
    return response;
  }

  /// 修改私密信息中的密码 · PUT /api/user/private/password
  Future<NetResult<dynamic>> requestUpdateUserPrivatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final response =
        await Net.value<User>().requestUpdateUserPrivatePassword<dynamic>(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
    return response;
  }

  /// 上传图片 · POST /api/user/photo（multipart 字段 `file`）
  Future<NetResult<dynamic>> requestUploadPhoto({
    required String filePath,
    String? filename,
  }) async {
    final response = await Net.value<User>().requestUploadPhoto<dynamic>(
      filePath: filePath,
      filename: filename,
    );
    return response;
  }
}
