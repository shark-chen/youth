import 'dart:math';

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

  /// 配置热门标签：从接口返回列表中 **随机** 抽取 3～5 条，并写入 [DoingHotTagsEntity.peopleCountDisplay]。
  void configHotTags(List<DoingHotTagsEntity>? values) {
    final source = List<DoingHotTagsEntity>.from(values ?? const []);
    if (source.isEmpty) {
      hotTags = [];
      return;
    }
    source.shuffle(Random());
    final pickCount = min(3 + Random().nextInt(3), source.length);
    final picked = source.take(pickCount).toList();
    for (final e in picked) {
      final n = e.userCount ?? 0;
      e.peopleCountDisplay = formatHotTagPeopleCount(n < 0 ? 0 : n);
    }
    hotTags = picked;
  }

  /// 热门状态人数展示（与产品约定一致）。
  ///
  /// - 小于 1 万：显示具体整数；
  /// - ≥1 万且 ≤100 万：`x.xW`，**截断**至最多 1 位小数（不做四舍五入）；
  /// - 大于 100 万：固定「100W+」。
  static String formatHotTagPeopleCount(int count) {
    if (count > 1000000) {
      return '100W+';
    }
    if (count < 10000) {
      return '$count';
    }
    final tenths = (count * 10) ~/ 10000;
    final intPart = tenths ~/ 10;
    final dec = tenths % 10;
    if (dec == 0) {
      return '${intPart}W';
    }
    return '$intPart.${dec}W';
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
