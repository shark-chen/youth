import 'package:kellychat/utils/extension/lists/lists.dart';
import 'package:kellychat/utils/extension/strings/strings.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'edit_mine_info_vm.dart';

/// FileName: edit_mine_info_check_vm
///
/// @Author 谌文
/// @Date 2026/6/13 17:51
///
/// @Description 编辑资料-校验-vm
extension EditMineInfoICheckVM on EditMineInfoVM {
  /// 是否可保存
  bool saveEnable({bool toast = false}) {
    /// 头像不能为空
    if (Strings.isEmpty(draft.avatarUrl)) {
      if (toast) {
        EasyLoading.showToast('请先上传头像');
      }
      return false;
    }

    /// 昵称不能为空
    if (Strings.isEmpty(draft.nickname)) {
      if (toast) {
        EasyLoading.showToast('请先设置昵称');
      }
      return false;
    }

    /// 标签不能为空
    if (Lists.isEmpty(draft.tags)) {
      if (toast) {
        EasyLoading.showToast('请先设置标签');
      }
      return false;
    }

    /// 图片墙不能为空
    if (Lists.isEmpty(draft.photos)) {
      if (toast) {
        EasyLoading.showToast('请先上传照片墙');
      }
      return false;
    }
    return true;
  }
}
