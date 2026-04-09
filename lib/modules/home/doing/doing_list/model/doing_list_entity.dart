import 'package:youth/generated/json/succeed/doing_list_entity.g.dart';
import 'dart:convert';
import 'package:youth/utils/extension/maps/maps.dart';
export 'package:youth/generated/json/succeed/doing_list_entity.g.dart';

class DoingListEntity {
  String? tagName;
  int? total;
  List<DoingListList>? list;

  DoingListEntity();

  factory DoingListEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $DoingListEntityFromJson(json);
    }
    return DoingListEntity();
  }

  Map<String, dynamic> toJson() => $DoingListEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

class DoingListList {
  int? userId;
  String? nickname;
  String? avatar;
  int? gender;
  String? birthday;
  String? city;
  String? signature;
  String? startTime;
  int? age;

  DoingListList();

  factory DoingListList.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $DoingListListFromJson(json);
    }
    return DoingListList();
  }

  Map<String, dynamic> toJson() => $DoingListListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
