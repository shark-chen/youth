import 'package:youth/generated/json/convert/json_convert_content.dart';
import 'package:youth/modules/home/hall/model/hall_entity.dart';
import 'package:youth/modules/home/hall/model/hall_item_entity.dart';

/// FileName hall_entity.g
///
/// @Author 谌文
/// @Date 2023/9/20 09:36
///
/// @Description 首页数据
HallEntity $HallEntityFromJson(Map<String, dynamic> json) {
  final HallEntity homeEntity = HallEntity();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    homeEntity.title = title;
  }
  final List<HallItemEntity>? items = jsonConvert.convertListNotNull<HallItemEntity>(json['items']);
  if (items != null) {
    homeEntity.items = items;
  }
  return homeEntity;
}

Map<String, dynamic> $HallEntityToJson(HallEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['items'] =  entity.items;
  data['title'] =  entity.title;
  return data;
}