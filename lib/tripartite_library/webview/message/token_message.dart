import 'dart:convert';

class TokenMessage {
  String? handler;
  String? accessToken;

  TokenMessage({this.handler, this.accessToken});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{"handler": handler, "accessToken": accessToken};
  }

  TokenMessage.fromMap(dynamic map) {
    handler = map["handler"];
    accessToken = map["accessToken"];
  }

  String toJson() => json.encode(toMap());

  factory TokenMessage.fromJson(String source) {
    return TokenMessage.fromMap(json.decode(source));
  }
}
