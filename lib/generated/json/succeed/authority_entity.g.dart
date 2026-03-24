import 'package:youth/generated/json/convert/json_convert_content.dart';
import 'package:youth/modules/user/user_center/authority/model/authority_entity.dart';

AuthorityEntity $AuthorityEntityFromJson(Map<String, dynamic> json) {
  final AuthorityEntity authorityEntity = AuthorityEntity();
  final int? overDueType = jsonConvert.convert<int>(json['overDueType']);
  if (overDueType != null) {
    authorityEntity.overDueType = overDueType;
  }
  final int? orderLimitDays = jsonConvert.convert<int>(json['orderLimitDays']);
  if (orderLimitDays != null) {
    authorityEntity.orderLimitDays = orderLimitDays;
  }
  final int? shopLimitNum = jsonConvert.convert<int>(json['shopLimitNum']);
  if (shopLimitNum != null) {
    authorityEntity.shopLimitNum = shopLimitNum;
  }
  final String? appTips = jsonConvert.convert<String>(json['appTips']);
  if (appTips != null) {
    authorityEntity.appTips = appTips;
  }
  return authorityEntity;
}

Map<String, dynamic> $AuthorityEntityToJson(AuthorityEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['overDueType'] = entity.overDueType;
  data['orderLimitDays'] = entity.orderLimitDays;
  data['shopLimitNum'] = entity.shopLimitNum;
  data['appTips'] = entity.appTips;
  return data;
}

extension AuthorityEntityExtension on AuthorityEntity {
  AuthorityEntity copyWith({
    int? overDueType,
    int? orderLimitDays,
    int? shopLimitNum,
    String? appTips,
  }) {
    return AuthorityEntity()
      ..overDueType = overDueType ?? this.overDueType
      ..orderLimitDays = orderLimitDays ?? this.orderLimitDays
      ..shopLimitNum = shopLimitNum ?? this.shopLimitNum
      ..appTips = appTips ?? this.appTips;
  }
}