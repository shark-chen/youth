import '../model/image_links_entity.dart';
import 'edit_mine_info_vm.dart';

/// FileName: edit_mine_info_image_vm
///
/// @Author 谌文
/// @Date 2026/5/2 23:02
///
/// @Description 编辑用户信息-图片墙+头像-vm
extension EditMineInfoImageVM on EditMineInfoVM {

  /// 添加新的图片墙资源数据
  void addNewImageLinks(ImageLinksEntity imageLink) {
    newImageLinks.add(imageLink);
  }

  /// 上传图片墙的图片资源
  List<String> get imageLinkKeys {
    return newImageLinks.map((element) => element.key ?? '').toList();
  }
}