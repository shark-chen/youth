import 'package:kellychat/generated/json/convert/json_convert_content.dart';
import 'package:kellychat/modules/home/doing/doing_list/model/doing_list_entity.dart';

DoingListEntity $DoingListEntityFromJson(Map<String, dynamic> json) {
  final DoingListEntity doingListEntity = DoingListEntity();
  final String? tagName = jsonConvert.convert<String>(json['tagName']);
  if (tagName != null) {
    doingListEntity.tagName = tagName;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    doingListEntity.total = total;
  }
  final List<DoingListList>? list = (json['list'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<DoingListList>(e) as DoingListList)
      .toList();
  if (list != null) {
    doingListEntity.list = list;
  }
  return doingListEntity;
}

Map<String, dynamic> $DoingListEntityToJson(DoingListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['tagName'] = entity.tagName;
  data['total'] = entity.total;
  data['list'] = entity.list?.map((v) => v.toJson()).toList();
  return data;
}

extension DoingListEntityExtension on DoingListEntity {
  DoingListEntity copyWith({
    String? tagName,
    int? total,
    List<DoingListList>? list,
  }) {
    return DoingListEntity()
      ..tagName = tagName ?? this.tagName
      ..total = total ?? this.total
      ..list = list ?? this.list;
  }
}

DoingListList $DoingListListFromJson(Map<String, dynamic> json) {
  final DoingListList doingListList = DoingListList();
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    doingListList.userId = userId;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    doingListList.nickname = nickname;
  }
  final String? avatar = jsonConvert.convert<String>(json['avatar']);
  if (avatar != null) {
    doingListList.avatar = avatar;
  }
  final int? gender = jsonConvert.convert<int>(json['gender']);
  if (gender != null) {
    doingListList.gender = gender;
  }
  final String? birthday = jsonConvert.convert<String>(json['birthday']);
  if (birthday != null) {
    doingListList.birthday = birthday;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    doingListList.city = city;
  }
  final String? signature = jsonConvert.convert<String>(json['signature']);
  if (signature != null) {
    doingListList.signature = signature;
  }
  final String? startTime = jsonConvert.convert<String>(json['startTime']);
  if (startTime != null) {
    doingListList.startTime = startTime;
  }
  final int? age = jsonConvert.convert<int>(json['age']);
  if (age != null) {
    doingListList.age = age;
  }
  final String? togetherId = jsonConvert.convert<String>(json['togetherId']);
  if (togetherId != null) {
    doingListList.togetherId = togetherId;
  }
  return doingListList;
}

Map<String, dynamic> $DoingListListToJson(DoingListList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userId'] = entity.userId;
  data['nickname'] = entity.nickname;
  data['avatar'] = entity.avatar;
  data['gender'] = entity.gender;
  data['birthday'] = entity.birthday;
  data['city'] = entity.city;
  data['signature'] = entity.signature;
  data['startTime'] = entity.startTime;
  data['age'] = entity.age;
  data['togetherId'] = entity.togetherId;
  return data;
}

extension DoingListListExtension on DoingListList {
  DoingListList copyWith({
    int? userId,
    String? nickname,
    String? avatar,
    int? gender,
    String? birthday,
    String? city,
    String? signature,
    String? startTime,
    int? age,
  }) {
    return DoingListList()
      ..userId = userId ?? this.userId
      ..nickname = nickname ?? this.nickname
      ..avatar = avatar ?? this.avatar
      ..gender = gender ?? this.gender
      ..birthday = birthday ?? this.birthday
      ..city = city ?? this.city
      ..signature = signature ?? this.signature
      ..startTime = startTime ?? this.startTime
      ..age = age ?? this.age;
  }
}
