import 'dart:io';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

/// FileName location_util
///
/// @Author 谌文
/// @Date 2026/4/23 20:14
///
/// @Description 获取当前设备定位，并解析为省/市/区三字段。
class LocationUtil {
  /// 获取当前设备定位，并解析为省/市/区三字段。
  ///
  /// 说明：
  /// - 会触发 iOS/Android 的定位权限申请（使用 permission_handler）
  /// - 若系统定位未开启，会抛出异常（可由业务侧引导打开系统定位）
  static Future<ProvinceCityDistrict> getProvinceCityDistrict({
    LocationAccuracy accuracy = LocationAccuracy.high,
    Duration timeLimit = const Duration(seconds: 10),
  }) async {
    /// 定位权限
    final hasPermission = await _ensureLocationPermission();
    if (!hasPermission) {
      throw const LocationUtilException('定位权限未授权');
    }
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw const LocationUtilException('系统定位服务未开启');
    }
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: accuracy,
      timeLimit: timeLimit,
    );
    final placeMarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (placeMarks.isEmpty) {
      throw const LocationUtilException('反地理编码失败：无可用地址信息');
    }
    final p = placeMarks.first;

    /// iOS/Android 在不同国家/地区返回字段有差异：
    /// - 中国大陆常见：administrativeArea=省，locality=市，subLocality=区/县
    /// - 有些机型：locality 为空，可能在 subAdministrativeArea 里
    final province = (p.administrativeArea ?? '').trim();
    final city = (p.locality ?? p.subAdministrativeArea ?? '').trim();
    final district = (p.subLocality ?? '').trim();
    return ProvinceCityDistrict(
      province: province,
      city: city,
      district: district,
    );
  }

  /// 申请定位权限
  static Future<bool> _ensureLocationPermission() async {
    final Permission permission =
        Platform.isIOS ? Permission.locationWhenInUse : Permission.location;
    final status = await permission.status;
    if (status.isGranted || status.isLimited) return true;
    final req = await permission.request();
    return req.isGranted || req.isLimited;
  }
}

/// FileName LocationUtilException
///
/// @Author 谌文
/// @Date 2023/5/4 20:14
///
/// @Description 异常报错
class LocationUtilException implements Exception {
  final String message;

  const LocationUtilException(this.message);

  @override
  String toString() => 'LocationUtilException: $message';
}

/// FileName ProvinceCityDistrict
///
/// @Author 谌文
/// @Date 2023/5/4 20:14
///
/// @Description 点击工具类
class ProvinceCityDistrict {
  final String province;
  final String city;
  final String district;

  const ProvinceCityDistrict({
    required this.province,
    required this.city,
    required this.district,
  });

  Map<String, dynamic> toJson() => {
        'province': province,
        'city': city,
        'district': district,
      };

  @override
  String toString() => 'ProvinceCityDistrict(${toJson()})';
}
