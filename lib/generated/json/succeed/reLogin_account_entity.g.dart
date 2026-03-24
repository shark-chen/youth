import 'package:youth/generated/json/convert/json_convert_content.dart';
import 'package:youth/modules/login/login/model/reLogin_account_entity.dart';

ReLoginAccountEntity $ReLoginAccountEntityFromJson(Map<String, dynamic> json) {
  final ReLoginAccountEntity reLoginAccountEntity = ReLoginAccountEntity();
  final String? accountName = jsonConvert.convert<String>(json['accountName']);
  if (accountName != null) {
    reLoginAccountEntity.accountName = accountName;
  }
  final bool? agreeSaveAccount = jsonConvert.convert<bool>(
      json['agreeSaveAccount']);
  if (agreeSaveAccount != null) {
    reLoginAccountEntity.agreeSaveAccount = agreeSaveAccount;
  }
  return reLoginAccountEntity;
}

Map<String, dynamic> $ReLoginAccountEntityToJson(ReLoginAccountEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['accountName'] = entity.accountName;
  data['agreeSaveAccount'] = entity.agreeSaveAccount;
  return data;
}

extension ReloginAccountEntityExtension on ReLoginAccountEntity {
  ReLoginAccountEntity copyWith({
    String? accountName,
    bool? agreeSaveAccount,
  }) {
    return ReLoginAccountEntity()
      ..accountName = accountName ?? this.accountName
      ..agreeSaveAccount = agreeSaveAccount ?? this.agreeSaveAccount;
  }
}