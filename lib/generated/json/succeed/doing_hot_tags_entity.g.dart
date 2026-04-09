import 'package:youth/generated/json/convert/json_convert_content.dart';
import 'package:youth/modules/home/doing/model/doing_hot_tags_entity.dart';

DoingHotTagsEntity $DoingHotTagsEntityFromJson(Map<String, dynamic> json) {
  final DoingHotTagsEntity doingHotTagsEntity = DoingHotTagsEntity();
  final int? tagId = jsonConvert.convert<int>(json['tagId']);
  if (tagId != null) {
    doingHotTagsEntity.tagId = tagId;
  }
  final String? tagName = jsonConvert.convert<String>(json['tagName']);
  if (tagName != null) {
    doingHotTagsEntity.tagName = tagName;
  }
  final int? userCount = jsonConvert.convert<int>(json['userCount']);
  if (userCount != null) {
    doingHotTagsEntity.userCount = userCount;
  }
  final String? icon = jsonConvert.convert<String>(json['icon']);
  if (icon != null) {
    doingHotTagsEntity.icon = icon;
  }
  return doingHotTagsEntity;
}

Map<String, dynamic> $DoingHotTagsEntityToJson(DoingHotTagsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['tagId'] = entity.tagId;
  data['tagName'] = entity.tagName;
  data['userCount'] = entity.userCount;
  data['icon'] = entity.icon;
  return data;
}

extension DoingHotTagsEntityExtension on DoingHotTagsEntity {
  DoingHotTagsEntity copyWith({
    int? tagId,
    String? tagName,
    int? userCount,
    String? icon,
  }) {
    return DoingHotTagsEntity()
      ..tagId = tagId ?? this.tagId
      ..tagName = tagName ?? this.tagName
      ..icon = icon ?? this.icon
      ..userCount = userCount ?? this.userCount;
  }
}
