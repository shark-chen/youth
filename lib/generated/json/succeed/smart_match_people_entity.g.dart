import 'package:kellychat/generated/json/convert/json_convert_content.dart';
import 'package:kellychat/modules/home/hall/model/smart_match_people_entity.dart';

SmartMatchPeopleEntity $SmartMatchPeopleEntityFromJson(
    Map<String, dynamic> json) {
  final SmartMatchPeopleEntity smartMatchPeopleEntity = SmartMatchPeopleEntity();
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    smartMatchPeopleEntity.total = total;
  }
  final List<SmartMatchPeopleList>? list = (json['list'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<SmartMatchPeopleList>(e) as SmartMatchPeopleList)
      .toList();
  if (list != null) {
    smartMatchPeopleEntity.list = list;
  }
  final int? page = jsonConvert.convert<int>(json['page']);
  if (page != null) {
    smartMatchPeopleEntity.page = page;
  }
  final int? size = jsonConvert.convert<int>(json['size']);
  if (size != null) {
    smartMatchPeopleEntity.size = size;
  }
  final int? pages = jsonConvert.convert<int>(json['pages']);
  if (pages != null) {
    smartMatchPeopleEntity.pages = pages;
  }
  return smartMatchPeopleEntity;
}

Map<String, dynamic> $SmartMatchPeopleEntityToJson(
    SmartMatchPeopleEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['total'] = entity.total;
  data['list'] = entity.list?.map((v) => v.toJson()).toList();
  data['page'] = entity.page;
  data['size'] = entity.size;
  data['pages'] = entity.pages;
  return data;
}

extension SmartMatchPeopleEntityExtension on SmartMatchPeopleEntity {
  SmartMatchPeopleEntity copyWith({
    int? total,
    List<SmartMatchPeopleList>? list,
    int? page,
    int? size,
    int? pages,
  }) {
    return SmartMatchPeopleEntity()
      ..total = total ?? this.total
      ..list = list ?? this.list
      ..page = page ?? this.page
      ..size = size ?? this.size
      ..pages = pages ?? this.pages;
  }
}

SmartMatchPeopleList $SmartMatchPeopleListFromJson(Map<String, dynamic> json) {
  final SmartMatchPeopleList smartMatchPeopleList = SmartMatchPeopleList();
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    smartMatchPeopleList.userId = userId;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    smartMatchPeopleList.nickname = nickname;
  }
  final int? gender = jsonConvert.convert<int>(json['gender']);
  if (gender != null) {
    smartMatchPeopleList.gender = gender;
  }
  final int? age = jsonConvert.convert<int>(json['age']);
  if (age != null) {
    smartMatchPeopleList.age = age;
  }
  final String? avatar = jsonConvert.convert<String>(json['avatar']);
  if (avatar != null) {
    smartMatchPeopleList.avatar = avatar;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    smartMatchPeopleList.city = city;
  }
  final List<dynamic>? tags = (json['tags'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (tags != null) {
    smartMatchPeopleList.tags = tags;
  }
  final double? matchScore = jsonConvert.convert<double>(json['matchScore']);
  if (matchScore != null) {
    smartMatchPeopleList.matchScore = matchScore;
  }
  return smartMatchPeopleList;
}

Map<String, dynamic> $SmartMatchPeopleListToJson(SmartMatchPeopleList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userId'] = entity.userId;
  data['nickname'] = entity.nickname;
  data['gender'] = entity.gender;
  data['age'] = entity.age;
  data['city'] = entity.city;
  data['tags'] = entity.tags;
  data['matchScore'] = entity.matchScore;
  data['avatar'] = entity.avatar;
  return data;
}

extension SmartMatchPeopleListExtension on SmartMatchPeopleList {
  SmartMatchPeopleList copyWith({
    int? userId,
    String? nickname,
    int? gender,
    int? age,
    String? city,
    String? avatar,
    List<dynamic>? tags,
    double? matchScore,
  }) {
    return SmartMatchPeopleList()
      ..userId = userId ?? this.userId
      ..nickname = nickname ?? this.nickname
      ..gender = gender ?? this.gender
      ..age = age ?? this.age
      ..avatar = city ?? this.avatar
      ..city = city ?? this.city
      ..tags = tags ?? this.tags
      ..matchScore = matchScore ?? this.matchScore;
  }
}