import 'package:youth/generated/json/succeed/push_entity.g.dart';
import 'dart:convert' as convert;
import '../../../utils/extension/maps/maps.dart';

class PushEntity {
  String? home;
  String? route;
  String? title;
  Map? params;
  Map<String, String>? parameters;

  PushEntity();

  factory PushEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $PushEntityFromJson(json);
    } else {
      return $PushEntityFromJson(convert.json.decode(json));
    }
  }

  Map<String, dynamic> toJson() => $PushEntityToJson(this);

  @override
  String toString() {
    return convert.jsonEncode(this);
  }
}
