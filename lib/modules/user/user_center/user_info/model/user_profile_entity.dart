import 'package:youth/generated/json/succeed/user_profile_entity.g.dart';
import 'dart:convert';
import 'package:youth/utils/extension/maps/maps.dart';
export 'package:youth/generated/json/succeed/user_profile_entity.g.dart';

class UserProfileEntity {
  int? id;
  String? phone;
  String? nickname;
  int? gender;
  String? birthday;
  List<String>? tags;
  List<String>? photos;
  bool? hasPrivateContent;

  UserProfileEntity();

  factory UserProfileEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $UserProfileEntityFromJson(json);
    }
    return UserProfileEntity();
  }

  Map<String, dynamic> toJson() => $UserProfileEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
