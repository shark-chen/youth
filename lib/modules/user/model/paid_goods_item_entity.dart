import 'package:youth/generated/json/succeed/paid_goods_item_entity.g.dart';
import 'dart:convert';
import '../../../utils/extension/maps/maps.dart';

class PaidGoodsItemEntity {
	int? totalNum;
	int? currentNum;

	PaidGoodsItemEntity();

	factory PaidGoodsItemEntity.fromJson(dynamic json) {
		if (Maps.isNotEmpty(json)) {
			return $PaidGoodsItemEntityFromJson(json);
		}
		return PaidGoodsItemEntity();
	}

	Map<String, dynamic> toJson() => $PaidGoodsItemEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}