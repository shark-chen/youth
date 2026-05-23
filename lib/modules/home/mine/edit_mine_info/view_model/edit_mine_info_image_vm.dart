import 'package:kellychat/tripartite_library/tripartite_library.dart';
import 'package:kellychat/utils/extension/strings/strings.dart';

import '../model/image_links_entity.dart';
import 'edit_mine_info_vm.dart';

/// FileName: edit_mine_info_image_vm
///
/// @Author 谌文
/// @Date 2026/5/2 23:02
///
/// @Description 编辑用户信息-图片墙+头像-vm
extension EditMineInfoImageVM on EditMineInfoVM {

  /// 拖拽照片墙（顺序同步服务端）
  void reorderPhotos(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    final list = draft.photos;
    if (oldIndex < 0 ||
        oldIndex >= list.length ||
        newIndex < 0 ||
        newIndex >= list.length) {
      return;
    }
    final item = list.removeAt(oldIndex);
    list.insert(newIndex, item);
    refresh?.call();
  }

  /// 添加图片墙
  void addPhoto(String? url) {
    if(Strings.isEmpty(url)) return;
    draft.photos.add(url ?? '');
  }
}