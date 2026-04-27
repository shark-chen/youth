import 'package:kellychat/generated/json/succeed/user_info_entity.g.dart';
import 'dart:convert';
import 'package:kellychat/utils/extension/maps/maps.dart';
export 'package:kellychat/generated/json/succeed/user_info_entity.g.dart';

class UserInfoEntity {
  int? id;
  String? phone;
  String? nickname;
  String? avatar;
  int? gender;
  String? birthday;
  int? age;
  String? province;
  String? city;
  String? signature;
  List<String>? tags;
  List<String>? photos;
  bool? hasPrivateContent;

  /// 自定义字段
  /// 年龄信息
  String get ageInfo {
    if (age == null) return '';
    return '${age}岁';
  }

  /// 地区信息
  String get regionInfo {
    final parts = <String>[];
    final p = province?.trim();
    final c = city?.trim();
    if (p != null && p.isNotEmpty) parts.add(p);
    if (c != null && c.isNotEmpty) parts.add(c);
    return parts.join('·');
  }

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
