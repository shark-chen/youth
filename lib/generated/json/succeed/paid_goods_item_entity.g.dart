import 'package:youth/generated/json/convert/json_convert_content.dart';
import 'package:youth/modules/user/model/paid_goods_item_entity.dart';

PaidGoodsItemEntity $PaidGoodsItemEntityFromJson(Map<String, dynamic> json) {
	final PaidGoodsItemEntity paidGoodsItemEntity = PaidGoodsItemEntity();
	final int? totalNum = jsonConvert.convert<int>(json['totalNum']);
	if (totalNum != null) {
		paidGoodsItemEntity.totalNum = totalNum;
	}
	final int? currentNum = jsonConvert.convert<int>(json['currentNum']);
	if (currentNum != null) {
		paidGoodsItemEntity.currentNum = currentNum;
	}
	return paidGoodsItemEntity;
}

Map<String, dynamic> $PaidGoodsItemEntityToJson(PaidGoodsItemEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['totalNum'] = entity.totalNum;
	data['currentNum'] = entity.currentNum;
	return data;
}