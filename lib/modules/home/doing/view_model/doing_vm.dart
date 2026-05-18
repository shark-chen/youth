import 'package:kellychat/base/base_vm.dart';
import 'package:kellychat/modules/home/mine/user_info/model/user_info_entity.dart';
import '../model/doing_hot_tags_entity.dart';
import '../model/doing_present_hot_tag_entity.dart';

/// FileName: doing_vm
///
/// @Author 谌文
/// @Date 2026/4/8 22:39
///
/// @Description 正在-vm
class DoingVM extends BaseVM {


  /// 热门标签
  List<DoingPresentHotTagEntity> hotTags = [];

  /// 人信息数据
  UserInfoEntity? userInfo;

  @override
  void onInit() {
    super.onInit();
  }


  /// 配置热门标签（含空列表，用于清空展示）
  void configHotTags(List<DoingPresentHotTagEntity>? values) {
    hotTags = values ?? [];
  }

  /// 配置个人信息数据
  void configUserInfo(UserInfoEntity? value) {
    userInfo = value;
  }
}
