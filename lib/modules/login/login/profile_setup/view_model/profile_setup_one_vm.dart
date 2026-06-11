import 'package:image_picker/image_picker.dart';
import 'profile_setup_vm.dart';

/// FileName: profile_setup_one_vm
///
/// @Author 谌文
/// @Date 2026/6/11 22:58
///
/// @Description 完善基础信息 -vm
extension ProfileSetupOneVM on ProfileSetupVM {
  /// MARK - 完善基础信息
  ///
  /// 配置头像
  void configAvatarXFile(XFile? file) {
    stepOne.avatarPath = file?.path;
  }

  /// 配置头像
  void configAvatarUrl(String? value) {
    stepOne.avatarUrl = value;
  }

  /// 配置生日
  void configBirthday(DateTime d) {
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    stepOne.birthday = '$y-$m-$day';
  }

  /// 日期
  DateTime? birthdayAsDate() {
    final s = stepOne.birthday;
    if (s == null || s.length < 8) return null;
    try {
      return DateTime.parse(s);
    } catch (_) {
      return null;
    }
  }
}
