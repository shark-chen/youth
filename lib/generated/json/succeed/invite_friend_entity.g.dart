import 'package:kellychat/generated/json/convert/json_convert_content.dart';
import 'package:kellychat/modules/home/doing/doing_list/model/invite_friend_entity.dart';

InviteFriendEntity $InviteFriendEntityFromJson(Map<String, dynamic> json) {
  final InviteFriendEntity inviteFriendEntity = InviteFriendEntity();
  final String? inviteCode = jsonConvert.convert<String>(json['inviteCode']);
  if (inviteCode != null) {
    inviteFriendEntity.inviteCode = inviteCode;
  }
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    inviteFriendEntity.link = link;
  }
  final String? wechat = jsonConvert.convert<String>(json['wechat']);
  if (wechat != null) {
    inviteFriendEntity.wechat = wechat;
  }
  final String? command = jsonConvert.convert<String>(json['command']);
  if (command != null) {
    inviteFriendEntity.command = command;
  }
  return inviteFriendEntity;
}

Map<String, dynamic> $InviteFriendEntityToJson(InviteFriendEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['inviteCode'] = entity.inviteCode;
  data['link'] = entity.link;
  data['wechat'] = entity.wechat;
  data['command'] = entity.command;
  return data;
}

extension InviteFriendEntityExtension on InviteFriendEntity {
  InviteFriendEntity copyWith({
    String? inviteCode,
    String? link,
    String? wechat,
    String? command,
  }) {
    return InviteFriendEntity()
      ..inviteCode = inviteCode ?? this.inviteCode
      ..link = link ?? this.link
      ..wechat = wechat ?? this.wechat
      ..command = command ?? this.command;
  }
}