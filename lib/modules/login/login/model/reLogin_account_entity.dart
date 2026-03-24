import 'package:youth/generated/json/succeed/reLogin_account_entity.g.dart';
import 'dart:convert';
import 'package:youth/utils/extension/maps/maps.dart';
export 'package:youth/generated/json/succeed/reLogin_account_entity.g.dart';

class ReLoginAccountEntity {
  String? accountName;
  bool? agreeSaveAccount;

  ReLoginAccountEntity();

  factory ReLoginAccountEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $ReLoginAccountEntityFromJson(json);
    }
    return ReLoginAccountEntity();
  }

  Map<String, dynamic> toJson() => $ReLoginAccountEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
