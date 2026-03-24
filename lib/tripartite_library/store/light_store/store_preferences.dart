import 'package:youth/base/base_controller.dart';

/// FileName store_preferences
///
/// @Author 谌文
/// @Date 2023/9/20 16:49
///
/// @Description 轻量数据存储
/// 轻量存储类
class StorePreferences {
  static StorePreferences? _instance;

  factory StorePreferences() {
    _instance ??= StorePreferences._();
    return _instance!;
  }

  StorePreferences._();

  /// 存储数据本地类
  static SharedPreferences? _prefs;

  Future<SharedPreferences> get prefs async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  /// 清除缓存
  Future<bool> clear() async {
    return (await prefs).clear();
  }

  /// 获取存储key
  String _getKey(String key, {bool? userLat}) {
    if (userLat ?? true) {
      if (UserCenter().user?.uid != null) {
        return "${key}_${UserCenter().user?.uid}";
      }
    }
    return key.toString();
  }

  /// bool + 获取存储的值
  /// userLat: 是否存储以用户纬度
  Future<bool?> getBool(String key, {bool? userLat, bool? defValue}) async {
    try {
      return (await prefs).getBool(_getKey(key, userLat: userLat)) ?? defValue;
    } catch (_) {
      return defValue;
    } finally {}
  }

  /// bool + 存储值
  /// userLat: 是否存储以用户纬度
  Future<bool> setBool(String key, bool value, {bool? userLat}) async {
    try {
      return await (await prefs).setBool(_getKey(key, userLat: userLat), value);
    } catch (_) {
      return false;
    } finally {}
  }

  /// int + 获取存储的值
  /// userLatitude: 是否存储以用户纬度
  Future<int?> getInt(String key, {bool? userLat}) async {
    try {
      return (await prefs).getInt(_getKey(key, userLat: userLat));
    } catch (_) {
      return null;
    } finally {}
  }

  /// int + 存储值
  /// userLat: 是否存储以用户纬度
  Future<bool> setInt(String key, int value, {bool? userLat}) async {
    try {
      return await (await prefs).setInt(_getKey(key, userLat: userLat), value);
    } catch (_) {
      return false;
    } finally {}
  }

  /// double + 获取存储的值
  /// userLatitude: 是否存储以用户纬度
  Future<double?> getDouble(String key, {bool? userLat}) async {
    try {
      return (await prefs).getDouble(_getKey(key, userLat: userLat));
    } catch (_) {
      return null;
    } finally {}
  }

  /// double + 存储值
  /// userLat: 是否存储以用户纬度
  Future<bool> setDouble(String key, double value, {bool? userLat}) async {
    try {
      return await (await prefs)
          .setDouble(_getKey(key, userLat: userLat), value);
    } catch (_) {
      return false;
    } finally {}
  }

  /// String + 获取存储的值
  /// userLat: 是否存储以用户纬度
  Future<String?> getString(String key, {bool? userLat}) async {
    try {
      return (await prefs).getString(_getKey(key, userLat: userLat));
    } catch (_) {
      return null;
    } finally {}
  }

  /// String + 存储值
  /// userLat: 是否存储以用户纬度 + 默认true
  Future<bool> setString(
    String key,
    String value, {
    bool? userLat,
  }) async {
    try {
      return await (await prefs)
          .setString(_getKey(key, userLat: userLat), value);
    } catch (_) {
      return false;
    } finally {}
  }

  /// List<String> + 获取存储的值
  /// userLat: 是否存储以用户纬度 + 默认true
  Future<List<String>?> getStringList(
    String key, {
    bool? userLat,
  }) async {
    try {
      return ((await prefs).getStringList(_getKey(key, userLat: userLat)));
    } catch (_) {
      return [];
    } finally {}
  }

  /// List<String> + 存储值
  /// userLat: 是否存储以用户纬度 + 默认true
  Future<bool> setStringList(
    String key,
    List<String> list, {
    bool? userLat,
  }) async {
    try {
      return await (await prefs)
          .setStringList(_getKey(key, userLat: userLat), list);
    } catch (_) {
      return false;
    } finally {}
  }
}
