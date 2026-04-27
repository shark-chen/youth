import 'package:kellychat/generated/json/succeed/login_user_info_entity.g.dart';
import 'dart:convert';
import 'package:kellychat/utils/extension/maps/maps.dart';
export 'package:kellychat/generated/json/succeed/login_user_info_entity.g.dart';

class LoginUserInfoEntity {
  String? token;
  int? userId;
  bool? isNewUser;
  LoginUserInfoUserInfo? userInfo;

  LoginUserInfoEntity();

  factory LoginUserInfoEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $LoginUserInfoEntityFromJson(json);
    }
    return LoginUserInfoEntity();
  }

  Map<String, dynamic> toJson() => $UserInfoEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

class LoginUserInfoUserInfo {
  int? id;
  String? phone;
  String? nickname;
  String? avatar;
  int? gender;

  LoginUserInfoUserInfo();

  factory LoginUserInfoUserInfo.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $LoginUserInfoUserInfoFromJson(json);
    }
    return LoginUserInfoUserInfo();
  }

  Map<String, dynamic> toJson() => $LoginUserInfoUserInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
