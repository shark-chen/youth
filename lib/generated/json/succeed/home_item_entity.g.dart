import 'package:youth/generated/json/convert/json_convert_content.dart';
import 'package:youth/modules/home/hall/model/hall_item_entity.dart';

HallItemEntity $HallItemEntityFromJson(Map<String, dynamic> json) {
  final HallItemEntity homeItemEntity = HallItemEntity();
  final dynamic lang = jsonConvert.convert<dynamic>(json['lang']);
  if (lang != null) {
    homeItemEntity.lang = lang;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    homeItemEntity.name = name;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    homeItemEntity.description = description;
  }
  final String? logo = jsonConvert.convert<String>(json['logo']);
  if (logo != null) {
    homeItemEntity.logo = logo;
  }
  final bool? needVip = jsonConvert.convert<bool>(json['needVip']);
  if (logo != null) {
    homeItemEntity.needVip = needVip;
  }
  final String? pageName = jsonConvert.convert<String>(json['pageName']);
  if (pageName != null) {
    homeItemEntity.pageName = pageName;
  }
  return homeItemEntity;
}

Map<String, dynamic> $HallItemEntityToJson(HallItemEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['lang'] =  entity.lang;
  data['name'] =  entity.name;
  data['description'] =  entity.description;
  data['logo'] =  entity.logo;
  data['needVip'] =  entity.needVip;
  data['pageName'] =  entity.pageName;
  return data;
}