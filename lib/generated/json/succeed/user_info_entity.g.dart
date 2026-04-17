import 'package:youth/generated/json/convert/json_convert_content.dart';
import 'package:youth/modules/home/mine/user_info/model/user_info_entity.dart';

UserInfoEntity $UserInfoEntityFromJson(Map<String, dynamic> json) {
  final UserInfoEntity userInfoEntity = UserInfoEntity();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    userInfoEntity.id = id;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    userInfoEntity.phone = phone;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    userInfoEntity.nickname = nickname;
  }
  final String? avatar = jsonConvert.convert<String>(json['avatar']);
  if (avatar != null) {
    userInfoEntity.avatar = avatar;
  }
  final int? gender = jsonConvert.convert<int>(json['gender']);
  if (gender != null) {
    userInfoEntity.gender = gender;
  }
  final String? birthday = jsonConvert.convert<String>(json['birthday']);
  if (birthday != null) {
    userInfoEntity.birthday = birthday;
  }
  final int? age = jsonConvert.convert<int>(json['age']);
  if (age != null) {
    userInfoEntity.age = age;
  }
  final String? province = jsonConvert.convert<String>(json['province']);
  if (province != null) {
    userInfoEntity.province = province;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    userInfoEntity.city = city;
  }
  final String? signature = jsonConvert.convert<String>(json['signature']);
  if (signature != null) {
    userInfoEntity.signature = signature;
  }
  final List<String>? tags = (json['tags'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (tags != null) {
    userInfoEntity.tags = tags;
  }
  final List<String>? photos = (json['photos'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (photos != null) {
    userInfoEntity.photos = photos;
  }
  final bool? hasPrivateContent =
      jsonConvert.convert<bool>(json['hasPrivateContent']);
  if (hasPrivateContent != null) {
    userInfoEntity.hasPrivateContent = hasPrivateContent;
  }
  return userInfoEntity;
}

Map<String, dynamic> $UserInfoEntityToJson(UserInfoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['phone'] = entity.phone;
  data['nickname'] = entity.nickname;
  data['avatar'] = entity.avatar;
  data['gender'] = entity.gender;
  data['birthday'] = entity.birthday;
  data['age'] = entity.age;
  data['province'] = entity.province;
  data['city'] = entity.city;
  data['signature'] = entity.signature;
  data['tags'] = entity.tags;
  data['photos'] = entity.photos;
  data['hasPrivateContent'] = entity.hasPrivateContent;
  return data;
}
