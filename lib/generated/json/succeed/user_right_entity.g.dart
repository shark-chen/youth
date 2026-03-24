import 'package:youth/modules/user/user_center/user_permissions/model/user_right_entity.dart';
import 'package:youth/tripartite_library/tripartite_library.dart';

UserRightEntity $UserRightEntityFromJson(Map<String, dynamic> json) {
  final UserRightEntity userRightEntity = UserRightEntity();
  final int? version = jsonConvert.convert<int>(json['version']);
  if (version != null) {
    userRightEntity.version = version;
  }
  final bool? subAdmin = jsonConvert.convert<bool>(json['subAdmin']);
  if (subAdmin != null) {
    userRightEntity.subAdmin = subAdmin;
  }
  if(Maps.isNotEmpty(json['userScopeMap'])) {
    Map<String, dynamic> rawMap = json['userScopeMap'] as Map<String, dynamic>;
    Map<String, UserRightVersionEntity> userScopeMap = rawMap.map(
          (key, value) => MapEntry(
        key,
        jsonConvert.convert<UserRightVersionEntity>(value) ?? UserRightVersionEntity(),
      ),
    );
    userRightEntity.userScopeMap = userScopeMap;
  }
  return userRightEntity;
}

Map<String, dynamic> $UserRightEntityToJson(UserRightEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['version'] = entity.version;
  data['subAdmin'] = entity.subAdmin;
  return data;
}

extension UserRightEntityExtension on UserRightEntity {
  UserRightEntity copyWith({
    int? version,
    bool? subAdmin,
  }) {
    return UserRightEntity()
      ..version = version ?? this.version
      ..subAdmin = subAdmin ?? this.subAdmin;
  }
}

UserRightVersionEntity $UserRightVersionEntityFromJson(
    Map<String, dynamic> json) {
  final UserRightVersionEntity userRightVersionEntity =
      UserRightVersionEntity();
  final int? version = jsonConvert.convert<int>(json['version']);
  if (version != null) {
    userRightVersionEntity.version = version;
  }
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    userRightVersionEntity.value = value;
  }
  return userRightVersionEntity;
}

Map<String, dynamic> $UserRightVersionEntityToJson(
    UserRightVersionEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['version'] = entity.version;
  data['value'] = entity.value;
  return data;
}

extension UserRightVersionEntityExtension on UserRightVersionEntity {
  UserRightVersionEntity copyWith({
    int? version,
    String? value,
  }) {
    return UserRightVersionEntity()
      ..version = version ?? this.version
      ..value = value ?? this.value;
  }
}
