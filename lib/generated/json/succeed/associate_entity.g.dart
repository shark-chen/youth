import 'package:youth/generated/json/convert/json_convert_content.dart';
import 'package:youth/modules/home/common/model/associate_entity.dart';

AssociateEntity $AssociateEntityFromJson(Map<String, dynamic> json) {
	final AssociateEntity associateEntity = AssociateEntity();
	final int? type = jsonConvert.convert<int>(json['type']);
	if (type != null) {
		associateEntity.type = type;
	}
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		associateEntity.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		associateEntity.name = name;
	}
	final int? skuId = jsonConvert.convert<int>(json['skuId']);
	if (skuId != null) {
		associateEntity.skuId = skuId;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		associateEntity.title = title;
	}
	final String? sku = jsonConvert.convert<String>(json['sku']);
	if (sku != null) {
		associateEntity.sku = sku;
	}
	return associateEntity;
}

Map<String, dynamic> $AssociateEntityToJson(AssociateEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['type'] = entity.type;
	data['id'] = entity.id;
	data['name'] = entity.name;
	return data;
}