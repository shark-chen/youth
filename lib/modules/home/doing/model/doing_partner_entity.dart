import 'package:kellychat/generated/json/succeed/doing_partner_entity.g.dart';
import 'dart:convert';
import 'package:kellychat/utils/extension/maps/maps.dart';
export 'package:kellychat/generated/json/succeed/doing_partner_entity.g.dart';

class DoingPartnerEntity {
  int? userId;
  String? nickname;

  DoingPartnerEntity();

  factory DoingPartnerEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $DoingPartnerEntityFromJson(json);
    }
    return DoingPartnerEntity();
  }

  Map<String, dynamic> toJson() => $DoingPartnerEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
