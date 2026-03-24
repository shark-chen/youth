import 'package:youth/generated/json/convert/json_convert_content.dart';
import 'package:youth/modules/home/mine/model/mine_entity.dart';
import 'package:youth/modules/home/hall/model/hall_item_entity.dart';

MineEntity $MineEntityFromJson(Map<String, dynamic> json) {
	final MineEntity mineEntity = MineEntity();
	final List<HallItemEntity>? iD = jsonConvert.convertListNotNull<HallItemEntity>(json['ID']);
	if (iD != null) {
		mineEntity.iD = iD;
	}
	final List<HallItemEntity>? eN = jsonConvert.convertListNotNull<HallItemEntity>(json['EN']);
	if (eN != null) {
		mineEntity.eN = eN;
	}
	final List<HallItemEntity>? zH = jsonConvert.convertListNotNull<HallItemEntity>(json['ZH']);
	if (zH != null) {
		mineEntity.zH = zH;
	}
	final List<HallItemEntity>? tH = jsonConvert.convertListNotNull<HallItemEntity>(json['TH']);
	if (tH != null) {
		mineEntity.tH = tH;
	}
	final List<HallItemEntity>? vN = jsonConvert.convertListNotNull<HallItemEntity>(json['VN']);
	if (vN != null) {
		mineEntity.vN = vN;
	}
	return mineEntity;
}

Map<String, dynamic> $MineEntityToJson(MineEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['ID'] =  entity.iD;
	data['EN'] =  entity.eN;
	data['ZH'] =  entity.zH;
	data['TH'] =  entity.tH;
	data['VN'] =  entity.vN;
	return data;
}