import 'package:youth/modules/user/model/paid_goods_entity.dart';
import 'package:youth/generated/json/convert/json_convert_content.dart';

PaidGoodsEntity $PaidGoodsEntityFromJson(Map<String, dynamic> json) {
	final PaidGoodsEntity paidGoodsEntity = PaidGoodsEntity();
	final PaidGoodsItemEntity? facebookPageCount = jsonConvert.convert<PaidGoodsItemEntity>(json['facebook_page_count']);
	if (facebookPageCount != null) {
		paidGoodsEntity.facebookPageCount = facebookPageCount;
	}
	final PaidGoodsItemEntity? orderCount = jsonConvert.convert<PaidGoodsItemEntity>(json['order_count']);
	if (orderCount != null) {
		paidGoodsEntity.orderCount = orderCount;
	}
	final PaidGoodsItemEntity? shopCount = jsonConvert.convert<PaidGoodsItemEntity>(json['shop_count']);
	if (shopCount != null) {
		paidGoodsEntity.shopCount = shopCount;
	}
	final PaidGoodsItemEntity? accountCount = jsonConvert.convert<PaidGoodsItemEntity>(json['account_count']);
	if (accountCount != null) {
		paidGoodsEntity.accountCount = accountCount;
	}
	return paidGoodsEntity;
}

Map<String, dynamic> $PaidGoodsEntityToJson(PaidGoodsEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['facebook_page_count'] = entity.facebookPageCount?.toJson();
	data['order_count'] = entity.orderCount?.toJson();
	data['shop_count'] = entity.shopCount?.toJson();
	data['account_count'] = entity.accountCount?.toJson();
	return data;
}
