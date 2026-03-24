import 'package:youth/base/base_model_entity.dart';
import 'package:youth/generated/json/convert/json_convert_content.dart';

BaseModelEntity $BaseModelEntityFromJson(Map<String, dynamic> json) {
	final BaseModelEntity baseModelEntity = BaseModelEntity();
	final int? code = jsonConvert.convert<int>(json['code']);
	if (code != null) {
		baseModelEntity.code = code;
	}
	final String? msg = jsonConvert.convert<String>(json['msg']);
	if (msg != null) {
		baseModelEntity.msg = msg;
	}
	final String? platformMsg = jsonConvert.convert<String>(json['platformMsg']);
	if (platformMsg != null) {
		baseModelEntity.platformMsg = platformMsg;
	}
	final String? defaultMsg = jsonConvert.convert<String>(json['defaultMsg']);
	if (defaultMsg != null) {
		baseModelEntity.defaultMsg = defaultMsg;
	}
	final dynamic data = jsonConvert.convert<dynamic>(json['data']);
	if (data != null) {
		baseModelEntity.data = data;
	}
	final dynamic detail = jsonConvert.convert<dynamic>(json['detail']);
	if (detail != null) {
		baseModelEntity.detail = detail;
	}
	final bool? success = jsonConvert.convert<bool>(json['success']);
	if (success != null) {
		baseModelEntity.success = success;
	}
	final int? errorType = jsonConvert.convert<int>(json['errorType']);
	if (errorType != null) {
		baseModelEntity.errorType = errorType;
	}
	return baseModelEntity;
}

Map<String, dynamic> $BaseModelEntityToJson(BaseModelEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['code'] = entity.code;
	data['msg'] = entity.msg;
	data['platformMsg'] = entity.platformMsg;
	data['defaultMsg'] = entity.defaultMsg;
	data['data'] = entity.data;
	data['detail'] = entity.detail;
	data['success'] = entity.success;
	return data;
}