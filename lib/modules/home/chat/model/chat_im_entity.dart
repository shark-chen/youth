import 'package:kellychat/generated/json/succeed/chat_im_entity.g.dart';
import 'dart:convert';
import 'package:kellychat/utils/extension/maps/maps.dart';
export 'package:kellychat/generated/json/succeed/chat_im_entity.g.dart';

class ChatImEntity {
	String? type;
	int? messageId;
	String? fromUserId;
	String? fromNickname;
	String? fromAvatar;
	int? contentType;
	String? content;
	String? createdAt;

	ChatImEntity();

	factory ChatImEntity.fromJson(dynamic json) {
		if (Maps.isNotEmpty(json)) {
			return $ChatImEntityFromJson(json);
		}
		return ChatImEntity();
	}

	Map<String, dynamic> toJson() => $ChatImEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}