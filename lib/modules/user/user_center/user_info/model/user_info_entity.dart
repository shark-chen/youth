import 'package:youth/generated/json/succeed/user_info_entity.g.dart';
import 'dart:convert';
import 'package:youth/utils/extension/maps/maps.dart';
export 'package:youth/generated/json/succeed/user_info_entity.g.dart';

class UserInfoEntity {
  String? token;
  int? userId;
  bool? isNewUser;
  UserInfoUserInfo? userInfo;

  UserInfoEntity();

  factory UserInfoEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $UserInfoEntityFromJson(json);
    }
    return UserInfoEntity();
  }

  Map<String, dynamic> toJson() => $UserInfoEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

class UserInfoUserInfo {
  int? id;
  String? phone;
  String? nickname;
  String? avatar;
  int? gender;

  UserInfoUserInfo();

  factory UserInfoUserInfo.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $UserInfoUserInfoFromJson(json);
    }
    return UserInfoUserInfo();
  }

  Map<String, dynamic> toJson() => $UserInfoUserInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
