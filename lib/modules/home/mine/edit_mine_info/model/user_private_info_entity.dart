import 'package:youth/generated/json/succeed/user_private_info_entity.g.dart';
import 'dart:convert';
import 'package:youth/utils/extension/maps/maps.dart';
export 'package:youth/generated/json/succeed/user_private_info_entity.g.dart';

class UserPrivateInfoEntity {
  String? wishDescription;
  bool? hasPassword;

  UserPrivateInfoEntity();

  factory UserPrivateInfoEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $UserPrivateInfoEntityFromJson(json);
    }
    return UserPrivateInfoEntity();
  }

  Map<String, dynamic> toJson() => $UserPrivateInfoEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
