import 'dart:convert';

class Json {
  static String toJson(dynamic obj) {
    return json.encode(obj,
        toEncodable: (item) =>
            (item is DateTime) ? item.toIso8601String() : item);
  }
}
