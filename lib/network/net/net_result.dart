import 'package:dio/dio.dart';
import '../../generated/locales.g.dart';
import '../../utils/extension/lists/lists.dart';
import '../../utils/extension/maps/maps.dart';
import '../../utils/utils/model_utils.dart';
import 'package:get/get.dart' as getX;

/// FileName net_result
///
/// @Author 谌文
/// @Date 2024/4/22 11:30
///
/// @Description 网络请求结果类
class NetResult<T> {
  NetResult({
    this.code,
    this.errorType,
    this.msg,
    this.data,
    this.response,
  });

  int? code;
  int? errorType;
  String? msg;
  String? message;
  T? data;

  /// 返回回来的data是个List列表
  List<T>? list;

  /// 原始数据
  Response? response;

  /// 解析dio网络数据
  NetResult.fromResponse(Response? response) {
    try {
      Map json = ModelUtils.convert<Map>(response?.data) ?? {};
      code = ModelUtils.convert<int>(json['code']) ?? -1;
      errorType = ModelUtils.convert<int>(json['errorType']) ?? -1;
      msg = ModelUtils.convert<String>(json['msg']) ??
          (code != 0 ? LocaleKeys.NetworkError.tr : '');
      message = ModelUtils.convert<String>(json['msg']);
      String type = T.toString().toLowerCase();
      if (type.contains('dynamic') || type.contains('object')) {
        data = json['data'];
      } else if (json['data'] != null && json['data'] is List) {
        list = ModelUtils.convertListNotNull<T>(json['data']) ?? json['data'];
      } else if (json['data'] != null && json['data'] is Map) {
        data = ModelUtils.convert<T>(json['data']) ?? json['data'];
      } else {
        data = ModelUtils.convert<T>(json['data']);
      }
    } catch (_) {
      data = {} as T?;
    } finally {
      this.response = response;
    }
  }

  /// 解析dio网络数据
  /// isList: 当传入的泛型S，需要转成模型List时候，isList = true
  NetResult.fromJson(dynamic json) {
    if (Maps.isNotEmpty(json)) {
      try {
        code = ModelUtils.convert<int>(json['code']) ?? -1;
        errorType = ModelUtils.convert<int>(json['errorType']) ?? -1;
        msg = ModelUtils.convert<String>(json['msg']) ??
            (code != 0 ? LocaleKeys.NetworkError.tr : '');
        message = ModelUtils.convert<String>(json['msg']);
        String type = T.toString().toLowerCase();
        if (type.contains('dynamic') || type.contains('object')) {
          data = json['data'];
        } else if (json['data'] != null && json['data'] is List) {
          list = ModelUtils.convertListNotNull<T>(json['data']) ?? json['data'];
        } else if (json['data'] != null && json['data'] is Map) {
          data = ModelUtils.convert<T>(json['data']) ?? json['data'];
        } else {
          data = ModelUtils.convert<T>(json['data']);
        }
      } catch (_) {
        data = (json['data'] ?? {});
      }
    }
  }

  /// 创建成功返回数据
  NetResult.success() {
    code = 0;
    msg = null;
    message = null;
    data = null;
  }

  /// 创建错误返回数据
  NetResult.error({String? msg, String? message}) {
    code = -101;
    this.msg = msg;
    this.message = message;
    data = null;
  }

  /// 获取非空解析数据包
  T? get value {
    if (data != null) return data as T;
    return data;
  }

  /// 获取非空解析数据包
  List<T> get values => list ?? [];

  /// 成功并且data不为空
  bool get success => code == 0 && this.response?.data != null;

  /// 成功并且data不为空
  bool get succeed => code == 0 && (value != null || Lists.isNotEmpty(values));

  @override
  String toString() =>
      'Response:  {code: $code, errorType: $errorType,msg: $msg, data: $data}';
}
