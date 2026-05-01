import 'package:kellychat/generated/json/succeed/knock_record_entity.g.dart';
import 'dart:convert';
import 'package:kellychat/utils/extension/maps/maps.dart';
export 'package:kellychat/generated/json/succeed/knock_record_entity.g.dart';

class KnockRecordEntity {
	int? unreadCount;
	List<KnockRecordItems>? items;

	KnockRecordEntity();

	factory KnockRecordEntity.fromJson(dynamic json) {
		if (Maps.isNotEmpty(json)) {
			return $KnockRecordEntityFromJson(json);
		}
		return KnockRecordEntity();
	}

	Map<String, dynamic> toJson() => $KnockRecordEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

class KnockRecordItems {
	int? knockId;
	String? direction;
	int? targetUserId;
	String? targetNickname;
	String? targetAvatar;
	String? interactionDesc;
	String? tagName;
	String? timeAgo;
	bool? isRead;
	String? createdAt;

	KnockRecordItems();

	factory KnockRecordItems.fromJson(dynamic json) {
		if (Maps.isNotEmpty(json)) {
			return $KnockRecordItemsFromJson(json);
		}
		return KnockRecordItems();
	}

	Map<String, dynamic> toJson() => $KnockRecordItemsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}