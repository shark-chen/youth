import 'package:youth/generated/json/convert/json_convert_content.dart';
import 'package:youth/modules/home/hall/model/msg_entity.dart';

MsgEntity $MsgEntityFromJson(Map<String, dynamic> json) {
	final MsgEntity msgEntity = MsgEntity();
	final int? code = jsonConvert.convert<int>(json['code']);
	if (code != null) {
		msgEntity.code = code;
	}
	final int? data = jsonConvert.convert<int>(json['data']);
	if (data != null) {
		msgEntity.data = data;
	}
	final String? message = jsonConvert.convert<String>(json['message']);
	if (message != null) {
		msgEntity.message = message;
	}
	final bool? success = jsonConvert.convert<bool>(json['success']);
	if (success != null) {
		msgEntity.success = success;
	}
	final int? timestamp = jsonConvert.convert<int>(json['timestamp']);
	if (timestamp != null) {
		msgEntity.timestamp = timestamp;
	}
	return msgEntity;
}

Map<String, dynamic> $MsgEntityToJson(MsgEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['code'] = entity.code;
	data['data'] = entity.data;
	data['message'] = entity.message;
	data['success'] = entity.success;
	data['timestamp'] = entity.timestamp;
	return data;
}