import 'package:kellychat/generated/json/convert/json_convert_content.dart';
import 'package:kellychat/modules/home/doing/model/doing_present_hot_tag_entity.dart';

DoingPresentHotTagEntity $DoingPresentHotTagEntityFromJson(
    Map<String, dynamic> json) {
  final DoingPresentHotTagEntity doingPresentHotTagEntity = DoingPresentHotTagEntity();
  final int? tagId = jsonConvert.convert<int>(json['tagId']);
  if (tagId != null) {
    doingPresentHotTagEntity.tagId = tagId;
  }
  final String? tagName = jsonConvert.convert<String>(json['tagName']);
  if (tagName != null) {
    doingPresentHotTagEntity.tagName = tagName;
  }
  final String? icon = jsonConvert.convert<String>(json['icon']);
  if (icon != null) {
    doingPresentHotTagEntity.icon = icon;
  }
  return doingPresentHotTagEntity;
}

Map<String, dynamic> $DoingPresentHotTagEntityToJson(
    DoingPresentHotTagEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['tagId'] = entity.tagId;
  data['tagName'] = entity.tagName;
  data['icon'] = entity.icon;
  return data;
}

extension DoingPresentHotTagEntityExtension on DoingPresentHotTagEntity {
  DoingPresentHotTagEntity copyWith({
    int? tagId,
    String? tagName,
    String? icon,
  }) {
    return DoingPresentHotTagEntity()
      ..tagId = tagId ?? this.tagId
      ..tagName = tagName ?? this.tagName
      ..icon = icon ?? this.icon;
  }
}