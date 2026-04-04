import 'package:youth/generated/json/convert/json_convert_content.dart';
import 'package:youth/modules/user/user_center/user_info/model/user_info_entity.dart';

UserInfoEntity $UserInfoEntityFromJson(Map<String, dynamic> json) {
  final UserInfoEntity userInfoEntity = UserInfoEntity();
  final String? token = jsonConvert.convert<String>(json['token']);
  if (token != null) {
    userInfoEntity.token = token;
  }
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    userInfoEntity.userId = userId;
  }
  final bool? isNewUser = jsonConvert.convert<bool>(json['isNewUser']);
  if (isNewUser != null) {
    userInfoEntity.isNewUser = isNewUser;
  }
  final UserInfoUserInfo? userInfo = jsonConvert.convert<UserInfoUserInfo>(
      json['userInfo']);
  if (userInfo != null) {
    userInfoEntity.userInfo = userInfo;
  }
  return userInfoEntity;
}

Map<String, dynamic> $UserInfoEntityToJson(UserInfoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['token'] = entity.token;
  data['userId'] = entity.userId;
  data['isNewUser'] = entity.isNewUser;
  data['userInfo'] = entity.userInfo?.toJson();
  return data;
}

extension UserInfoEntityExtension on UserInfoEntity {
  UserInfoEntity copyWith({
    String? token,
    int? userId,
    bool? isNewUser,
    UserInfoUserInfo? userInfo,
  }) {
    return UserInfoEntity()
      ..token = token ?? this.token
      ..userId = userId ?? this.userId
      ..isNewUser = isNewUser ?? this.isNewUser
      ..userInfo = userInfo ?? this.userInfo;
  }
}

UserInfoUserInfo $UserInfoUserInfoFromJson(Map<String, dynamic> json) {
  final UserInfoUserInfo userInfoUserInfo = UserInfoUserInfo();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    userInfoUserInfo.id = id;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    userInfoUserInfo.phone = phone;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    userInfoUserInfo.nickname = nickname;
  }
  final String? avatar = jsonConvert.convert<String>(json['avatar']);
  if (avatar != null) {
    userInfoUserInfo.avatar = avatar;
  }
  final int? gender = jsonConvert.convert<int>(json['gender']);
  if (gender != null) {
    userInfoUserInfo.gender = gender;
  }
  return userInfoUserInfo;
}

Map<String, dynamic> $UserInfoUserInfoToJson(UserInfoUserInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['phone'] = entity.phone;
  data['nickname'] = entity.nickname;
  data['avatar'] = entity.avatar;
  data['gender'] = entity.gender;
  return data;
}

extension UserInfoUserInfoExtension on UserInfoUserInfo {
  UserInfoUserInfo copyWith({
    int? id,
    String? phone,
    String? nickname,
    String? avatar,
    int? gender,
  }) {
    return UserInfoUserInfo()
      ..id = id ?? this.id
      ..phone = phone ?? this.phone
      ..nickname = nickname ?? this.nickname
      ..avatar = avatar ?? this.avatar
      ..gender = gender ?? this.gender;
  }
}