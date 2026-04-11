import 'package:youth/generated/json/convert/json_convert_content.dart';
import 'package:youth/modules/user/user_center/user_info/model/user_info_entity.dart';

LoginUserInfoEntity $LoginUserInfoEntityFromJson(Map<String, dynamic> json) {
  final LoginUserInfoEntity userInfoEntity = LoginUserInfoEntity();
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
  final LoginUserInfoUserInfo? userInfo =
      jsonConvert.convert<LoginUserInfoUserInfo>(json['userInfo']);
  if (userInfo != null) {
    userInfoEntity.userInfo = userInfo;
  }
  return userInfoEntity;
}

Map<String, dynamic> $UserInfoEntityToJson(LoginUserInfoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['token'] = entity.token;
  data['userId'] = entity.userId;
  data['isNewUser'] = entity.isNewUser;
  data['userInfo'] = entity.userInfo?.toJson();
  return data;
}

extension LoginUserInfoEntityExtension on LoginUserInfoEntity {
  LoginUserInfoEntity copyWith({
    String? token,
    int? userId,
    bool? isNewUser,
    LoginUserInfoUserInfo? userInfo,
  }) {
    return LoginUserInfoEntity()
      ..token = token ?? this.token
      ..userId = userId ?? this.userId
      ..isNewUser = isNewUser ?? this.isNewUser
      ..userInfo = userInfo ?? this.userInfo;
  }
}

LoginUserInfoUserInfo $LoginUserInfoUserInfoFromJson(
    Map<String, dynamic> json) {
  final LoginUserInfoUserInfo loginUserInfoUserInfo = LoginUserInfoUserInfo();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    loginUserInfoUserInfo.id = id;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    loginUserInfoUserInfo.phone = phone;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    loginUserInfoUserInfo.nickname = nickname;
  }
  final String? avatar = jsonConvert.convert<String>(json['avatar']);
  if (avatar != null) {
    loginUserInfoUserInfo.avatar = avatar;
  }
  final int? gender = jsonConvert.convert<int>(json['gender']);
  if (gender != null) {
    loginUserInfoUserInfo.gender = gender;
  }
  return loginUserInfoUserInfo;
}

Map<String, dynamic> $LoginUserInfoUserInfoToJson(
    LoginUserInfoUserInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['phone'] = entity.phone;
  data['nickname'] = entity.nickname;
  data['avatar'] = entity.avatar;
  data['gender'] = entity.gender;
  return data;
}

extension UserInfoUserInfoExtension on LoginUserInfoUserInfo {
  LoginUserInfoUserInfo copyWith({
    int? id,
    String? phone,
    String? nickname,
    String? avatar,
    int? gender,
  }) {
    return LoginUserInfoUserInfo()
      ..id = id ?? this.id
      ..phone = phone ?? this.phone
      ..nickname = nickname ?? this.nickname
      ..avatar = avatar ?? this.avatar
      ..gender = gender ?? this.gender;
  }
}
