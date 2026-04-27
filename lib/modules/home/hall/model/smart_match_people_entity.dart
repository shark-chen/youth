import 'package:kellychat/generated/json/succeed/smart_match_people_entity.g.dart';
import 'dart:convert';
import 'package:kellychat/utils/extension/maps/maps.dart';
export 'package:kellychat/generated/json/succeed/smart_match_people_entity.g.dart';

class SmartMatchPeopleEntity {
  int? total;
  List<SmartMatchPeopleList>? list;
  int? page;
  int? size;
  int? pages;

  SmartMatchPeopleEntity();

  factory SmartMatchPeopleEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $SmartMatchPeopleEntityFromJson(json);
    }
    return SmartMatchPeopleEntity();
  }

  Map<String, dynamic> toJson() => $SmartMatchPeopleEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

class SmartMatchPeopleList {
  int? userId;
  String? nickname;
  int? gender;
  int? age;
  String? avatar;
  String? city;
  List<dynamic>? tags;
  double? matchScore;

  SmartMatchPeopleList();

  factory SmartMatchPeopleList.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $SmartMatchPeopleListFromJson(json);
    }
    return SmartMatchPeopleList();
  }

  Map<String, dynamic> toJson() => $SmartMatchPeopleListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
