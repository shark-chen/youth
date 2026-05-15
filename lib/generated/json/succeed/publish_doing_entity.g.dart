import 'package:kellychat/generated/json/convert/json_convert_content.dart';
import 'package:kellychat/modules/home/doing/model/doing_partner_entity.dart';
import 'package:kellychat/modules/home/doing/model/publish_doing_entity.dart';

PublishDoingEntity $PublishDoingEntityFromJson(Map<String, dynamic> json) {
  final PublishDoingEntity publishDoingEntity = PublishDoingEntity();
  final int? statusId = jsonConvert.convert<int>(json['statusId']);
  if (statusId != null) {
    publishDoingEntity.statusId = statusId;
  }
  final int? tagId = jsonConvert.convert<int>(json['tagId']);
  if (tagId != null) {
    publishDoingEntity.tagId = tagId;
  }
  final String? tagName = jsonConvert.convert<String>(json['tagName']);
  if (tagName != null) {
    publishDoingEntity.tagName = tagName;
  }
  final String? startTime = jsonConvert.convert<String>(json['startTime']);
  if (startTime != null) {
    publishDoingEntity.startTime = startTime;
  }
  final DoingPartnerEntity? togetherPartner = jsonConvert.convert<DoingPartnerEntity>(json['togetherPartner']);
  if (togetherPartner != null) {
    publishDoingEntity.togetherPartner = togetherPartner;
  }
  return publishDoingEntity;
}

Map<String, dynamic> $PublishDoingEntityToJson(PublishDoingEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['statusId'] = entity.statusId;
  data['tagId'] = entity.tagId;
  data['tagName'] = entity.tagName;
  data['startTime'] = entity.startTime;
  data['togetherPartner'] = entity.togetherPartner?.toJson();
  return data;
}

extension PublishDoingEntityExtension on PublishDoingEntity {
  PublishDoingEntity copyWith({
    int? statusId,
    int? tagId,
    String? tagName,
    String? startTime,
    DoingPartnerEntity? togetherPartner,
  }) {
    return PublishDoingEntity()
      ..statusId = statusId ?? this.statusId
      ..tagId = tagId ?? this.tagId
      ..tagName = tagName ?? this.tagName
      ..startTime = startTime ?? this.startTime
      ..togetherPartner = togetherPartner ?? this.togetherPartner;
  }
}