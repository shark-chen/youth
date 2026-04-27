import 'package:kellychat/generated/json/convert/json_convert_content.dart';
import 'package:kellychat/modules/user/user_center/user_info/model/user_profile_entity.dart';

UserProfileEntity $UserProfileEntityFromJson(Map<String, dynamic> json) {
  final UserProfileEntity userProfileEntity = UserProfileEntity();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    userProfileEntity.id = id;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    userProfileEntity.phone = phone;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    userProfileEntity.nickname = nickname;
  }
  final int? gender = jsonConvert.convert<int>(json['gender']);
  if (gender != null) {
    userProfileEntity.gender = gender;
  }
  final String? birthday = jsonConvert.convert<String>(json['birthday']);
  if (birthday != null) {
    userProfileEntity.birthday = birthday;
  }
  final List<String>? tags = (json['tags'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (tags != null) {
    userProfileEntity.tags = tags;
  }
  final List<String>? photos = (json['photos'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (photos != null) {
    userProfileEntity.photos = photos;
  }
  final bool? hasPrivateContent =
      jsonConvert.convert<bool>(json['hasPrivateContent']);
  if (hasPrivateContent != null) {
    userProfileEntity.hasPrivateContent = hasPrivateContent;
  }
  return userProfileEntity;
}

Map<String, dynamic> $UserProfileEntityToJson(UserProfileEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['phone'] = entity.phone;
  data['nickname'] = entity.nickname;
  data['gender'] = entity.gender;
  data['birthday'] = entity.birthday;
  data['tags'] = entity.tags;
  data['photos'] = entity.photos;
  data['hasPrivateContent'] = entity.hasPrivateContent;
  return data;
}

extension UserProfileEntityExtension on UserProfileEntity {
  UserProfileEntity copyWith({
    int? id,
    String? phone,
    String? nickname,
    int? gender,
    String? birthday,
    List<String>? tags,
    List<String>? photos,
    bool? hasPrivateContent,
  }) {
    return UserProfileEntity()
      ..id = id ?? this.id
      ..phone = phone ?? this.phone
      ..nickname = nickname ?? this.nickname
      ..gender = gender ?? this.gender
      ..birthday = birthday ?? this.birthday
      ..tags = tags ?? this.tags
      ..photos = photos ?? this.photos
      ..hasPrivateContent = hasPrivateContent ?? this.hasPrivateContent;
  }
}
