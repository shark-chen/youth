import 'package:get/get.dart';
import '../generated/locales.g.dart';
import '../utils/utils/model_utils.dart';
import 'package:dio/dio.dart' as Api;

/// code : 0
/// msg : "Successful"
/// data : true

class ApiResult<T> {
  int? code;
  int? errorType;
  String? msg;
  T? data;
  Api.Response? response;

  ApiResult({
    this.code,
    this.errorType,
    this.msg,
    this.data,
  });

  ApiResult.fromJson(dynamic json) {
    try {
      code = -1;
      final int? jsonCode = ModelUtils.convert<int>(json['code']);
      if (jsonCode != null) {
        code = jsonCode;
      }

      if(jsonCode != 0) {
        print(jsonCode);
      }

      errorType = -1;
      final int? jsonErrorType = ModelUtils.convert<int>(json['errorType']);
      if (jsonErrorType != null) {
        errorType = jsonErrorType;
      }
      msg =
          ModelUtils.convert<String>(json['msg']) ?? LocaleKeys.NetworkError.tr;
      data = json['data'];
    } catch (e) {
      code = -1;
      msg =
          ModelUtils.convert<String>(json['msg']) ?? LocaleKeys.NetworkError.tr;
      data = json['data'];
    }
  }

  ApiResult.fail() {
    code = -1;
    msg = LocaleKeys.NetworkError.tr;
    data = null;
  }

  ApiResult.success() {
    code = 0;
    msg = null;
    data = null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['msg'] = msg;
    map['data'] = data;
    return map;
  }

  ApiResult.copy(ApiResult apiResult, {bool ignoreData = false}) {
    code = apiResult.code;
    msg = apiResult.msg;
    errorType = apiResult.errorType;
    if (!ignoreData) {
      data = apiResult.data;
    }
  }

  @override
  String toString() {
    return 'ApiResult{code: $code, errorType: $errorType,,msg: $msg, data: $data}';
  }
}
