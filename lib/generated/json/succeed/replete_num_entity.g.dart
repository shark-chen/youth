import 'package:youth/generated/json/convert/json_convert_content.dart';
import 'package:youth/modules/home/hall/model/replete_num_entity.dart';

RepleteNumEntity $RepleteNumEntityFromJson(Map<String, dynamic> json) {
  final RepleteNumEntity repleteNumEntity = RepleteNumEntity();
  int? movingPlanCount = jsonConvert.convert<int>(json['0']);
  if (movingPlanCount != null) {
    repleteNumEntity.movingPlanCount = movingPlanCount;
  }
  movingPlanCount = jsonConvert.convert<int>(json['movingPlanCount']);
  if (movingPlanCount != null) {
    repleteNumEntity.movingPlanCount = movingPlanCount;
  }
  int? repletePlanCount = jsonConvert.convert<int>(json['1']);
  if (repletePlanCount != null) {
    repleteNumEntity.repletePlanCount = repletePlanCount;
  }
  repletePlanCount = jsonConvert.convert<int>(json['repletePlanCount']);
  if (repletePlanCount != null) {
    repleteNumEntity.repletePlanCount = repletePlanCount;
  }
  return repleteNumEntity;
}

Map<String, dynamic> $RepleteNumEntityToJson(RepleteNumEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['0'] = entity.movingPlanCount;
  data['1'] = entity.repletePlanCount;
  return data;
}
