import 'package:kellychat/generated/json/convert/json_convert_content.dart';
import 'package:kellychat/modules/home/doing/model/doing_partner_entity.dart';

DoingPartnerEntity $DoingPartnerEntityFromJson(Map<String, dynamic> json) {
  final DoingPartnerEntity doingPartnerEntity = DoingPartnerEntity();
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    doingPartnerEntity.userId = userId;
  }
  final int? togetherId = jsonConvert.convert<int>(json['togetherId']);
  if (togetherId != null) {
    doingPartnerEntity.togetherId = togetherId;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    doingPartnerEntity.nickname = nickname;
  }
  return doingPartnerEntity;
}

Map<String, dynamic> $DoingPartnerEntityToJson(DoingPartnerEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userId'] = entity.userId;
  data['togetherId'] = entity.togetherId;
  data['nickname'] = entity.nickname;
  return data;
}

extension DoingPartnerEntityExtension on DoingPartnerEntity {
  DoingPartnerEntity copyWith({
    int? userId,
    String? nickname,
  }) {
    return DoingPartnerEntity()
      ..userId = userId ?? this.userId
      ..togetherId = togetherId ?? this.togetherId
      ..nickname = nickname ?? this.nickname;
  }
}
