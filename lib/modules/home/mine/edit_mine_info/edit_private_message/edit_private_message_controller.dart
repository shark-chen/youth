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

  bool get _isFirstTimePrivateSetup =>
      Strings.isEmpty(vm.value.editPrivateModel.oldPassword) &&
      Strings.isNotEmpty(vm.value.editPrivateModel.password);

  /// 点击取消 / 返回
  Future<void> clickCancel() async {
    if (_isFirstTimePrivateSetup) {
      final result = await _submitPrivate(
        wishDescription: '',
        showLoad: false,
      );
      if (result) _popAfterSuccess();
      return;
    }
    Get.back();
  }

  /// 点击保存
  Future<void> clickSave() async {
    if (!vm.value.saveEnable) return;

    final result = await _submitPrivate(
      wishDescription: vm.value.editingController?.text ?? '',
    );
    if (result) _popAfterSuccess();
  }

  Future<bool> _submitPrivate({
    required String wishDescription,
    bool? showLoad = false,
  }) async {
    if (Strings.isNotEmpty(vm.value.editPrivateModel.oldPassword)) {
      return requestUpdateUserPrivate(
        wishDescription: wishDescription,
        oldPassword: vm.value.editPrivateModel.oldPassword,
        showLoad: showLoad,
      );
    }
    return requestUpdateUserPrivate(
      wishDescription: wishDescription,
      password: vm.value.editPrivateModel.password,
      showLoad: showLoad,
    );
  }

  void _popAfterSuccess() {
    Future.delayed(const Duration(milliseconds: 2000), Get.back);
  }

  /// 第一次设置私密
  /// 更新用户私密信息 · PUT /api/user/private
  Future<bool> requestUpdateUserPrivate({
    required String wishDescription,
    String? password,
    String? oldPassword,
    bool? showLoad = false,
  }) async {
    if (true == showLoad) EasyLoading.show();
    final response = await Net.value<User>().requestUpdateUserPrivate(
      wishDescription: wishDescription,
      password: password,
      oldPassword: oldPassword,
    );
    if (true == showLoad) EasyLoading.dismiss();
    if (response.success) {
      if (true == showLoad) EasyLoading.showToast('设置成功');
      return true;
    } else {
      if (true == showLoad) EasyLoading.showToast(response.msg ?? '');
      return false;
    }
  }
}
