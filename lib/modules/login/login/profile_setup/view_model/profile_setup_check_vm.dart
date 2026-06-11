import 'package:kellychat/utils/extension/lists/lists.dart';
import 'package:kellychat/utils/extension/strings/strings.dart';
import 'profile_setup_vm.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'profile_setup_two_vm.dart';

/// FileName: profile_setup_check_vm
///
/// @Author 谌文
/// @Date 2026/6/9 22:20
///
/// @Description 完善资料页- 校验
extension ProfileSetupCheckVM on ProfileSetupVM {
  /// 第一步： 完善基础信息 相关校验
  ///
  /// 第一步校验
  bool get stepOneCheck {
    /// 都是必填项
    final nickname = stepOne.nicknameController?.text.trim();
    return Strings.isNotEmpty(stepOne.avatarUrl) &&
        Strings.isNotEmpty(nickname) &&
        stepOne.gender != null &&
        Strings.isNotEmpty(stepOne.birthday);
  }

  /// 第一步校验提示toast
  bool stepOneCheckToast() {
    if (Strings.isEmpty(stepOne.avatarUrl)) {
      EasyLoading.showToast('请上传头像');
      return false;
    }
    if (Strings.isEmpty(stepOne.nicknameController?.text.trim())) {
      EasyLoading.showToast('请设置昵称');
      return false;
    }
    if (stepOne.gender == null) {
      EasyLoading.showToast('请设置性别');
      return false;
    }
    if (Strings.isEmpty(stepOne.birthday)) {
      EasyLoading.showToast('请设置生日');
      return false;
    }
    return true;
  }

  /// 第二步： 完善地区，标签信息 相关校验
  ///
  /// 第二步校验
  bool get stepTwoCheck {
    /// 地区必填
    if (stepTwo.region == null) {
      return false;
    }
    if (Lists.isEmpty(selectTags)) {
      return false;
    }
    return true;
  }

  /// 第二步校验提示toast
  bool stepTwoCheckToast() {
    if (stepTwo.region == null) {
      EasyLoading.showToast('请设置地区');
      return false;
    }
    if (Lists.isEmpty(selectTags)) {
      EasyLoading.showToast('请设置标签');
      return false;
    }
    return true;
  }

  /// 第三步步：图片墙
  ///
  /// 第三步校验
  bool get stepThreeCheck {
    /// 图片墙
    if (Lists.isEmpty(stepThree.photos)) {
      return false;
    }
    return true;
  }

  /// 第三步校验提示toast
  bool stepThreeCheckToast() {
    if (Lists.isEmpty(stepThree.photos)) {
      EasyLoading.showToast('请上传图片到你的图片墙');
      return false;
    }
    return true;
  }
}
