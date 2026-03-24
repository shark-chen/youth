import 'package:flutter_udid/flutter_udid.dart';

/// FileName: udid_util
///
/// @Author 谌文
/// @Date 2026/3/5 20:24
///
/// @Description 设备唯一ID
class UdidUtil {
  static final UdidUtil _instance = UdidUtil._internal();

  UdidUtil._internal();

  factory UdidUtil() {
    return _instance;
  }

  String? _udid;

  /// 获取设备唯一码
  Future<String> get udid async {
    return _udid ?? await FlutterUdid.udid;
  }
}
