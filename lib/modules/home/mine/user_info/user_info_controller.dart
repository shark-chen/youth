import 'package:youth/base/base_controller.dart';
import 'package:youth/network/net/entry/user/user.dart';
import 'model/user_info_entity.dart';
import 'view_model/user_info_vm.dart';

/// FileName: user_info_controller
///
/// @Author 谌文
/// @Date 2026/3/16 22:51
///
/// @Description 用户信息模块-controller
class UserInfoController extends BaseController {
  UserInfoController({String? userId}) {
    vm.value.userId = userId;
  }

  /// vm
  Rx<UserInfoVM> vm = UserInfoVM().obs;

  @override
  void onInit() async {
    super.onInit();
    final userId = vm.value.userId;
    if (userId != null) {
      /// request -他人信息
      title = '用户资料';
      await requestOtherUserProfile(userId);
    } else {
      title = '我的资料';
      await requestUserProfile();
    }
  }

  /// mark - method
  ///
  /// 获取数据
  UserInfoEntity? get userInfo {
    return vm.value.userInfo;
  }

  /// mark - request
  ///
  /// 获取个人信息 · GET /api/user/profile
  Future<void> requestUserProfile() async {
    EasyLoading.show();
    final response = await Net.value<User>().requestUserInfo<UserInfoEntity>();
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

  /// mark - request
  ///
  /// 上传头像 · POST /api/user/avatar（multipart 字段 `file`）
  Future<void> requestUploadAvatar(String filePath, {String? filename}) async {
    if (vm.value.userId != null) {
      EasyLoading.showToast('仅可修改自己的头像');
      return;
    }
    if (filePath.isEmpty) {
      EasyLoading.showToast('请选择图片');
      return;
    }
    EasyLoading.show();
    final response = await Net.value<User>().requestUploadUserAvatarFromPath<
        dynamic>(filePath, filename: filename);
    EasyLoading.dismiss();
    if (response.succeed) {
      EasyLoading.showToast('上传成功');
      await requestUserProfile();
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
  }

  /// mark - push
  ///
  /// 关于 KellyChat
  Future<void> pushEditMineInfoPage() async {
    await Get.toNamed(Routes.editMineInfoPage);
  }
}
