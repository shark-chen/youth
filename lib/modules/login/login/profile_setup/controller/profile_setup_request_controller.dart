import 'package:kellychat/base/base_controller.dart';
import 'package:kellychat/modules/home/doing/model/doing_hot_tags_entity.dart';
import 'package:kellychat/modules/home/mine/edit_mine_info/model/image_links_entity.dart';
import 'package:kellychat/modules/home/mine/sex_select/model/gender.dart';
import 'package:kellychat/network/net/entry/doing/doing.dart';
import 'package:kellychat/network/net/entry/user/user.dart';
import '../profile_setup_controller.dart';
import '../view_model/profile_setup_vm.dart';

extension ProfileSetupRequestController on ProfileSetupController {
  /// request - 上传头像
  Future<ImageLinksEntity?> requestUploadUserAvatar(String path) async {
    if (Strings.isEmpty(path)) return null;
    EasyLoading.show();
    final response =
        await Net.value<User>().requestUploadUserAvatar<ImageLinksEntity>(
      path,
      filename: path.split('/').last,
    );
    EasyLoading.dismiss();
    if (response.succeed) {
      return response.value;
    } else {
      EasyLoading.showToast(response.msg ?? '');
      return null;
    }
  }

  /// request - 上传图片墙
  Future<ImageLinksEntity?> requestUploadPhoto(String path) async {
    if (Strings.isEmpty(path)) return null;
    EasyLoading.show();
    final response =
        await Net.value<User>().requestUploadPhoto<ImageLinksEntity>(
      path,
      filename: path.split('/').last,
    );
    EasyLoading.dismiss();
    if (response.succeed) {
      return response.value;
    } else {
      EasyLoading.showToast(response.msg ?? '');
    }
    return null;
  }

  /// request - 获取用户注册时候，可选的标签
  Future requestRegisterTags({bool showLoad = true}) async {
    if (showLoad) EasyLoading.show();
    var response =
        await Net.value<Doing>().requestRegisterTags<DoingHotTagsEntity>();
    if (showLoad) EasyLoading.dismiss();
    if (response.succeed) {
      vm.value.conRegisterTags(response.values);
      vm.refresh();
    } else {
      if (showLoad) EasyLoading.showToast(response.msg ?? '');
    }
  }

  /// request - 落库：先头像再 PUT 资料
  Future<bool> requestSavePersistProfile() async {
    EasyLoading.show(status: '提交中...');
    final response = await Net.value<User>().requestRegisterUpdateUserInfo<dynamic>(
      avatar: vm.value.stepOne.avatarUrl,
      nickname: vm.value.stepOne.nicknameController?.text,
      gender: vm.value.stepOne.gender == Gender.boy ? 1 : 2,
      birthday: vm.value.stepOne.birthday,
      province: vm.value.stepTwo.region?.province,
      city: vm.value.stepTwo.region?.city,
      district: vm.value.stepTwo.region?.district,
      tags: vm.value.selectTags,
      photos: vm.value.stepThree.photos,
      signature: vm.value.stepThree.briefController?.text,
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
