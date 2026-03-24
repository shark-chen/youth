import 'package:youth/generated/json/convert/json_convert_content.dart';
import 'package:youth/modules/user/model/push_entity.dart';
import 'dart:convert' as convert;

PushEntity $PushEntityFromJson(Map<String, dynamic> json) {
  final PushEntity pushEntity = PushEntity();
  final String? home = jsonConvert.convert<String>(json['home']);
  if (home != null) {
    pushEntity.home = home;
  }
  final String? route = jsonConvert.convert<String>(json['route']);
  if (route != null) {
    pushEntity.route = route;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    pushEntity.title = title;
  }
  try {
    if (json['params'] != null && json['params'] is Map) {
      pushEntity.params = json['params'];
    } else {
      final String? params = jsonConvert.convert<String>(json['params']);
      if (params != null) {
        pushEntity.params =
            jsonConvert.convert<Map>(convert.json.decode(params));
      }
    }
  } catch (_) {}
  try {
    if (json['params'] != null && json['params'] is Map) {
      pushEntity.parameters = jsonConvert
          .convert<Map>(json['params'])
          ?.map((key, value) => MapEntry(key, value.toString()));
    } else {
      final String? params = jsonConvert.convert<String>(json['params']);
      if (params != null) {
        pushEntity.parameters = jsonConvert
            .convert<Map>(convert.json.decode(params))
            ?.map((key, value) => MapEntry(key, value.toString()));
      }
    }
  } catch (_) {}
  return pushEntity;
}

Map<String, dynamic> $PushEntityToJson(PushEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['home'] = entity.home;
  data['route'] = entity.route;
  data['title'] = entity.title;
  data['params'] = entity.params;
  return data;
}
