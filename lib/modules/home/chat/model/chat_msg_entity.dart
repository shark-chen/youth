import 'package:kellychat/generated/json/base/json_field.dart';
import 'package:kellychat/generated/json/succeed/chat_msg_entity.g.dart';
import 'dart:convert';
import 'package:kellychat/utils/extension/maps/maps.dart';
export 'package:kellychat/generated/json/succeed/chat_msg_entity.g.dart';

class ChatMsgEntity {
  bool? hasMore;
  List<ChatMsgList>? list;

  ChatMsgEntity();

  factory ChatMsgEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $ChatMsgEntityFromJson(json);
    }
    return ChatMsgEntity();
  }

  Map<String, dynamic> toJson() => $ChatMsgEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

class ChatMsgList {
  int? type;
  int? messageId;
  int? fromUserId;
  String? fromNickname;
  String? fromAvatar;
  int? toUserId;
  int? contentType;
  String? content;
  bool? isRead;
  String? createdAt;

  ChatMsgList();

  factory ChatMsgList.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $ChatMsgListFromJson(json);
    }
    return ChatMsgList();
  }

  Map<String, dynamic> toJson() => $ChatMsgListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
