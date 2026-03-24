import 'package:youth/generated/json/succeed/user_right_entity.g.dart';
import 'dart:convert';
import 'package:youth/utils/extension/maps/maps.dart';
export 'package:youth/generated/json/succeed/user_right_entity.g.dart';

class UserRightEntity {
  int? version;
  bool? subAdmin;
  Map<String, UserRightVersionEntity>? userScopeMap;

  UserRightEntity();

  factory UserRightEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $UserRightEntityFromJson(json);
    }
    return UserRightEntity();
  }

  Map<String, dynamic> toJson() => $UserRightEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

class UserRightVersionEntity {
  int? version;
  String? value;

  UserRightVersionEntity();

  factory UserRightVersionEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $UserRightVersionEntityFromJson(json);
    }
    return UserRightVersionEntity();
  }

  Map<String, dynamic> toJson() => $UserRightVersionEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
