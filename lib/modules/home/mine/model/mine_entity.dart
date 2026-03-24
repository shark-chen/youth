import 'dart:convert';
import 'package:youth/generated/json/succeed/mine_entity.g.dart';
import '../../../../utils/extension/maps/maps.dart';
import '../../hall/model/hall_item_entity.dart';

class MineEntity {
  List<HallItemEntity>? iD;
  List<HallItemEntity>? eN;
  List<HallItemEntity>? zH;
  List<HallItemEntity>? tH;
  List<HallItemEntity>? vN;

  /// 自定义字段
  Map<String, List<HallItemEntity>?>? itemMap;

  /// 自定义字段
  Map<String, List<List<HallItemEntity>>?>? itemsMap;

  MineEntity();

  factory MineEntity.fromJson(dynamic json, {int? index}) {
    if (Maps.isNotEmpty(json)) {
      var result = $MineEntityFromJson(json);
      result.itemsMap = {};
      /// 我的页面的数据
      result.itemMap = {
        'EN': result.eN,
        'ID': result.iD,
        'VN': result.vN,
        'TH': result.tH,
        'ZH': result.zH,
      };
      return result;
    }
    return MineEntity();
  }

  Map<String, dynamic> toJson() => $MineEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
