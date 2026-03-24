import 'package:youth/generated/json/succeed/paid_goods_entity.g.dart';
import 'dart:convert';
import '../../../utils/extension/maps/maps.dart';
import 'paid_goods_item_entity.dart';
export 'paid_goods_item_entity.dart';

class PaidGoodsEntity {
	PaidGoodsItemEntity? facebookPageCount;
	PaidGoodsItemEntity? orderCount;
	PaidGoodsItemEntity? shopCount;
	PaidGoodsItemEntity? accountCount;

	PaidGoodsEntity();

	factory PaidGoodsEntity.fromJson(dynamic json) {
		if (Maps.isNotEmpty(json)) {
			return $PaidGoodsEntityFromJson(json);
		}
		return PaidGoodsEntity();
	}

	Map<String, dynamic> toJson() => $PaidGoodsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
