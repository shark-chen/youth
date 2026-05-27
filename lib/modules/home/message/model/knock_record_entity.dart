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

  /// sent=我敲了对方，received=对方敲了我
  String? direction;
  int? targetUserId;
  String? targetNickname;
  String? targetAvatar;
  String? interactionDesc;
  String? tagName;
  String? timeAgo;
  bool? isRead;
  String? createdAt;

  /// 0 未知 1 男 2 女
  int? gender;

  /// 自定义字段
  String? beatStr;

  KnockRecordItems();

  factory KnockRecordItems.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      final result = $KnockRecordItemsFromJson(json);
      result.beatStr = result.direction == 'sent' ? '我敲了下TA' : 'TA敲了下我';
      return result;
    }
    return KnockRecordItems();
  }

  Map<String, dynamic> toJson() => $KnockRecordItemsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
