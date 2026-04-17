import 'package:youth/generated/json/convert/json_convert_content.dart';
import 'package:youth/modules/home/mine/edit_mine_info/model/user_private_info_entity.dart';

UserPrivateInfoEntity $UserPrivateInfoEntityFromJson(
    Map<String, dynamic> json) {
  final UserPrivateInfoEntity userPrivateInfoEntity = UserPrivateInfoEntity();
  final String? wishDescription = jsonConvert.convert<String>(
      json['wishDescription']);
  if (wishDescription != null) {
    userPrivateInfoEntity.wishDescription = wishDescription;
  }
  final bool? hasPassword = jsonConvert.convert<bool>(json['hasPassword']);
  if (hasPassword != null) {
    userPrivateInfoEntity.hasPassword = hasPassword;
  }
  return userPrivateInfoEntity;
}

Map<String, dynamic> $UserPrivateInfoEntityToJson(
    UserPrivateInfoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['wishDescription'] = entity.wishDescription;
  data['hasPassword'] = entity.hasPassword;
  return data;
}

extension UserPrivateInfoEntityExtension on UserPrivateInfoEntity {
  UserPrivateInfoEntity copyWith({
    String? wishDescription,
    bool? hasPassword,
  }) {
    return UserPrivateInfoEntity()
      ..wishDescription = wishDescription ?? this.wishDescription
      ..hasPassword = hasPassword ?? this.hasPassword;
  }
}