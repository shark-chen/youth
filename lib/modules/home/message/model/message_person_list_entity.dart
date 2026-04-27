import 'package:kellychat/generated/json/succeed/message_person_list_entity.g.dart';
import 'dart:convert';
import 'package:kellychat/utils/extension/maps/maps.dart';
export 'package:kellychat/generated/json/succeed/message_person_list_entity.g.dart';

class MessagePersonListEntity {
  int? conversationId;
  int? userId;
  String? nickname;
  String? avatar;
  String? lastMessage;
  String? lastMessageTime;
  int? unreadCount;
  String? lastMessageTimeRaw;

  MessagePersonListEntity();

  factory MessagePersonListEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $MessagePersonListEntityFromJson(json);
    }
    return MessagePersonListEntity();
  }

  Map<String, dynamic> toJson() => $MessagePersonListEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
