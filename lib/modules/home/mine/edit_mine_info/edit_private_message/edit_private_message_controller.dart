import 'package:kellychat/base/base_controller.dart';
import 'package:flutter/services.dart';
import 'package:kellychat/network/net/entry/user/user.dart';

import 'view_model/edit_private_message_vm.dart';

/// FileName: edit_private_message_controller
///
/// @Description 说两句（编辑私密内容）
class EditPrivateMessageController extends BaseController {
  EditPrivateMessageController({
    String? content,
    String? password,
    String? oldPassword,
  }) {
    vm.value.configEditPrivateModel(
      content: content,
      password: password,
      oldPassword: oldPassword,
    );
  }

  /// vm
  Rx<EditPrivateMessageVM> vm = EditPrivateMessageVM().obs;

  @override
  void onInit() {
    super.onInit();
    title = '说两句';
    vm.value.refresh = vm.refresh;
  }

  /// 点击保存
  Future<void> clickSave() async {
    if (!vm.value.saveEnable) return;

    /// 已经有密码的时候
    var result = false;
    if (Strings.isNotEmpty(vm.value.editPrivateModel.oldPassword)) {
      result = await requestUpdateUserPrivate(
        wishDescription: vm.value.editingController?.text ?? '',
        oldPassword: vm.value.editPrivateModel.oldPassword,
      );
    } else {
      result = await requestUpdateUserPrivate(
        wishDescription: vm.value.editingController?.text ?? '',
        password: vm.value.editPrivateModel.password,
      );
    }
    if (result) {
      Future.delayed(const Duration(milliseconds: 2000), Get.back);
    }
  }

  /// 第一次设置私密
  /// 更新用户私密信息 · PUT /api/user/private
  Future<bool> requestUpdateUserPrivate({
    required String wishDescription,
    String? password,
    String? oldPassword,
  }) async {
    EasyLoading.show();
    final response = await Net.value<User>().requestUpdateUserPrivate(
      wishDescription: wishDescription,
      password: password,
      oldPassword: oldPassword,
    );
    EasyLoading.dismiss();
    if (response.success) {
      EasyLoading.showToast('设置成功');
      return true;
    } else {
      EasyLoading.showToast(response.msg ?? '');
      return false;
    }
  }
}
