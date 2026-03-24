import 'package:youth/generated/json/succeed/authority_entity.g.dart';
import 'dart:convert';
import 'package:youth/utils/extension/maps/maps.dart';
export 'package:youth/generated/json/succeed/authority_entity.g.dart';

class AuthorityEntity {
  /// 0 正常，1订单超限，2店铺超限， 3是倒计时， 4是只拦截订单
  int? overDueType;
  int? orderLimitDays;
  int? shopLimitNum;

  /// 是给APP的
  String? appTips;

  AuthorityEntity();

  factory AuthorityEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $AuthorityEntityFromJson(json);
    }
    return AuthorityEntity();
  }

  Map<String, dynamic> toJson() => $AuthorityEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
