import 'package:kellychat/base/base_vm.dart';

import '../../model/doing_hot_tags_entity.dart';
import '../../model/publish_doing_entity.dart';
import '../model/doing_list_entity.dart';

/// FileName: doing_list_vm
///
/// @Author 谌文
/// @Date 2026/3/9 23:29
///
/// @Description 正在做的清单-vm
class DoingListVM extends BaseVM {
  /// 当前正在做的事（展示在渐变头、统计文案里）
  String activityTitle = '--';

  /// 「有 N 人也在」
  int samePeopleCount = 0;

  /// 正在做的人列表数据
  DoingListEntity? doingListEntity;

  /// 我正在做的事
  PublishDoingEntity? myDoing;

  DoingHotTagsEntity? doingHotTagsEntity;

  /// 热门标签
  List<DoingHotTagsEntity> hotTags = [];

  @override
  void onInit() {
    super.onInit();
  }

  /// 配置正在做的事情数据
  void configDoingListEntity(DoingListEntity? value) {
    doingListEntity = value;
    final tag = value?.tagName;
    if (tag != null && tag.isNotEmpty) {
      activityTitle = tag;
    }
    final t = value?.total;
    if (t != null) {
      samePeopleCount = t;
    }
  }

  /// 配置我正在做的事
  void configMyDoing(PublishDoingEntity? value) {
    myDoing = value;
  }

  /// 配置热门标签（含空列表，用于清空展示）
  void configHotTags(List<DoingHotTagsEntity>? values) {
    hotTags = List<DoingHotTagsEntity>.from(values ?? const []);
  }

  /// 获取列表数据
  List<DoingListList>? get rows {
    return doingListEntity?.list;
  }

  /// 改事情是否有正在做的人
  bool get haveDoingPerson {
    return Lists.isNotEmpty(rows);
  }
}
