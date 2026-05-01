import 'package:kellychat/base/base_vm.dart';
import '../model/edit_private_model.dart';

/// FileName: edit_private_message_vm
///
/// @Author 谌文
/// @Date 2026/4/30 22:40
///
/// @Description
class EditPrivateMessageVM extends BaseVM {
  /// 编辑秘密 - model
  EditPrivateModel editPrivateModel = EditPrivateModel();

  /// 是否可保存
  bool saveEnable = false;

  @override
  void onInit() {
    super.onInit();
    buildEditingManage();
    editingController
      ?..addListener(() {
        /// 修改了内容，可以保存啦
        if (Strings.isNotEmpty(editingController?.text) &&
            editingController?.text != editPrivateModel?.content) {
          saveEnable = true;
        } else {
          saveEnable = false;
        }
        refresh?.call();
      });
  }

  /// 配置数据
  void configEditPrivateModel({
    String? content,
    String? password,
    String? oldPassword,
  }) {
    editPrivateModel.content = content;
    editingController?.text = content ?? '';
    editPrivateModel.password = password;
    editPrivateModel.oldPassword = oldPassword;
  }
}
