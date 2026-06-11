import 'profile_setup_vm.dart';

/// FileName: profile_setup_three_vm
///
/// @Author 谌文
/// @Date 2026/6/11 23:03
///
/// @Description 完善基础信息 -vm
extension ProfileSetupThreeVM on ProfileSetupVM {
  /// MARK - 完善地区，标签信息
  ///
  /// 配置图片墙
  void addPhoto(String url) {
    if (stepThree.photos.contains(url)) return;
    stepThree.photos.add(url);
  }

  /// 删除图片
  void deletePhoto(int index) {
    if (index < 0 || index >= stepThree.photos.length) return;
    stepThree.photos.removeAt(index);
  }


}
