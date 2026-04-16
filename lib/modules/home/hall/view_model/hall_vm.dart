import 'package:youth/base/base_vm.dart';

import '../../doing/model/doing_hot_tags_entity.dart';
import '../model/smart_match_people_entity.dart';

enum FindMode {
  /// 提示语模式 - 找友
  findPrompt,

  /// 找友模式
  findFriend,
}

/// FileName hall_vm
///
/// @Author 谌文
/// @Date 2024/6/26 18:54
///
/// @Description 首页vm
class HallVM extends BaseVM {
  HallVM({TickerProvider? mixin}) {
    if (mixin == null) return;
  }

  /// 找友模式
  FindMode findMode = FindMode.findPrompt;

  /// ai - 标签
  List<String> aiTags = [];

  /// 智能匹配到的朋友
  List<SmartMatchPeopleList>? friends;

  /// 获取列表数量
  int itemCount() => 1;

  /// 配置AI标签（含空列表，用于清空展示）
  void configAiTags(List<String>? values) {
    aiTags = values ?? [];
  }

  /// 是否是找友提示语模式
  bool get findPrompt {
    return findMode == FindMode.findPrompt;
  }
}
