import 'package:youth/generated/json/succeed/beat_item_entity.g.dart';
import 'dart:convert';
import 'package:youth/utils/extension/maps/maps.dart';
export 'package:youth/generated/json/succeed/beat_item_entity.g.dart';

class BeatItemEntity {
  int? knockId;
  int? fromUserId;
  String? fromNickname;
  String? fromAvatar;
  String? tagName;
  String? statusMessage;
  bool? isRead;
  String? createdAt;

  BeatItemEntity();

  factory BeatItemEntity.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      return $BeatItemEntityFromJson(json);
    }
    return BeatItemEntity();
  }

  Map<String, dynamic> toJson() => $BeatItemEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
