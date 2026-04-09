import 'package:youth/base/base_vm.dart';
import '../model/doing_hot_tags_entity.dart';

/// FileName: doing_vm
///
/// @Author 谌文
/// @Date 2026/4/8 22:39
///
/// @Description 正在-vm
class DoingVM extends BaseVM {
  /// 热门标签
  List<DoingHotTagsEntity> hotTags = [];

  @override
  void onInit() {
    super.onInit();
  }

  /// 配置热门标签（含空列表，用于清空展示）
  void configHotTags(List<DoingHotTagsEntity>? values) {
    hotTags = List<DoingHotTagsEntity>.from(values ?? const []);
  }
}
