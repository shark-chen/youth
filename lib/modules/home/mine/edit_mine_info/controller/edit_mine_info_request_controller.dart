import 'package:kellychat/network/net/entry/user/user.dart';
import 'package:kellychat/network/net/net_result.dart';
import 'package:kellychat/network/net/util/upload_image_result_util.dart';
import '../../user_info/model/user_info_entity.dart';
import '../edit_mine_info_controller.dart';
import '../model/image_links_entity.dart';
import '../model/user_private_info_entity.dart';
import 'package:kellychat/base/base_controller.dart';

/// FileName: edit_mine_info_request_controller
///
/// @Author 谌文
/// @Date 2026/4/16 16:20
///
/// @Description
extension EditMineInfoReuestController on EditMineInfoController {
  /// request - 上传图片
  Future<ImageLinksEntity?> requestUploadPhoto(String path) async {
    if (Strings.isEmpty(path)) return null;
    EasyLoading.show();
    final response =
        await Net.value<User>().requestUploadPhoto<ImageLinksEntity>(
      path,
      filename: path.split('/').last,
    );
    EasyLoading.dismiss();
    final entity = UploadImageResultUtil.parse(response);
    if (entity != null) return entity;
    EasyLoading.showToast(UploadImageResultUtil.failureMessage(response));
    return null;
  }

  /// request - 上传头像
  Future<ImageLinksEntity?> requestUploadUserAvatar(String path) async {
    if (Strings.isEmpty(path)) return null;
    EasyLoading.show();
    try {
      final response =
          await Net.value<User>().requestUploadUserAvatar<ImageLinksEntity>(
        path,
        filename: path.split('/').last,
      );
      final entity = UploadImageResultUtil.parse(response);
      if (entity != null) return entity;
      EasyLoading.showToast(UploadImageResultUtil.failureMessage(response));
      return null;
    } finally {
      EasyLoading.dismiss();
    }
  }

  /// request - 获取用户信息
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
      EasyLoading.showToast(response.msg ?? '网络错误');
    }
  }

  /// request - 更新用户标签（最多10个）
  Future<bool> requestUpdateUserTags({
    required List<String> tags,
    bool? showLoad = true,
  }) async {
    if (true == showLoad) EasyLoading.show();
    final response = await Net.value<User>().requestUpdateUserTags(tags: tags);
    EasyLoading.dismiss();
    if (response.success) {
      vm.refresh();
      return true;
    } else {
      EasyLoading.showToast(response.msg ?? '');
      return false;
    }
  }

  /// request - 更新照片墙
  Future<bool> requestUpdateUserPhotos({
    required List<String> photos,
    bool? showLoad = true,
  }) async {
    if (true == showLoad) EasyLoading.show();
    final response = await Net.value<User>().requestUpdateUserPhotos<dynamic>(
      photos: photos,
    );
    if (true == showLoad) EasyLoading.dismiss();
    if (response.success) {
      vm.refresh();
      return true;
    } else {
      if (true == showLoad) EasyLoading.showToast(response.msg ?? '');
      return false;
    }
  }

  /// request - 获取用户私密信息
  Future<NetResult<dynamic>> requestUserPrivate() async {
    EasyLoading.show();
    final response =
        await Net.value<User>().requestUserPrivate<UserPrivateInfoEntity>();
    EasyLoading.dismiss();
    if (response.success) {
      vm.value.userPrivateInfoEntity = response.value;
      vm.refresh();
    }
    return response;
  }

  /// request - 验证私密信息密码
  Future<bool> requestUserPrivateVerify({
    required String password,
  }) async {
    EasyLoading.show();
    final response = await Net.value<User>()
        .requestUserPrivateVerify<String>(password: password);
    EasyLoading.dismiss();
    if (response.success) {
      vm.value.userPrivateInfoEntity?.wishDescription = response.value;
      return true;
    } else {
      EasyLoading.showToast(response.msg ?? '');
      return false;
    }
  }

  /// request - 修改私密信息中的密码
  Future<bool> requestUpdateUserPrivatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    EasyLoading.show();
    final response =
        await Net.value<User>().requestUpdateUserPrivatePassword<dynamic>(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
    EasyLoading.dismiss();
    if (response.success) {
      EasyLoading.showToast('修改成功');
      return true;
    } else {
      EasyLoading.showToast(response.msg ?? '');
      return false;
    }
  }

  /// request - 重置私密信息密码
  Future<bool> requestUserPrivateResetPassword() async {
    EasyLoading.show();
    final response = await Net.value<User>().requestUserPrivateResetPassword();
    EasyLoading.dismiss();
    if (response.success) {
      EasyLoading.showToast('重置成功');
      vm.value.userPrivateInfoEntity?.wishDescription = '';
      vm.value.userPrivateInfoEntity?.hasPassword = false;
      vm.refresh();
      return true;
    } else {
      EasyLoading.showToast(response.msg ?? '');
      return false;
    }
  }

  /// request - 落库：先头像再 PUT 资料
  Future<bool> requestSavePersistProfile() async {
    EasyLoading.show(status: '提交中...');
    final response = await Net.value<User>().requestUpdateUserInfo<dynamic>(
      avatar: vm.value.draft.avatarUrl,
      nickname: vm.value.draft.nickname,
      gender: vm.value.draft.gender,
      birthday: vm.value.draft.birthday,
      province: vm.value.draft.province,
      city: vm.value.draft.city,
      district: vm.value.draft.district,
      signature: vm.value.signatureController.text,
    );
    EasyLoading.dismiss();
    if (response.success) {
      EasyLoading.showToast('提交成功');
      return true;
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
    return false;
  }
}
